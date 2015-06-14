//
//  GameBoard.m
//  Snakes and Ladders
//
//  Created by Josh Endter on 6/14/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import "GameBoard.h"
#import "MovementItem.h"

@implementation GameBoard


- (instancetype)initWithGameboardSize:(int)boardSize difficulty:(GameDifficulty)gameDifficulty
{
    self = [super init];
    if (self) {
        
        NSLog(@"\n");
        
        NSLog(@"The board will have %d total spaces.", boardSize);
        
        
        // Get the number of snakes and ladders (i.e. movement items) based on board size
        int totalMovementItems = round((float)boardSize * 0.19);
        NSLog(@"Total number of snakes and ladders: %d", totalMovementItems);
        
        
        // Decide how many of those items should be snakes or ladders based on player difficulty
        int numOfSnakes;
        int numOfLadders;
        
        if (gameDifficulty == easyGame) {
            
            // 3/4 of the movement items will be ladders
            numOfLadders = round((float)totalMovementItems * .75);
            numOfSnakes = totalMovementItems - numOfLadders;
            
        } else if (gameDifficulty == normalGame) {
            
            // 1/2 of the the movement items will be ladders
            numOfLadders = totalMovementItems/2;
            numOfSnakes = totalMovementItems - numOfLadders;
            
            // Since numOfLadders will be rounded down, if there's not an even 50/50 split, numOfSnakes will have 1 more
            // This reflects the actual board game, which has one more snake than ladder
            
        } else if (gameDifficulty == hardGame) {
            
            // 1/4 of the movement items will be ladders
            numOfLadders = round((float)totalMovementItems * .25);
            numOfSnakes = totalMovementItems - numOfLadders;
            
        }
        
        NSLog(@"Total number of Snakes: %d  Ladders: %d", numOfSnakes, numOfLadders);
        
        
        // Make the snakes and ladders
        
        // Array to hold all the snakes and ladders
        NSMutableArray *movementItems = [NSMutableArray new];
        
        
        // Start all the snake and ladder values at 0
        int numOfLargeLadders = 0;
        int numOfMediumLargeLadders = 0;
        int numOfMediumLadders = 0;
        int numOfSmallLadders = 0;
        
        int numOfLargeSnakes = 0;
        int numOfMediumLargeSnakes = 0;
        int numOfMediumSnakes = 0;
        int numOfSmallSnakes = 0;
        
        // Make the ladder MovementItem objects
        int numOfAllLaddersMade = 0;
        while (numOfAllLaddersMade < numOfLadders) {
            
            MovementItem *newMovementItem;
            
            // Make the ladders in order of priority: Large, small, medium large, and medium
            // Using the percentages from the actual board game
            if (numOfLargeLadders == 0) {
                numOfLargeLadders = round((float)numOfLadders * 0.11);
                
                if (numOfLargeLadders == 0) {
                    // There must be at least one large ladder
                    numOfLargeLadders = 1;
                }
                
                for (int i = 0; i < numOfLargeLadders; i++) {
                    newMovementItem = [MovementItem movementItemForBoardSize:boardSize forItemLength:large forItemType:ladder];
                    [movementItems addObject:newMovementItem];
                }
                
            } else if (numOfSmallLadders == 0) {
                numOfSmallLadders = round((float)numOfLadders * 0.22);
                
                if (numOfSmallLadders == 0) {
                    numOfSmallLadders = 1;
                }
                
                for (int i = 0; i < numOfSmallLadders; i++) {
                    newMovementItem = [MovementItem movementItemForBoardSize:boardSize forItemLength:small forItemType:ladder];
                    [movementItems addObject:newMovementItem];
                }
                
            } else if (numOfMediumLargeLadders == 0) {
                numOfMediumLargeLadders = round((float)numOfLadders * 0.11);
                
                if (numOfMediumLargeLadders == 0) {
                    numOfMediumLargeLadders = 1;
                }
                
                for (int i = 0; i < numOfMediumLargeLadders; i++) {
                    newMovementItem = [MovementItem movementItemForBoardSize:boardSize forItemLength:mediumLarge forItemType:ladder];
                    [movementItems addObject:newMovementItem];
                }
                
            } else {
                numOfMediumLadders = numOfLadders - numOfAllLaddersMade;
                
                for (int i = 0; i < numOfMediumLadders; i++) {
                    newMovementItem = [MovementItem movementItemForBoardSize:boardSize forItemLength:medium forItemType:ladder];
                    [movementItems addObject:newMovementItem];
                }
            }
            
            numOfAllLaddersMade = numOfLargeLadders+numOfMediumLargeLadders+numOfMediumLadders+numOfSmallLadders;
        }
        
        // Make the snake MovementItem objects
        int numOfAllSnakesMade = 0;
        while (numOfAllSnakesMade < numOfSnakes) {
            //NSLog(@"Number of all snakes made: %d", numOfAllSnakesMade);
            MovementItem *newMovementItem;
            
            // Make the snakes in order of priority: Large, small, medium large, and medium
            // Using the percentages from the actual board game
            if (numOfLargeSnakes == 0) {
                numOfLargeSnakes = round((float)numOfSnakes * 0.1);
                
                if (numOfLargeSnakes == 0) {
                    // There must be at least one large ladder
                    numOfLargeSnakes = 1;
                }
                
                for (int i = 0; i < numOfLargeSnakes; i++) {
                    newMovementItem = [MovementItem movementItemForBoardSize:boardSize forItemLength:large forItemType:snake];
                    [movementItems addObject:newMovementItem];
                }
                
                
            } else if (numOfSmallSnakes == 0) {
                numOfSmallSnakes = round((float)numOfSnakes * 0.3);
                
                if (numOfSmallSnakes == 0) {
                    numOfSmallSnakes = 1;
                }
                
                for (int i = 0; i < numOfSmallSnakes; i++) {
                    newMovementItem = [MovementItem movementItemForBoardSize:boardSize forItemLength:small forItemType:snake];
                    [movementItems addObject:newMovementItem];
                }
                
                
            } else if (numOfMediumLargeSnakes == 0) {
                numOfMediumLargeSnakes = round((float)numOfSnakes * 0.2);
                
                if (numOfMediumLargeSnakes == 0) {
                    numOfMediumLargeSnakes = 1;
                }
                
                for (int i = 0; i < numOfMediumLargeSnakes; i++) {
                    newMovementItem = [MovementItem movementItemForBoardSize:boardSize forItemLength:mediumLarge forItemType:snake];
                    [movementItems addObject:newMovementItem];
                }
            } else {
                numOfMediumSnakes = numOfSnakes - numOfAllSnakesMade;
                
                for (int i = 0; i < numOfMediumSnakes; i++) {
                    newMovementItem = [MovementItem movementItemForBoardSize:boardSize forItemLength:medium forItemType:snake];
                    [movementItems addObject:newMovementItem];
                }
                
            }
            
            numOfAllSnakesMade = numOfLargeSnakes+numOfMediumLargeSnakes+numOfMediumSnakes+numOfSmallSnakes;
        }
        
        NSLog(@"\n");
        
        NSLog(@"Number of Large ladders: %d", numOfLargeLadders);
        NSLog(@"Number of Medium Large ladders: %d", numOfMediumLargeLadders);
        NSLog(@"Number of Medium ladders: %d", numOfMediumLadders);
        NSLog(@"Number of Small ladders: %d", numOfSmallLadders);
        
        NSLog(@"\n");
        
        NSLog(@"Number of Large snakes: %d", numOfLargeSnakes);
        NSLog(@"Number of Medium Large snakes: %d", numOfMediumLargeSnakes);
        NSLog(@"Number of Medium snakes: %d", numOfMediumSnakes);
        NSLog(@"Number of Small snakes: %d", numOfSmallSnakes);
        
        NSLog(@"\n");
        
        for (MovementItem *aMovementItem in movementItems) {
            NSLog(@"There is a %@ that has a lower value of %d and a higher value of %d", [aMovementItem typeStringValue], aMovementItem.lowSpace, aMovementItem.highSpace);
        }
        
        NSLog(@"\n");
        
        // Make the game board
        self.gameBoardSpaces = [[NSMutableArray alloc] init];
        BoardSpace *firstGameBoardSpace;
        
        // Going out of the way to use linked lists to create the board spaces
        BoardSpace *previousBoardSpace = nil;
        for (int counter = 0; counter < boardSize; counter++) {
            
            BoardSpace *boardSpace = [[BoardSpace alloc] init];
            
            boardSpace.spaceNumber = [[NSNumber alloc] initWithInt:counter];
            
            if (counter == 0) {
                firstGameBoardSpace = boardSpace;
            }
            
            previousBoardSpace.nextSpace = boardSpace;
            previousBoardSpace = boardSpace;
            
            
            
            [self.gameBoardSpaces addObject:boardSpace];
        }
        
        //        BoardSpace *tempBoardSpace = firstGameBoardSpace;
        //        while (tempBoardSpace != nil) {
        //            NSLog(@"%@", tempBoardSpace);
        //            tempBoardSpace = tempBoardSpace.nextSpace;
        //        }
        
        // Go through each game board item, and see if they match a movement item
        // If they do, hook up the appropriate items together
        for (int counter = 0; counter < self.gameBoardSpaces.count; counter++) {
            BoardSpace *tempBoardSpace = self.gameBoardSpaces[counter];
            
            for (MovementItem *tempItem in movementItems) {
                
                if (tempItem.type == snake && tempItem.highSpace == [tempBoardSpace.spaceNumber intValue]) {
                    // If it is a snake, and the high number is equal to the board space we are testing
                    // then add in a pointer to the board space where the snake leads to
                    tempBoardSpace.snakeLeadingToSpace = (BoardSpace *)self.gameBoardSpaces[tempItem.lowSpace];
                    NSLog(@"At space %d, there is a snake that points to space %@", counter, tempBoardSpace.snakeLeadingToSpace.spaceNumber);
                } else if (tempItem.type == ladder && tempItem.lowSpace == [tempBoardSpace.spaceNumber intValue]) {
                    // If it is a ladder, and the low number is equal to the board space we are testing
                    // then add in a pointer to the board space where the ladder leads to
                    tempBoardSpace.ladderLeadingToSpace = (BoardSpace *)self.gameBoardSpaces[tempItem.highSpace];
                    NSLog(@"At space %d, there is a ladder that points to space %@", counter, tempBoardSpace.ladderLeadingToSpace.spaceNumber);
                }
            }
        }
        
        _currentPlayerTurn = @1;
        _isPlayingGame = YES;
        
    }
    
    return self;
}

- (void)status {
    NSLog(@"\n");
    NSLog(@"Last space: %lu", self.gameBoardSpaces.count-1);
    NSLog(@"%@ is on space: %@", self.player1.playerName, self.player1.currentSpace.spaceNumber);
    NSLog(@"%@ is on space: %@", self.player2.playerName, self.player2.currentSpace.spaceNumber);
}

- (void)moveCurrentPlayerForward:(int)spaces {
    for (int i = 0; i < spaces; i++) {
        if ([self.currentPlayerTurn  isEqual: @1]) {
            self.player1.currentSpace = self.player1.currentSpace.nextSpace;
        } else {
            self.player2.currentSpace = self.player2.currentSpace.nextSpace;
        }
    }
    
    if ([self.currentPlayerTurn  isEqual: @1]) {
        self.currentPlayerTurn = @2;
    } else {
        self.currentPlayerTurn = @1;
    }
    
    // If player1 lands on a snake or ladder
    if (self.player1.currentSpace.snakeLeadingToSpace) {
        
        NSLog(@"Oh no! A snake took you from space %@ to space %@", self.player1.currentSpace.spaceNumber, self.player1.currentSpace.snakeLeadingToSpace.spaceNumber);
        self.player1.currentSpace = self.player1.currentSpace.snakeLeadingToSpace;
        
    } else if (self.player1.currentSpace.ladderLeadingToSpace) {
        NSLog(@"Yes! A ladder took you from space %@ to space %@", self.player1.currentSpace.spaceNumber, self.player1.currentSpace.ladderLeadingToSpace.spaceNumber);
        self.player1.currentSpace = self.player1.currentSpace.ladderLeadingToSpace;
    }
    
    // If the player2 lands on a snake or ladder
    if (self.player2.currentSpace.snakeLeadingToSpace) {
        
        NSLog(@"Oh no! A snake took you from space %@ to space %@", self.player2.currentSpace.spaceNumber, self.player2.currentSpace.snakeLeadingToSpace.spaceNumber);
        self.player2.currentSpace = self.player2.currentSpace.snakeLeadingToSpace;
        
    } else if (self.player2.currentSpace.ladderLeadingToSpace) {
        NSLog(@"Yes! A ladder took you from space %@ to space %@", self.player2.currentSpace.spaceNumber, self.player2.currentSpace.ladderLeadingToSpace.spaceNumber);
        self.player2.currentSpace = self.player2.currentSpace.ladderLeadingToSpace;
    }
    
    // Check to see if someone won the game
    if (self.player1.currentSpace == nil || self.player1.currentSpace.nextSpace == nil) {
        NSLog(@"Congratulations %@, you won!", self.player1.playerName);
        self.isPlayingGame = NO;
        
    } else if (self.player2.currentSpace == nil || self.player2.currentSpace.nextSpace == nil) {
        NSLog(@"Congratulations %@, you won!", self.player2.playerName);
        self.isPlayingGame = NO;
    }
    
}

@end
