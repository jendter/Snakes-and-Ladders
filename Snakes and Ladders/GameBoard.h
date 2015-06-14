//
//  GameBoard.h
//  Snakes and Ladders
//
//  Created by Josh Endter on 6/14/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

typedef enum {
    easyGame,
    normalGame,
    hardGame,
    none
} GameDifficulty;

@interface GameBoard : NSObject

@property (strong, nonatomic) NSMutableArray *gameBoardSpaces;
@property (strong, nonatomic) NSNumber *currentPlayerTurn;
@property (nonatomic) BOOL isPlayingGame;
// Could generalize this to an array of players, but for now, we're hard coding 2 players.
@property (strong, nonatomic) Player *player1;
@property (strong, nonatomic) Player *player2;

- (instancetype)initWithGameboardSize:(int)boardSize difficulty:(GameDifficulty)gameDifficulty;
- (void)status;
- (void)moveCurrentPlayerForward:(int)spaces;

@end
