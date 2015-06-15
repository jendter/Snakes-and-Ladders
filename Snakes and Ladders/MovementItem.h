//
//  MovementItem.h
//  Snakes and Ladders
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BoardSpace.h"

typedef enum {
    large,
    mediumLarge,
    medium,
    small
} MovementItemSize;

// This could be refactored into two seperate classes
typedef enum {
    snake,
    ladder
} MovementItemType;

@interface MovementItem : NSObject

@property (assign, nonatomic) int lowSpace;
@property (assign, nonatomic) int highSpace;
@property (assign, nonatomic) int type;

+ (MovementItem *) movementItemWithMin:(int)min andMax:(int)max;
+ (MovementItem *) movementItemForBoardSize:(int)boardSize forItemLength:(MovementItemSize)size forItemType:(MovementItemType)type WithBoardItems:(NSArray *)existingMovementItems;

- (NSString *) typeStringValue;
- (BOOL)boardSpaceIsEmptyforCurrentMovementItems:(NSArray *)movementItems;

@end
