//
//  CardBoardViewController.m
//  week5
//
//  Created by Ducky on 2015. 4. 1..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "CardBoardViewController.h"

@interface CardBoardViewController ()

@end

@implementation CardBoardViewController
@synthesize cardDecks, isAlreadyPicked;
- (void)viewDidLoad {
    [super viewDidLoad];
    srand((unsigned)time(NULL));
    isStarted = false;
    [self setCardDecks:[[NSMutableArray alloc] initWithCapacity:CARD_DECKS_NUM]];
    [self initIsAlreadyPicked];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shuffleButtonTouched:(id)sender {
    if(!isStarted){
        isStarted = true;
        [self shuffleCards];
    }
    else{
        for(int i = 0 ; i < [[self cardDecks]count] ; i++){
            [[cardDecks objectAtIndex:i] refresh];
        }
        [cardDecks removeAllObjects];
        [[self isAlreadyPicked] removeAllObjects];
        NSNumber * falseObj;
        for(int i = 0 ; i < 52 ; i++){
            falseObj = [[NSNumber alloc] initWithBool:false];
            [[self isAlreadyPicked] setObject:falseObj atIndexedSubscript:i];
            [falseObj release];
        }
        [self shuffleCards];
    }
}

- (void)shuffleCards{
    CardStackView * cardStackView;
    for(int i = 0 ; i < 7 ; i++){
        cardStackView = [[CardStackView alloc] initCardStackViewWithCardDeckSizeAndCol:i+1 col:i direction:VERTICAL];
        [self initCardStack:cardStackView];
        [[self cardDecks] addObject:cardStackView];
        [cardStackView release];
    }
    cardStackView = [[CardStackView alloc] initCardStackViewWithCardDeckSizeAndCol:EXTRA_CARD col:7 direction:HORIZON];
    [self initCardStack:cardStackView];
    [[self cardDecks] addObject:cardStackView];
    [cardStackView release];
    [self displayCards];
}

- (void)initCardStack:(CardStackView *)cardStackView{
    NSNumber * card;
    for(int i = 0 ; i < [cardStackView cardDeckSize] ; i++){
        card = [[NSNumber alloc] initWithInt:[self getCardFromCardStack]];
        [cardStackView addCardToCardDeck:card];
        [card release];
    }
}

- (void)initIsAlreadyPicked{
    [self setIsAlreadyPicked:[[NSMutableArray alloc]initWithCapacity:52]];
    NSNumber * falseObj;
    for(int i = 0 ; i < 52 ; i++){
        falseObj = [[NSNumber alloc] initWithBool:false];
        [[self isAlreadyPicked] setObject:falseObj atIndexedSubscript:i];
        [falseObj release];
    }
}

- (NSUInteger)getCardFromCardStack{
    int randNum;
    NSNumber * tmp;
    do{
        randNum = rand()%52;
    } while([[[self isAlreadyPicked]objectAtIndex:randNum] boolValue]);
    [[[self isAlreadyPicked] objectAtIndex:randNum] release];
    tmp = [[NSNumber alloc] initWithBool:TRUE];
    [[self isAlreadyPicked] setObject:tmp atIndexedSubscript:randNum];
    [tmp release];
    return randNum;
}


- (void)displayCards{
        for (int i = 0 ;i < CARD_DECKS_NUM ;i++){
            [[[self cardDecks] objectAtIndex:i]showCard];
            [self.view addSubview:[[self cardDecks] objectAtIndex:i]];
        }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [cardDecks release];
    [isAlreadyPicked release];
    [_shuffleButton release];
    [super dealloc];
}
@end
