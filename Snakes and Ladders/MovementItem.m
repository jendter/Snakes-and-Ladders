//
//  MovementItem.m
//  Snakes and Ladders
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import "MovementItem.h"

@implementation MovementItem


+ (MovementItem *) movementItemForBoardSize:(int)boardSize forItemLength:(MovementItemSize)size forItemType:(MovementItemType)type {
    MovementItem *newMovementItem = [[MovementItem alloc] init];
    
    newMovementItem.lowSpace = arc4random_uniform(boardSize); // lowest possible value is 0
    newMovementItem.highSpace = arc4random_uniform(boardSize); // highest possible value is boardSize - 1
    newMovementItem.type = type;
    
    float lowestAcceptablePercentage = 0.01;
    float highestAcceptablePercentage = 0.99;
    
    if (type == ladder) {
        if (size == large) {
            // board game percentage = .58
            lowestAcceptablePercentage = 0.55;
            highestAcceptablePercentage = 0.61;
        } else if (size == mediumLarge) {
            // board game percentage = .37
            lowestAcceptablePercentage = 0.34;
            highestAcceptablePercentage = 0.40;
        } else if (size == medium) {
            // board game percentage = .20
            lowestAcceptablePercentage = 0.17;
            highestAcceptablePercentage = 0.23;
        } else if (size == small) {
            // board game percentage = .10
            lowestAcceptablePercentage = 0.08;
            highestAcceptablePercentage = 0.12;
        }
    } else if (type == snake) {
        if (size == large) {
            // board game percentage = .63
            lowestAcceptablePercentage = 0.60;
            highestAcceptablePercentage = 0.66;
        } else if (size == mediumLarge) {
            // board game percentage = .40
            lowestAcceptablePercentage = 0.37;
            highestAcceptablePercentage = 0.43;
        } else if (size == medium) {
            // board game percentage = .20
            lowestAcceptablePercentage = 0.17;
            highestAcceptablePercentage = 0.23;
        } else if (size == small) {
            // board game percentage = .06
            lowestAcceptablePercentage = 0.03;
            highestAcceptablePercentage = 0.09;
        }

    }
    
    
    if ( ( ((float)boardSize * highestAcceptablePercentage) - ((float)boardSize * lowestAcceptablePercentage) ) < 1 ) {
        // If the space between the highest and lowest possible values comes out to less than one board space
        
        // Keep generating board spaces until we get:
        // 1) The high and low value are one space apart (since a ladder/snake needs to be at least 1 space long)
        // 1) The high value is greater than the low value
        // 2) The low space does not start on zero
        while (
               (newMovementItem.highSpace - newMovementItem.lowSpace) != 1 ||
               newMovementItem.lowSpace > newMovementItem.highSpace ||
               newMovementItem.lowSpace == 0
               ) {
            newMovementItem.lowSpace = arc4random_uniform(boardSize);
            newMovementItem.highSpace = arc4random_uniform(boardSize);
        }
        
    } else {
        
        // Keep generating board spaces until we get:
        // 1) A high and low value are the minimum length apart
        // 2) The high value is greater than the low value
        // 3) The low space does not start on zero
        while (
               (float)(newMovementItem.highSpace - newMovementItem.lowSpace) < ((float)boardSize * lowestAcceptablePercentage) ||
               (float)(newMovementItem.highSpace - newMovementItem.lowSpace) > ((float)boardSize * highestAcceptablePercentage) ||
               newMovementItem.lowSpace > newMovementItem.highSpace ||
               newMovementItem.lowSpace == 0
               ) {
            newMovementItem.lowSpace = arc4random_uniform(boardSize);
            newMovementItem.highSpace = arc4random_uniform(boardSize);
        }
        
    }
    
    
    
    
    return newMovementItem;
}

- (NSString *) typeStringValue {
    NSString *typeString = [NSString new];
    
    if (self.type == snake) {
        typeString = @"snake";
    } else if (self.type == ladder) {
        typeString = @"ladder";
    }
    
    return typeString;
}

+ (MovementItem *) movementItemWithMin:(int)min andMax:(int)max {
    
    MovementItem *newMovementItem = [[MovementItem alloc] init];
    
    newMovementItem.lowSpace = arc4random_uniform(max-min);
    newMovementItem.highSpace = arc4random_uniform((max-min)+1); //+1 because arc4random takes gives back n-1
    while (newMovementItem.highSpace <= newMovementItem.lowSpace) {
        // keep generating numbers until highSpace is bigger than lowSpace
        newMovementItem.highSpace = arc4random_uniform((max-min)+1);
    }
    
    // Add the minimum back, since arc4random_uniform(n) chooses numbers between 0 and n-1
    newMovementItem.lowSpace = newMovementItem.lowSpace + min;
    newMovementItem.highSpace = newMovementItem.highSpace + min;
    
    return newMovementItem;
}

@end
