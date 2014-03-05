//
//  Collision.h
//  PenguinCross
//
//  Created by Lee Irvine on 10/6/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

@class Force, KZEntity;
@interface Collision : NSObject
@property (nonatomic, strong) KZEntity *attacker;
@property (nonatomic, strong) KZEntity *victim;
@property (nonatomic) float massAcceleration;
@property (nonatomic) vec3 direction;
@property (nonatomic) vec3 point;
@end
