//
//  Scene.m
//  PenguinCross
//
//  Created by Lee Irvine on 12/22/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "KZScene.h"
#import "KZStage.h"

@implementation KZScene

- (id) init {
  if(self = [super init]) {
    self.views = [NSMutableArray array];
  }
  return self;
}

- (void) addView:(KZView *) view {
  [self.views addObject:view];
}

- (void) removeAllViews {
  [self.views removeAllObjects];
}

- (KZStage *) stage {
  return [KZStage stage];
}

- (void) update { }
- (void) sceneWillBegin { }
- (void) sceneWillResume { }
- (void) didDoubleTouch { }
- (void) didReleaseDoubleTouch { }
- (void) didTouchAtPosition:(vec3) p { }
- (void) didReleaseTouch { }
-(void) didTilt: (float) tilt {}
@end
