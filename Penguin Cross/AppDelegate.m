//
//  AppDelegate.m
//  PenguinCross
//
//  Created by Lee Irvine on 7/14/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "AppDelegate.h"
#import "KZScreen.h"
#import "MenuScene.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [KZScreen setupScreen:KZScreenModePerspective];
  MenuScene *scene = [[MenuScene alloc] init];
  self.stage = [[KZStage alloc] initWithRootScene: scene];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = self.stage;
  [self.window makeKeyAndVisible];

  return YES;
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
  [self.stage didBecomeActive];
}

@end
