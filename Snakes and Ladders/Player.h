//
//  Player.h
//  Snakes and Ladders
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BoardSpace.h"

@interface Player : NSObject

@property NSString *playerName;
@property BoardSpace *currentSpace;

- (instancetype)initWithBoardSpace:(BoardSpace *)startingBoardSpace;

@end
