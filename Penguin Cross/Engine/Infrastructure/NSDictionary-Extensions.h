//
//  NSDictionary-Extensions.h
//  Cheapo
//
//  Created by Lee Irvine on 3/1/13.
//  Copyright (c) 2013 fareportal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extensions)
+ (id) jsonFromResource:(NSString *) resource ofType:(NSString *) type;
+ (NSMutableDictionary *) cacheWithName:(NSString *) name;
@end
