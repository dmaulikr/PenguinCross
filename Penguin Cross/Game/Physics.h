//
//  Physics.h
//  Penguin Cross
//
//  Created by Lee Irvine on 12/31/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Bank, Force, KZEntity;
@interface Physics : NSObject
@property (nonatomic, retain) NSMutableArray *forces;
@property (nonatomic, retain) Bank *forcebank;
+ (Physics *) physics;
- (NSArray *) forcesForEntity:(KZEntity *) entity;
- (Force *) applyForceToEntity:(KZEntity *) entity;
- (void) bounceCollidingEntities:(NSArray *) entities;
- (void) applyForces;
@end
