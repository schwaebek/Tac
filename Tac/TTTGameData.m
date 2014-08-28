//
//  TTTGameData.m
//  Tac
//
//  Created by Katlyn Schwaebe on 8/28/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import "TTTGameData.h"
#import "TTTViewController.h"
#import "TTTTouchSpot.h"

@implementation TTTGameData
{
    NSArray * possibilities;
}

+ (TTTGameData *) mainData
{
    static dispatch_once_t onceToken;
    static TTTGameData * singleton = nil;
    dispatch_once(&onceToken, ^{
        singleton = [[TTTGameData alloc] init];
    });
    
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spots = [@[] mutableCopy];
        self.player1Turn = YES;
        possibilities = @[
                              @[@0,@1,@2],
                              @[@3,@4,@5],
                              @[@6,@7,@8],
                              @[@0,@3,@6],
                              @[@1,@4,@7],
                              @[@2,@5,@8],
                              @[@0,@4,@8],
                              @[@2,@4,@6],
                              ];
    }
    return self;
}
-(void)setPlayer1Turn:(BOOL)player1Turn
{
    _player1Turn = player1Turn;
    if(player1Turn == NO)
    {
        [self robotChooseSpot];
        //run robot
        //set a spot.player
        //change player1 turn
        //check for winner
    }
}
-(void)robotChooseSpot
{
    if ([self findWinningSpot])
    {
        self.player1Turn = !self.player1Turn;
        [self checkForWinner];
        return;
    }
    if ([self findBlockingSpot])
    {
        self.player1Turn = !self.player1Turn;
        [self checkForWinner];
        return;
    }
    for (TTTTouchSpot * spot in self.spots)
    {
        if(spot.player == 0)
        {
            spot.player =2;
            self.player1Turn = !self.player1Turn;
            [self checkForWinner];
            return;
        }
    }
}
-(BOOL)findWinningSpot
{
    for (NSArray * possibility in possibilities)
    {
        if([self checkForSpotWithSpots:possibility player:2]) return YES;
        NSArray * possibility2 = @[possibility[1],possibility[2],possibility[0]];
        if([self checkForSpotWithSpots:possibility2 player:2]) return YES;
        NSArray * possibility3 = @[possibility[2],possibility[0],possibility[1]];
        if([self checkForSpotWithSpots:possibility3 player:2]) return YES;
            }
    return NO;
}
-(BOOL)checkForSpotWithSpots:(NSArray *)spots player:(int)player
{
    TTTTouchSpot * spot0 = self.spots[[spots [0] intValue]];
    TTTTouchSpot * spot1 = self.spots[[spots [1] intValue]];
    TTTTouchSpot * spot2 = self.spots[[spots [2] intValue]];
    if (spot0.player == player && spot1.player == player && spot2.player == 0)
    {
        spot2.player = 2;
        return YES;
    }
    return NO;
}
-(BOOL)findBlockingSpot
{
    for (NSArray * possibility in possibilities)
    {
        if([self checkForSpotWithSpots:possibility player:1]) return YES;
        NSArray * possibility2 = @[possibility[1],possibility[2],possibility[0]];
        if([self checkForSpotWithSpots:possibility2 player:1]) return YES;
        NSArray * possibility3 = @[possibility[2],possibility[0],possibility[1]];
        if([self checkForSpotWithSpots:possibility3 player:1]) return YES;
    }
    return NO;
}
-(BOOL)findRandomSpot
{
    for (NSArray * possibility in possibilities)
    {
        TTTTouchSpot * spot0 = self.spots[[possibility [0] intValue]];
        TTTTouchSpot * spot1 = self.spots[[possibility [1] intValue]];
        TTTTouchSpot * spot2 = self.spots[[possibility [2] intValue]];
    }
    return NO;
}
-(void) checkForWinner
{
    
    
    BOOL winner = NO;
    
    for (NSArray * possibility in possibilities)
    {
        
        TTTTouchSpot * spot0 = self.spots[[possibility [0] intValue]];
        TTTTouchSpot * spot1 = self.spots[[possibility [1] intValue]];
        TTTTouchSpot * spot2 = self.spots[[possibility [2] intValue]];
        
        if (spot0.player == spot1.player && spot1.player == spot2.player && spot0.player != 0)
        {
            winner = YES;
            NSLog(@"player %d won", spot0.player);
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Winner" message:[NSString stringWithFormat:@"Player %d Won", spot0.player] delegate:self cancelButtonTitle:@"Start Over" otherButtonTitles: nil];
            [alert show];
            
        }
    }
    int emptySpots = 0;
    for (TTTTouchSpot * spot in self.spots)
    {
        if (spot.player == 0)
        {
            emptySpots++;
        }
    }
    if (emptySpots == 0 && !winner)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Draw" message:@"YOU'RE BOTH LOSERS." delegate:self cancelButtonTitle:@"Start Over" otherButtonTitles: nil];
        [alert show];
    }
}
- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.player1Turn = YES;
    for (TTTTouchSpot * spot in self.spots)
    {
        spot.player = 0;
    }
}


@end
