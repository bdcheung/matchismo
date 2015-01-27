//
//  PlayingCard.m
//  Matchismo
//
//  Created by Brian Cheung on 1/26/15.
//  Copyright (c) 2015 Brian Cheung. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


@synthesize suit = _suit; // Because we define the setter AND getter methods
+ (NSArray *)validSuits{
    return @[@"♥",@"♦",@"♠",@"♣"];
}
- (void)setSuit:(NSString *)suit{if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    } }
- (NSString *)suit{
    return _suit ? _suit : @"?";
}
+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count]-1;}

- (void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count]){
        for (PlayingCard *otherCard in otherCards) {
            if (otherCard.rank == self.rank) {
                score += 4;
                otherCard.matched = YES;
                self.matched = YES;
            } else if ([otherCard.suit isEqualToString:self.suit]) {
                score += 1;
                otherCard.matched = YES;
                self.matched = YES;
            }
        }
    }
    
    return score;
}
@end

