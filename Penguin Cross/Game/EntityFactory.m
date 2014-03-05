//
//  EntityFactory.m
//  PenguinCross
//
//  Created by Lee Irvine on 8/12/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EntityFactory.h"
#import "GameEntity.h"
#import "Peggy.h"

@implementation EntityFactory

- (GameEntity *) spawnIceWithPosition: (vec3) p {
  GameEntity *ice = [[GameEntity alloc] init];
  KZMesh *mesh = [KZMesh meshWithName:@"ice"];
  
  mesh.texture = [KZTexture textureWithName:@"ice"];
  mesh.shader = [KZShader shaderWithName:@"flat"];
  ice.assets = @[mesh];
  
  ice.dimensions = _v(32.f, 32.f, 8.f);
  ice.mass = 0.8f;
  ice.origin = p;
  
  return ice;
}

- (Peggy *) spawnPeggyWithPosition: (vec3) p {
  Peggy *peggy = [[Peggy alloc] init] ;
  peggy.mesh = [KZMesh meshWithName:@"peggy"];
  peggy.mesh.texture = [KZTexture textureWithName:@"peggy"];
  peggy.mesh.shader = [KZShader shaderWithName:@"ui"];
  NSDictionary *animations = @{@"walk": [NSValue valueWithRange:NSMakeRange(0, 20)]};
  peggy.mesh.animation = [[KZAnimation alloc] initWithAnimations: animations];
  
  peggy.assets = @[peggy.mesh];
  peggy.dimensions = _v(3.f, 3.f, 6.f);
  peggy.mass = 1.f;
  peggy.origin = p;
  
  return peggy;
}

- (GameEntity *) spawnEggWithPosition: (vec3) p {
  GameEntity *egg = [[GameEntity alloc] init] ;
  KZMesh *mesh = [KZMesh meshWithName:@"star"];
  mesh.texture = [KZTexture textureWithName:@"star"];
  mesh.shader = [KZShader shaderWithName:@"shiney"];
  
  egg.assets = @[mesh];
  egg.origin = p;
  egg.dimensions = _v(12.f, 12.f, 12.f);
  return egg;
}

@end
