//
//  Scene.m
//  PenguinCross
//
//  Created by Lee Irvine on 12/22/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "Scene.h"
#import "Game.h"

@implementation Scene

- (id) init {
  if(self = [super init]) {
    self.camera = [KZCamera eye: _v(0,-60,220) origin: _v(0,0,0)];
    self.views = [NSMutableArray array];
    self.game = [Game shared];
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

- (Game *) game {
  return [Game shared];
}

- (void) update { }
- (void) sceneWillBegin { }
- (void) sceneWillResume { }
- (void) didDoubleTouchAtPosition:(vec3) p { }
- (void) didReleaseDoubleTouch { }
- (void) didTouchAtPosition:(vec3) p { }
- (void) didReleaseTouch { }

@end
