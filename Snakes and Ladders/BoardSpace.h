//
//  BoardSpace.h
//  Snakes and Ladders
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoardSpace : NSObject

@property BoardSpace *nextSpace;
@property BoardSpace *snakeLeadingToSpace;
@property BoardSpace *ladderLeadingToSpace;
@property NSNumber *spaceNumber;

@end
