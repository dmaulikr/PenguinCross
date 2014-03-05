//
//  Scene.h
//  PenguinCross
//
//  Created by Lee Irvine on 12/22/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZStage.h"

@class KZCamera, Game;
@interface Scene : KZScene {
@protected
  Game *_game;
}
@property (nonatomic, retain) Game *game;
@end
