//
//  MainMenuScene.m
//  PenguinCross
//
//  Created by Lee Irvine on 12/22/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "MenuScene.h"
#import "EntityFactory.h"
#import "GameScene.h"
#import "Game.h"
#import "Pond.h"

@implementation MenuScene

- (void) sceneWillBegin {
  [self setupPlayButton];
}

- (void) setupPlayButton {
  self.playButton = [KZView viewWithPosition:448:300 size:128:64];
  self.playButton.defaultTexture = [KZTexture textureWithName:@"startButton"];
  self.playButton.highlightTexture = [KZTexture textureWithName:@"startButtonHighlight"];
  
  [self.playButton sendTouchAction:@selector(didTouchPlay) to:self];
  [self addView: self.playButton];
}

- (void) didTouchPlay {
  GameScene *scene = [[GameScene alloc] init];
  [_game loadPond: 0];
  [[KZStage stage] pushScene: scene];
}

@end
