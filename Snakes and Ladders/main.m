//
//  main.m
//  Snakes and Ladders
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovementItem.h"
#import "Player.h"
#import "GameBoard.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        GameDifficulty gameDifficulty = none;
        int boardSize = 0;
        int boardSizeXByX = 0;
        
        while (boardSizeXByX == 0) {
            NSLog(@"How big (X by X) do you want your board size? ");
            char buffer[20] = "";
            scanf("%s", buffer);
            boardSizeXByX = atoi(buffer);
            boardSize = boardSizeXByX * boardSizeXByX;
        }
        
        
        while (gameDifficulty == none) {
            NSLog(@"How difficult do you want your game (e = easy, m = medium, h = hard)? ");
            
            char buffer[20] = "";
            scanf("%s", buffer);
            NSString *inputString = [[NSString alloc] initWithUTF8String:buffer];
            inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ([inputString isEqualToString:@"e"]) {
                NSLog(@"You chose an easy difficulty level.");
                gameDifficulty = easyGame;
            } else if ([inputString isEqualToString:@"m"]) {
                NSLog(@"You chose a medium difficulty level.");
                gameDifficulty = normalGame;
            }  else if ([inputString isEqualToString:@"h"]) {
                NSLog(@"You chose a hard difficulty level.");
                gameDifficulty = hardGame;
            }
            
        }
        
        
        GameBoard *currentGameBoard = [[GameBoard alloc] initWithGameboardSize:boardSize difficulty:gameDifficulty];
        currentGameBoard.player1 = [[Player alloc] initWithBoardSpace:currentGameBoard.gameBoardSpaces[0]];
        currentGameBoard.player2 = [[Player alloc] initWithBoardSpace:currentGameBoard.gameBoardSpaces[0]];
        
        currentGameBoard.player1.playerName = @"";
        currentGameBoard.player2.playerName = @"";
        
        while ([currentGameBoard.player1.playerName isEqualToString:@""]) {
            NSLog(@"What's player 1's name? ");
            
            char buffer[20] = "";
            scanf("%s", buffer);
            NSString *inputString = [[NSString alloc] initWithUTF8String:buffer];
            inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            currentGameBoard.player1.playerName = inputString;
        }
        
        while ([currentGameBoard.player2.playerName isEqualToString:@""]) {
            NSLog(@"What's player 2's name? ");
            
            char buffer[20] = "";
            scanf("%s", buffer);
            NSString *inputString = [[NSString alloc] initWithUTF8String:buffer];
            inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            currentGameBoard.player2.playerName = inputString;
        }
        
        
        while (currentGameBoard.isPlayingGame) {
            
            [currentGameBoard status];
            
            // Ask the player to roll
            int roll = -1;
            while (roll == -1) {
                
                NSString *currentplayerName = currentGameBoard.player1.playerName;
                if ([currentGameBoard.currentPlayerTurn  isEqual: @1]) {
                    currentplayerName = currentGameBoard.player1.playerName;
                } else {
                    currentplayerName = currentGameBoard.player2.playerName;
                }
                NSLog(@"%@, what do you want to roll (1-6)? ", currentplayerName);
                
                // Get the response
                char buffer[20] = "";
                scanf("%s", buffer);
                roll = atoi(buffer);
                
                if (roll > 0 && roll <= 6) {
                    
                    [currentGameBoard moveCurrentPlayerForward:roll];
                    
                } else {
                    NSLog(@"Please enter a number 1 through 6.");
                }

            }
            
        }
        
        
    }
    return 0;
}
