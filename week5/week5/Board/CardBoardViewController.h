//
//  CardBoardViewController.h
//  week5
//
//  Created by Ducky on 2015. 4. 1..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardStackView.h"

@interface CardBoardViewController : UIViewController
{
    BOOL isStarted;
    NSMutableArray * cardDecks;
    NSMutableArray * isAlreadyPicked;
    
}

#define CARD_DECKS_NUM 8
#define EXTRA_CARD 24
@property (retain, nonatomic) IBOutlet UIButton *shuffleButton;

@property (strong) NSMutableArray * cardDecks;
@property (strong) NSMutableArray * isAlreadyPicked;
- (IBAction)shuffleButtonTouched:(id)sender;
- (void)shuffleCards;
- (void)initCardStack:(CardStackView *)cardStackView;
- (void)initIsAlreadyPicked;
- (NSUInteger)getCardFromCardStack;
- (void)displayCards;
@end
