//
//  CardDeckViewController.m
//  week4
//
//  Created by Ducky on 2015. 3. 25..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "CardDeckViewController.h"

@interface CardDeckViewController ()

@end

@implementation CardDeckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cardDeckModel = [[CardDeckModel alloc] initWithRandomSeed];
    cardTypeMap = @{@0:@"s",@1:@"d",@2:@"c",@3:@"h"};
    cardOrdermap = @{@0:@"A",@10:@"J",@11:@"Q",@12:@"K"};

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cardNumToCardImageName:) name:@"cardPick" object:nil];
    [cardDeckModel randomize];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        [cardDeckModel randomize];
    }
}

- (void)cardPickMotion{
    float posX = [self cardImageView].frame.origin.x;
    float posY = [self cardImageView].frame.origin.y;
    float width = [self cardImageView].frame.size.width;
    float height = [self cardImageView].frame.size.height;
    
    CGRect originFrame = CGRectMake(posX, posY, width, height);
    CGRect newFrame = CGRectMake(posX, posY-30, width, height);
    [self cardImageView].frame = newFrame;
    [UIView animateWithDuration:0.5 animations:^{[self cardImageView].frame = originFrame;}];
    [self randomButton];
    
}

- (void)cardNumToCardImageName:(NSNotification *)noti{
    @autoreleasepool {
        int cardNum = [[noti.userInfo objectForKey:@"cardNum"] intValue];
        NSNumber * cardType = [[NSNumber alloc]initWithInt: cardNum / 13];
        NSNumber * cardOrder = [[NSNumber alloc]initWithInt: cardNum % 13];
        NSString * cardOrderStr = [cardOrdermap objectForKey:cardOrder];
        if(!cardOrderStr){
            cardOrderStr = [NSString stringWithFormat:@"%d",[cardOrder intValue]+1];
        }
        NSLog(@"cardNum : %d",cardNum);
        NSLog(@"cardType : %d, cardOrder : %d",[cardType intValue], [cardOrder intValue]);
        __weak NSString * imgName = [NSString stringWithFormat:@"%@%@",[cardTypeMap objectForKey:cardType],cardOrderStr];
        [self changeCardImage:imgName];
    }
}
-(void)changeCardImage:(NSString *)cardName{
    @autoreleasepool {
        UIImage * cardImg = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:cardName ofType:@"png"]];
        [[self cardImageView] setImage:cardImg];
        [self cardPickMotion];
    }
}


- (IBAction)randomButtonTouched:(id)sender {
    [cardDeckModel randomize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
