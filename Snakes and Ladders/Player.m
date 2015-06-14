//
//  Player.m
//  Snakes and Ladders
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)initWithBoardSpace:(BoardSpace *)startingBoardSpace
{
    self = [super init];
    if (self) {
        _currentSpace = startingBoardSpace;
    }
    return self;
}

@end
