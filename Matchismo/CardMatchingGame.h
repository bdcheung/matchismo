//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Brian Cheung on 1/27/15.
//  Copyright (c) 2015 Brian Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// This is the designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly) NSInteger score;

@end
