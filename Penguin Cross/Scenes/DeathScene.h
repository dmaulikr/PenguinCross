//
//  PauseScene.h
//  Penguin Cross
//
//  Created by Lee Irvine on 12/31/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Scene.h"
@class Game;
@interface DeathScene : Scene
@property (nonatomic, retain) KZView *loserView;
@property (nonatomic, retain) KZView *tryagainButton;
@property (nonatomic, assign) SEL onupdate;
@end
