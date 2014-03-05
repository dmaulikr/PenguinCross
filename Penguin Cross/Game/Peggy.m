//
//  Peggy.m
//  Penguin Cross
//
//  Created by Lee Irvine on 3/3/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Peggy.h"

@implementation Peggy
- (void) playWalkAnimation {
  _mesh.animation.animationLoop = @"walk";
  _mesh.animation.isLooping = YES;
}

- (void) playIdleAnimation {
  _mesh.animation.animationLoop = @"idle";
  _mesh.animation.isLooping = YES;
}
@end
