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
@property(nonatomic, readwrite) NSInteger numCardsToMatch;
@property(nonatomic, readwrite) NSMutableArray *cardsForMatching;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = -1;

- (NSMutableArray*)cardsForMatching{
    if (!_cardsForMatching) _cardsForMatching = [[NSMutableArray alloc] init];
    return _cardsForMatching;
}
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck numCardsToMatch:(NSUInteger)target
{
    self = [super init];
    
    if (self) {
        self.numCardsToMatch = target;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen){
            card.chosen = NO;
            [self.cardsForMatching removeObject:card];
        } else {
            if (![self.cardsForMatching containsObject:card]){
                [self.cardsForMatching addObject:card];
            }
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    if (![self.cardsForMatching containsObject:card]){
                        [self.cardsForMatching addObject:otherCard];
                    }
                    if ([self.cardsForMatching count] == self.numCardsToMatch){
                        int matchScore = [card match:self.cardsForMatching];
                        if (matchScore){
                            self.score += matchScore * MATCH_BONUS;
                            NSMutableArray *objectsForRemoval = [NSMutableArray new];
                            for (Card *card in self.cardsForMatching){
                                if (card.isMatched) {
                                    [objectsForRemoval addObject:card];
                                }
                            }
                            
                            for (Card *card in objectsForRemoval){
                                [self.cardsForMatching removeObject:card];
                            }

                        } else {
                            self.score -= MISMATCH_PENALTY;
                            for (Card *someCard in self.cardsForMatching)
                            {
                                someCard.chosen = NO;
                            }
                            [self.cardsForMatching removeAllObjects];
                        }
                    }
                    break;
                }
            }
            if (![self.cardsForMatching containsObject:card] && !card.isMatched ){
                [self.cardsForMatching addObject:card];
            }
            self.score += COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}
@end
