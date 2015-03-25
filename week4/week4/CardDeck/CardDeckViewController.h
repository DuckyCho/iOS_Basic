//
//  CardDeckViewController.h
//  week4
//
//  Created by Ducky on 2015. 3. 25..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDeckModel.h"

@interface CardDeckViewController : UIViewController
{
    CardDeckModel * cardDeckModel;
    NSDictionary * cardTypeMap;
    NSDictionary * cardOrdermap;
}

@property (weak, nonatomic) IBOutlet UIButton *randomButton;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

- (void)cardNumToCardImageName:(NSNotification *)noti;
- (void)changeCardImage:(NSString *)cardName;
- (void)cardPickMotion;
@end
