//
//  CardStackView.m
//  week5
//
//  Created by Ducky on 2015. 4. 1..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "CardStackView.h"

@implementation CardStackView
@synthesize cardDeckCol, cardDeckSize, cardDeck;

+ (NSDictionary *)getCardTypeMap{
    return @{@0:@"s",@1:@"d",@2:@"c",@3:@"h"};
}
+ (NSDictionary *)getCardOrderMap{
    return @{@0:@"A",@10:@"J",@11:@"Q",@12:@"K"};
}

- (id)initCardStackViewWithCardDeckSizeAndCol:(NSUInteger)size col:(NSUInteger)col direction:(int)newDirection{
    if(self = [super init]){
        [self setDirection:newDirection];
        [self setCardDeckCol:col];
        [self setCardDeckSize:size];
        [self setCardDeck:[[NSMutableArray alloc] initWithCapacity:[self cardDeckSize]]];
        if([self direction] == VERTICAL){
            [self setFrame:CGRectMake([self cardDeckCol]*(CARD_WIDTH+10)+26, 100, CARD_WIDTH, CARD_HEIGHT+(40*[self cardDeckSize]))];
        }
        else{
            [self setFrame:CGRectMake(26, 500, CARD_WIDTH + 24*[self cardDeckSize], CARD_HEIGHT)];
        }
        for(int i = 0 ; i < size ;i ++){
            UIImageView * imageView;
            if([self direction]== VERTICAL){
                imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, i*CARD_DISTANCE, CARD_WIDTH, CARD_HEIGHT)];
            }
            else{
                imageView= [[UIImageView alloc]initWithFrame:CGRectMake(i*CARD_DISTANCE_HORIZON, 0, CARD_WIDTH, CARD_HEIGHT)];
            }
            [imageView setTag:i];
            [self addSubview:imageView];
            [imageView release];
        }
        
    }
    return self;
}

- (void)addCardToCardDeck:(NSNumber *)cardNum{
    [[self cardDeck]addObject:cardNum];
}

- (void)refresh{
    [[self cardDeck] removeAllObjects];
    int i = 0;
    for (UIView *view in self.subviews){
        if([view isKindOfClass:[UIImageView class]]){
            UIImageView * imgView = (UIImageView *)view;
            [imgView removeFromSuperview];
            if([self direction]== VERTICAL){
                imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0+(i*CARD_DISTANCE), CARD_WIDTH, CARD_HEIGHT)];
            }
            else{
                imgView= [[UIImageView alloc]initWithFrame:CGRectMake(i*CARD_DISTANCE_HORIZON, 0, CARD_WIDTH, CARD_HEIGHT)];
            }
            [imgView setTag:i];
            [self addSubview:imgView];
            [imgView release];
            i++;
        }
    }
    [[self cardDeck] release];
}

- (void)showCard{
    @autoreleasepool {
        NSString * cardImgName;
        NSString * cardImgPath;
        UIImage * cardImg;
        int i = 0;
        for (UIView *view in self.subviews){
            if([view isKindOfClass:[UIImageView class]]){
                UIImageView * imgView = (UIImageView *)view;
                cardImgName = [self cardNumToCardImageName:[cardDeck objectAtIndex:i]];
                cardImgPath = [[NSBundle mainBundle] pathForResource:cardImgName ofType:@"png"];
                cardImg = [[UIImage alloc] initWithContentsOfFile:cardImgPath];
                imgView.image = nil;
                imgView.image = cardImg;
                i++;
                [cardImg release];
            }
        }
    }
}

- (NSString *)cardNumToCardImageName:(NSNumber *)cardNum{
    NSNumber * cardType = [[NSNumber alloc]initWithInt: [cardNum intValue] / 13];
    NSNumber * cardOrder = [[NSNumber alloc]initWithInt: [cardNum intValue] % 13];
    NSDictionary * cardTypeMap = [CardStackView getCardTypeMap];
    NSDictionary * cardOrderMap = [CardStackView getCardOrderMap];

    NSString * cardOrderStr = [cardOrderMap objectForKey:cardOrder];
    if(!cardOrderStr){
        cardOrderStr = [NSString stringWithFormat:@"%d",[cardOrder intValue]+1];
    }
    NSLog(@"cardNum : %d",[cardNum intValue]);
    NSLog(@"cardType : %d, cardOrder : %d",[cardType intValue], [cardOrder intValue]);
    NSString * imgName = [[[NSString alloc]initWithFormat:@"%@%@",[cardTypeMap objectForKey:cardType],cardOrderStr] autorelease];

    [cardType release];
    [cardOrder release];
    return imgName;
    
}

- (NSString *)description
{   
    NSString * desc = [[[NSString alloc]initWithFormat:@"%@",[self cardDeck]] autorelease];
    return desc;
}

- (void)dealloc
{   [super dealloc];
    [cardDeck release];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
