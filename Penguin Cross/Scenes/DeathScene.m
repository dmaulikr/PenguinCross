//
//  PauseScene.m
//  Penguin Cross
//
//  Created by Lee Irvine on 12/31/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <objc/message.h>
#import "DeathScene.h"
#import "Physics.h"
#import "Game.h"
#import "Force.h"
#import "KZTexture.h"
#import "Peggy.h"

@implementation DeathScene

- (void) sceneWillBegin {
  [self setupViews];
  self.onupdate = @selector(drownPeggy);
  
  [KZEvent after:0.5 run:^{
    [self addView: self.loserView];
    [self addView: self.tryagainButton];
    self.onupdate = @selector(showDeath);
  }];
}

- (void) setupViews {
  self.loserView = [KZView viewWithPosition:168 :224 size:680 :160];
  self.loserView.defaultTexture = [KZTexture textureWithName:@"death"];
  self.loserView.tint = _c(1.f, 1.f, 1.f, 0);

  self.tryagainButton = [KZView viewWithPosition:245 :400 size:482 :98];
  self.tryagainButton.tint = _c(1.f, 1.f, 1.f, 0);
  
  self.tryagainButton.defaultTexture = [KZTexture textureWithName:@"tryagain"];
  self.tryagainButton.highlightTexture = [KZTexture textureWithName:@"tryagainHighlight"];
  self.tryagainButton.touchTarget = self;
  self.tryagainButton.touchAction = @selector(didTouchTryAgain);
  
}

- (void) didTouchTryAgain {
  [self.game reset];
  [self.stage popScene];
}

- (void) drownPeggy {
  Force *gravity = [self.game.physics applyForceToEntity: _game.peggy];
  gravity.direction = _v(0.f,0,-1.f);
  gravity.massAcceleration = 2.f * _game.peggy.mass;
}

- (void) showDeath {
  rgba tint = _loserView.tint;
  tint.a += 0.02f;
  _loserView.tint = tint;
  _tryagainButton.tint = tint;
  
  if(tint.a >= 1.f) {
    self.onupdate = @selector(doNothing);
  }
}

- (void) doNothing {
  
}

- (void) update {
  objc_msgSend(self, self.onupdate);
  [self.game update];
}

@end
