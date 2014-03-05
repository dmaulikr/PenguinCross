//
//  Peggy.h
//  Penguin Cross
//
//  Created by Lee Irvine on 3/3/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "GameEntity.h"

@interface Peggy : GameEntity
@property (nonatomic, strong) KZMesh *mesh;
- (void) playWalkAnimation;
- (void) playIdleAnimation;
@end
