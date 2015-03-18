//
//  ViewController.h
//  week3
//
//  Created by Ducky on 2015. 3. 18..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONSerializer.h"
#import "Model.h"

@interface ViewController : UIViewController
{
    Model * model;

}

@property Model * model;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *randButton;

- (IBAction)randButtonTouched:(id)sender;

-(int)getRandNumWithMaxNum:(NSUInteger)maxNum;

@end

