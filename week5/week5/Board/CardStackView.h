//
//  CardStackView.h
//  week5
//
//  Created by Ducky on 2015. 4. 1..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CARD_WIDTH 130
#define CARD_HEIGHT 150
#define CARD_DISTANCE 40
#define CARD_DISTANCE_HORIZON 24
#define CARD_DECK_DISTANCE 10
#define VERTICAL 0
#define HORIZON 1

@interface CardStackView : UIView
{
    NSUInteger direction;
    NSUInteger cardDeckCol;
    NSUInteger cardDeckSize;
    NSMutableArray * cardDeck;
}
@property NSUInteger direction;
@property NSUInteger cardDeckCol;
@property NSUInteger cardDeckSize;
@property (strong) NSMutableArray * cardDeck;

+ (NSDictionary *)getCardTypeMap;
+ (NSDictionary *)getCardOrderMap;

- (id)initCardStackViewWithCardDeckSizeAndCol:(NSUInteger)size col:(NSUInteger)col direction:(int)newDirection;
- (void)addCardToCardDeck:(NSNumber *)cardNum;
- (void)refresh;
- (void)showCard;
- (NSString *)cardNumToCardImageName:(NSNumber *)cardNum;


@end
