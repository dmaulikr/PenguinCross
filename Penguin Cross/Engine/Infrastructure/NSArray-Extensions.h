//
//  NSArray-Extensions.h
//  PenguinCross
//
//  Created by Lee Irvine on 7/22/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef id (^objectMapper)(id obj);
typedef BOOL (^removeObjectCheck)(id obj);
@interface NSArray (Extensions)
- (NSArray *) mapObjects:(objectMapper) rule;
- (id)firstObject;
@end

@interface NSMutableArray (Extensions)
- (void) removeObjectsMatching: (removeObjectCheck) check;

@end