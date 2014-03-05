//
//  EntityFactory.h
//  PenguinCross
//
//  Created by Lee Irvine on 8/12/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KZEntity;
@interface EntityFactory : NSObject
- (KZEntity *) spawnIceWithPosition: (vec3) p;
- (KZEntity *) spawnPeggyWithPosition: (vec3) p;
- (KZEntity *) spawnEggWithPosition: (vec3) p;
@end
