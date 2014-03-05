//
//  ViewController.m
//  PenguinCross
//
//  Created by Lee Irvine on 6/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "GameScene.h"
#import "Pond.h"
#import "Game.h"
#import "Force.h"
#import "Physics.h"
#import "DeathScene.h"
#import "VictoryScene.h"
#import "GameEntity.h"
#import "Peggy.h"

@implementation GameScene

- (void) sceneWillBegin {
  [self resetCamera];
}

- (void) sceneWillResume {
  if(_resetCameraOnResume == YES) {
    [self resetCamera];
    _resetCameraOnResume = NO;
  }
  
  _game.isPeggyWalking = NO;
}

- (void) update {
  [self adjustCamera];
  [self.game update];
  [self peggySlideWithIce];
  [self peggyWalkToDestination];
  [self peggyGrabEggs];
  
  if(_game.iceUnderPeggy == nil) {
    [self showDeathScene];
    return;
  }
  
  if([_game areAllEggsCollected]) {
    [self showVictoryScene];
  }
}

- (void) adjustCamera {
  [self adjustCameraOrigin];
  [self adjustCameraZoom];
}

- (void) resetCamera {
  _cameraorigin = _game.pond.origin;
  [self adjustCameraZoom];
}

- (void) adjustCameraOrigin {
  vec3 o = _game.peggy.origin, c = self.camera.origin;
  BOOL isBeyondWidth = fabsf(o.x - c.x) > 80.f;
  BOOL isBeyondHeight = fabsf(o.y - c.y) > 60.f;
  
  if(isBeyondHeight == NO & isBeyondWidth == NO) return;
  
  float panspeed = 0.6f;
  vec3 v = scale(normalize(sub(o,c)), panspeed);
  _cameraorigin = add(_cameraorigin, v);
}

- (void) adjustCameraZoom {
  const float maxwidth = 480.f, maxheight = 360.f;
  rect pondbounds = _game.pond.bounds;
  float width = pondbounds.topleft.x - pondbounds.bottomright.x;
  float height = pondbounds.topleft.y - pondbounds.bottomright.y;
  
  if(width > maxwidth) width = maxwidth;
  if(height > maxheight) height = maxheight;

  vec3 offset = _v(width * .5f, height * .5f, 0.f);
  rect nextcamera = _r(add(_cameraorigin, offset), sub(_cameraorigin, offset));

  [self.camera zoomToFit:nextcamera];
}

- (void) showPauseScene {

}

- (void) showDeathScene {
  DeathScene *scene = [[DeathScene alloc] init] ;
  scene.camera = self.camera;
  [self.stage pushScene: scene];
  _resetCameraOnResume = YES;
}

- (void) showVictoryScene {
  VictoryScene *scene = [[VictoryScene alloc] init] ;
  [self.stage pushScene: scene];
  _resetCameraOnResume = YES;
}

- (void) peggyGrabEggs {
  for(GameEntity *egg in _game.pond.eggs) {
    if([egg isTouching: _game.peggy] == NO) continue;
    if([_game.grabbedEggs containsObject: egg]) continue;
    
    [self.stage removeEntity: egg];
    [_game.grabbedEggs addObject: egg];
  }
}

- (void) peggyWalkToDestination {
  if(_game.isPeggyWalking == NO) return;
  if([self didPeggyReachDestination: _game.peggy.origin]) {
    if(_isPeggyCharging) [self peggyBreak];
    else [self peggyStopWalking];
  } else {
    Force *force = [_game.physics applyForceToEntity:_game.peggy];
    force.direction = normalize(sub(_game.walkPeggyTo, _game.walkPeggyFrom));
    force.massAcceleration = 0.18f * _game.peggy.mass;
  }
}

- (void) peggySlideWithIce {
  vec3 shift = sub(_game.iceUnderPeggy.origin, _game.iceUnderPeggy.lastorigin);
  _game.peggy.origin = add(_game.peggy.origin, shift);
}

- (BOOL) didPeggyReachDestination:(vec3) position {
  if(isEqualv(_game.walkPeggyTo, _game.walkPeggyFrom)) return YES;
  vec3 fromto = sub(_game.walkPeggyTo, _game.walkPeggyFrom);
  float t = dot(sub(position, _game.walkPeggyFrom), fromto) / dot(fromto, fromto);
  return t >= 1.f;
}

- (void) peggyStartWalkingTo:(vec3) p {
  _game.walkPeggyTo = _2d(p);
  _game.walkPeggyFrom = _2d(_game.peggy.origin);
  _game.isPeggyWalking = YES;
  _game.peggy.angle = _v(0,0,angleFromOrigin(_game.walkPeggyFrom, _game.walkPeggyTo));
  [_game.peggy playWalkAnimation];
}

- (void) peggyStopWalking {
  _game.isPeggyWalking = NO;
  [_game.peggy playIdleAnimation];
}

- (void) peggyBreak {
  [self peggyStopWalking];
  if(_game.iceUnderPeggy == nil) return;
//  if(_game.peggy.speed < 1.3f) return;
  
  NSArray *forces = [_game.physics forcesForEntity: _game.peggy];
  for(Force *force in forces) {
    force.subject = _game.iceUnderPeggy;
  }
}

- (void) didDoubleTouchAtPosition:(vec3) p {
  _isPeggyCharging = YES;
  [self peggyStartWalkingTo: p];
}
- (void) didReleaseDoubleTouch {
  [self peggyBreak];
}
- (void) didTouchAtPosition:(vec3) p {
  _isPeggyCharging = NO;
  [self peggyStartWalkingTo: p];
}
- (void) didReleaseTouch {
  [self peggyStopWalking];
}

@end