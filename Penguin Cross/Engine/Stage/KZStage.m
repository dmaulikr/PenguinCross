//
//  GLViewController.m
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "KZStage.h"
#import "KZScreen.h"
#import "KZRenderer.h"
#import "Stack.h"
#import "KZScene.h"
#import "OALSimpleAudio.h"
#import "KZAsset.h"

static KZStage *stage;

@interface KZStage ()
@property (strong, nonatomic) KZRenderer *renderer;
@property (strong, nonatomic) KZView *touchedView;
@property (strong, nonatomic) Stack *scenes;
@property (strong, nonatomic) OALSimpleAudio *speaker;
@property (nonatomic) NSInteger touchesHeld;
@property (nonatomic, strong) UIAccelerometer *accelerometer;
@property (nonatomic) BOOL isPaused;
@end

@implementation KZStage
+ (KZStage *) stage {
  return stage;
}

- (void) dealloc {
  stage = nil;
}

- (id) initWithRootScene:(KZScene *) scene {
  if((self = stage = [super initWithNibName:@"KZStage" bundle:nil])) {;
    self.scenes = [[Stack alloc] init];
    self.renderer = [[KZRenderer alloc] init];
    self.entities = [NSMutableArray arrayWithCapacity:256];
    self.events = [NSMutableArray arrayWithCapacity:16];
    self.speaker = [OALSimpleAudio sharedInstance];
    [self.scenes push: scene];
  }
  
  return self;
}

- (void) viewDidLoad {
  [super viewDidLoad];
  [self setupAccelerometer];
  [self setupAudio];
  [self setupGLContext];
  [self.renderer setup];
  [self pushScene: [self.scenes pop]];
}

- (void) setupAudio {
  [OALSimpleAudio sharedInstance].allowIpod = NO;
  [OALSimpleAudio sharedInstance].honorSilentSwitch = YES;
}

- (void) setupAccelerometer {
  self.accelerometer = [UIAccelerometer sharedAccelerometer];
  self.accelerometer.delegate = self;
}

-(void)accelerometer:(UIAccelerometer *) accelerometer didAccelerate:(UIAcceleration *) acceleration {
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  BOOL isUpsideDown = orientation == UIDeviceOrientationLandscapeLeft;
  
  float tilt = acceleration.y;
  if(tilt < .05f && tilt > -.05f) return;
  if(tilt > .4f) tilt = .4f;
  if(tilt < -.4f) tilt = -.4f;
  if(isUpsideDown) tilt *= -1.f;
  
  [self.scene didTilt:tilt];
}

- (void) setupGLContext {
  self.preferredFramesPerSecond = 30;
  self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  self.glkView.context = self.context;
  self.glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
  [EAGLContext setCurrentContext:self.context];
}

- (GLKView *) glkView {
  return (GLKView*)self.view;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  // TODO: add frustum culling
  [self.renderer clear];
  [[KZScreen shared] lookAt: self.scene.camera];
  [self.renderer renderView: _background];
  
  for(KZEntity *e in _entities) {
    [self.renderer renderEntity: e];
  }
  
  for(KZView *view in self.scene.views) {
    [self.renderer renderView: view];
  }
}

- (void) update {
  for(KZEntity *e in _entities) {
    e.lastorigin = e.origin;
    e.origin = add(e.vector, e.origin);
    
    for(id<KZAsset> asset in e.assets) [asset.animation nextFrame];
  }
  
  [self runEventsForTick: _ticks];
  [self.scene update];
  _ticks++;
}

- (void) runEventsForTick:(NSUInteger) tick {
  for(KZEvent *e in self.events) {
    if(tick < e.nextTick) continue;
    
    e.action();
    
    if(e.isRepeating) [e calculateNextTick];
    else [e cancel];
  }
}

- (void) pushScene:(KZScene *) scene {
  [self.scenes push: scene];
  [self.scene sceneWillBegin];
}

- (void) popScene {
  [self.scenes pop];
  [self.scene sceneWillResume];
}

- (KZScene *) scene {
  return [self.scenes peek];
}

- (void) addEntity:(KZEntity *) entity {
  [self.entities addObject:entity];
}
- (void) addEntities:(NSArray *) entities {
  [self.entities addObjectsFromArray:entities];
}
- (void) removeEntity:(KZEntity *) entity {
  [self.entities removeObject:entity];
}
- (void) removeAllEntities {
  [self.entities removeAllObjects];
}

#pragma mark touch delegate

- (void) didBecomeActive {
  self.touchesHeld = 0;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint t = [[touches anyObject] locationInView:self.view];
  self.touchedView = [self viewForTouch: t in: self.scene.views];
  
  if(self.touchedView != nil) {
    [self.touchedView didTouchDown];
    return;
  }
  
  self.touchesHeld += [touches count];
  if(self.touchesHeld == 2 && [self.scene respondsToSelector:@selector(didReleaseDoubleTouch)]) {
    [self.scene didDoubleTouch];
  }
  
  if(self.touchesHeld == 1 && [self.scene respondsToSelector:@selector(didTouchAtPosition:)]) {
    vec3 p = [[KZScreen shared] mapTouchPointToScene: t];
    [self.scene didTouchAtPosition:p];
  }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  if(self.touchedView != nil) {
    CGPoint t = [[touches anyObject] locationInView:self.view];
    [self.touchedView didTouchUp];
    if([self viewForTouch: t in: self.scene.views] == self.touchedView) {
      [self.touchedView didTouchUpInside];
    }
    
    self.touchedView = nil;
    return;
  }
  
  if(self.touchesHeld == 1 && [self.scene respondsToSelector:@selector(didReleaseTouch)]) {
    [self.scene didReleaseTouch];
  } else if(self.touchesHeld == 2 && [self.scene respondsToSelector:@selector(didReleaseDoubleTouch)]) {
    [self.scene didReleaseDoubleTouch];
  }
  
  self.touchesHeld -= [touches count];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  if(self.touchedView != nil) return;
  
  if(self.touchesHeld == 1 && [self.scene respondsToSelector:@selector(didTouchAtPosition:)]) {
    CGPoint t = [[touches anyObject] locationInView:self.view];
    vec3 p = [[KZScreen shared] mapTouchPointToScene: t];
    [self.scene didTouchAtPosition:p];
  }
}

- (KZView *) viewForTouch:(CGPoint) t in:(NSArray *) views {
  for(KZView *view in views) {
    if(CGRectContainsPoint(view.rect, t) == NO) continue;
    KZView *touchedChildView = [self viewForTouch:t in: view.subviews];
    return touchedChildView == nil ? view : touchedChildView;
  }
  
  return nil;
}

- (void) playSound:(NSString *) name {
  [self.speaker playEffect: name];
}

- (void) loopMusic:(NSString *) name {
  [self.speaker playBg: name loop:YES];
}

- (void) stopMusic {
  [self.speaker stopBg];
}

-(void) stopSounds {
  [self.speaker stopAllEffects];
}

@end
