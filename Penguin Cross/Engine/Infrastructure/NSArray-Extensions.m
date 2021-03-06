//
//  NSArray-Extensions.m
//  PenguinCross
//
//  Created by Lee Irvine on 7/22/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "NSArray-Extensions.h"

@implementation NSArray (Extensions)
- (NSArray *) mapObjects:(objectMapper) mapper {
  NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:[self count]];
  for(id obj in self) {
    [output addObject: mapper(obj)];
  }
  
  return [NSArray arrayWithArray:output];
}

- (id)firstObject {
  if ([self count] > 0) {
    return [self objectAtIndex:0];
  }
  return nil;
}
@end

@implementation NSMutableArray (Extensions)

- (void) removeObjectsMatching: (removeObjectCheck) check {
  NSArray *objects = [NSArray arrayWithArray: self];
  for(id obj in objects) {
    if(check(obj)) [self removeObject: obj];
  }
}


@end