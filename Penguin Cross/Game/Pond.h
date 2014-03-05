//
//  Pond.h
//  Penguin Cross
//
//  Created by Lee Irvine on 12/29/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameEntity;
@interface Pond : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) KZEntity *peggy;
@property (nonatomic, retain) NSArray *ices;
@property (nonatomic, retain) NSArray *eggs;
@property (nonatomic, retain) NSArray *iceInitialPositions;
@property (nonatomic, retain) NSArray *eggInitialPositions;
@property (nonatomic, assign) vec3 peggyInitialPosition;
+ (Pond *) pondWithName:(NSString *) name;
- (rect) bounds;
- (vec3) origin;
- (GameEntity *) findIceUnderPeggy;
- (void) reset;
@end
