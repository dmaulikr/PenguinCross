//
//  Texture.m
//  Penguin Cross
//
//  Created by Lee Irvine on 12/25/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZTexture.h"
#import "KZStage.h"

@implementation KZTexture

+ (KZTexture *) textureWithName:(NSString *) name {
  static NSMutableDictionary *cache = nil;
  if(cache == nil) cache = [[NSMutableDictionary alloc] init];
  KZTexture *t = [cache valueForKey:name];

  if(t == nil) {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    NSDictionary *options = @{GLKTextureLoaderOriginBottomLeft : @YES};
    t = [[KZTexture alloc] init];
    [cache setValue:t forKey:name];
    
    EAGLSharegroup *sharegroup = [[[KZStage stage] context] sharegroup];
    GLKTextureLoader *loader = [[GLKTextureLoader alloc] initWithSharegroup:sharegroup];
    [loader textureWithContentsOfFile:path options:options queue:nil completionHandler:^(GLKTextureInfo *info, NSError *error) {
      t.info = info;
    }];
  }
  
  return t;
}

- (GLuint) textureId {
  return _info.name;
}

@end
