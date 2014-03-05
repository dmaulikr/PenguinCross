//
//  Pond.m
//  Penguin Cross
//
//  Created by Lee Irvine on 12/29/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Pond.h"
#import "EntityFactory.h"
#import "NSArray-Extensions.h"
#import "GameEntity.h"

const float blocksize = 32.f;
@implementation Pond

+ (Pond *) pondWithName:(NSString *) name {
  NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"pond"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  
  Pond *pond = [[Pond alloc] init] ;
  pond.name = [json valueForKey:@"name"];
  pond.peggyInitialPosition = [pond vec3FromArray: [json valueForKey:@"start"]];
  pond.iceInitialPositions = [[json valueForKey:@"ice"] mapObjects:^id(NSArray *obj) {
    vec3 p = [pond vec3FromArray: obj];
    return [NSValue valueWithBytes:&p objCType:@encode(vec3)];
  }];
  
  pond.eggInitialPositions = [[json valueForKey:@"eggs"] mapObjects:^id(NSArray *obj) {
    vec3 p = [pond vec3FromArray: obj];
    return [NSValue valueWithBytes:&p objCType:@encode(vec3)];
  }];
  
  return pond;
}

- (vec3) vec3FromArray: (NSArray *) array {
  vec3 output = (vec3){0.f, 0.f, 0.f};
  output.x = blocksize * [array[0] floatValue];
  output.y = blocksize * [array[1] floatValue];
  return output;
}

- (vec3) vec3FromValue: (NSValue *) value {
  vec3 output;
  [value getValue:&output];
  return output;
}

- (void) reset {
  EntityFactory *factory = [[EntityFactory alloc] init] ;
  self.peggy = [factory spawnPeggyWithPosition: self.peggyInitialPosition];
  self.ices = [self.iceInitialPositions mapObjects:^id(NSValue *value) {
    KZEntity *ice = [factory spawnIceWithPosition: [self vec3FromValue:value]];
    // TODO: change ice model so ice floor is at Z:0
    ice.origin = _v(ice.origin.x, ice.origin.y, 0);
  
    return ice;
  }];
  self.eggs = [self.eggInitialPositions mapObjects:^id(NSValue *value) {
    return [factory spawnEggWithPosition: [self vec3FromValue:value]];
  }];
}

- (rect) bounds {
  float top = -INFINITY, left = -INFINITY;
  float bottom = INFINITY, right = INFINITY;
  for(KZEntity *ice in self.ices) {
    if(ice.origin.y > top) top = ice.origin.y;
    if(ice.origin.x > left) left = ice.origin.x;
    if(ice.origin.y < bottom) bottom = ice.origin.y;
    if(ice.origin.x < right) right = ice.origin.x;
  }
  
  return _r(
    _v(left+blocksize,top+blocksize,0.f),
    _v(right-blocksize,bottom-blocksize,0.f));
}

- (vec3) origin {
  rect bounds = self.bounds;
  return midpoint(bounds.topleft, bounds.bottomright);
}

- (GameEntity *) findIceUnderPeggy {
  GameEntity *underIce = nil;
  float closest = INFINITY;
  
  for(GameEntity *ice in self.ices) {
    float xbuffer = (ice.dimensions.x + self.peggy.dimensions.x) * .5f;
    float ybuffer = (ice.dimensions.y + self.peggy.dimensions.y) * .5f;
    
    float xdistance = fabsf(ice.origin.x - self.peggy.origin.x);
    float ydistance = fabsf(ice.origin.y - self.peggy.origin.y);
    float sum = xdistance + ydistance;
    
    if(xbuffer > xdistance && ybuffer > ydistance && closest > sum) {
      closest = sum;
      underIce = ice;
    }
  }

  return underIce;
}

@end
