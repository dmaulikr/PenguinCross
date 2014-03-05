//
//  Animation.m
//  Kezzi-Engine
//
//  Created by Lee Irvine on 8/12/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZAnimation.h"

@interface KZAnimation ()
@property (nonatomic, strong) NSDictionary *animations;
@property (nonatomic, copy) NSString *currentAnimationName;
@property (nonatomic) NSRange currentAnimationRange;
@end

@implementation KZAnimation

- (id) initWithAnimations:(NSDictionary *) animations {
  if(self = [super init]) {
    self.animations = animations;
  }
  return self;
}

- (void) nextFrame {
  NSUInteger lastFrame = _currentAnimationRange.location + _currentAnimationRange.length;
  if(++_frame >= lastFrame) {
    _frame = _isLooping ? _currentAnimationRange.location : lastFrame;
  }
}

- (void) setAnimationLoop:(NSString *) loopname {
  if([self.currentAnimationName isEqual: loopname]) return;
  
  NSValue *range = [self.animations valueForKey: loopname];
  self.currentAnimationName = loopname;
  self.currentAnimationRange = [range rangeValue];
  _frame = _currentAnimationRange.location;
}

@end
