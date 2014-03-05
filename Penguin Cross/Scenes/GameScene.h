//
//  ViewController.h
//  PenguinCross
//
//  Created by Lee Irvine on 6/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "Scene.h"

@interface GameScene : Scene {
  vec3 _cameraorigin;
  BOOL _resetCameraOnResume;
  BOOL _isPeggyCharging;
}
@end