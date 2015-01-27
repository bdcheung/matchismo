//
//  ViewController.m
//  Matchismo
//
//  Created by Brian Cheung on 1/26/15.
//  Copyright (c) 2015 Brian Cheung. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *redealDeckButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *numCardsMatchingSelector;
@property (nonatomic, assign) int numCardsMatching;
@property (nonatomic, strong) NSMutableArray *cardsForMatching;
@end

@implementation ViewController

-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]
                                                    numCardsToMatch:[self numCardsMatching] ? [self numCardsMatching] : 2];
    return _game;
                         
}

-(NSMutableArray *)cardsForMatching{
    if (!_cardsForMatching) _cardsForMatching = [[NSMutableArray alloc] init];
    return _cardsForMatching;
}

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.numCardsMatchingSelector.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void) updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
- (IBAction)touchRedealDeckButton:(UIButton *)sender {
    self.deck = nil;
    self.game = nil;
    [self createDeck];
    [self updateUI];
    self.numCardsMatchingSelector.enabled = YES;
}
- (IBAction)selectNumCardsMatchingControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        self.game = nil;
        self.numCardsMatching = 3;
    } else {
        self.game = nil;
        self.numCardsMatching = 2;
    }
}

@end