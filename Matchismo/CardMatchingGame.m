//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Brian Cheung on 1/27/15.
//  Copyright (c) 2015 Brian Cheung. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property(nonatomic, readwrite) NSInteger score;
@property(nonatomic, strong) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}
@end
