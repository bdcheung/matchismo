//
//  Deck.h
//  Matchismo
//
//  Created by Brian Cheung on 1/26/15.
//  Copyright (c) 2015 Brian Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (NSInteger)cardCount;

-(Card *)drawRandomCard;
@end
