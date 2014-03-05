//
//  GameEntity.m
//  Penguin Cross
//
//  Created by Lee Irvine on 3/3/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "GameEntity.h"

@implementation GameEntity
- (vec3) vector {
  return normalize(sub(self.lastorigin, self.origin));
}
- (float) halfwidth {
  return (self.dimensions.x > self.dimensions.y ? self.dimensions.x : self.dimensions.y) * .5f;
}
@end
