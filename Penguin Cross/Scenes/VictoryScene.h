//
//  VictoryScene.h
//  Penguin Cross
//
//  Created by Lee Irvine on 2/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Scene.h"

@class Game;
@interface VictoryScene : Scene
@property (nonatomic, retain) KZView *winnerView;
@property (nonatomic, retain) KZView *continueButton;

@end
