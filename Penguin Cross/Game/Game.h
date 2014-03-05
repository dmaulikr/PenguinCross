//
//  Game.h
//  Penguin Cross
//
//  Created by Lee Irvine on 12/30/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Pond, GameEntity, Physics, Peggy;
@interface Game : NSObject
@property (retain, nonatomic) Pond *pond;
@property (retain, nonatomic) Physics *physics;
@property (retain, nonatomic) GameEntity *iceUnderPeggy;
@property (nonatomic, assign) vec3 walkPeggyTo;
@property (nonatomic, assign) vec3 walkPeggyFrom;
@property (nonatomic, assign) BOOL isPeggyWalking;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, retain) NSMutableArray *grabbedEggs;

+ (Game *) shared;
- (Peggy *) peggy;
- (BOOL) areAllEggsCollected;
- (void) loadPond:(NSInteger) level;
- (void) loadNextPond;
- (void) reset;
- (void) update;
@end
