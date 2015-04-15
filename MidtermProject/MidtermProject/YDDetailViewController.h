//
//  YDDetailViewController.h
//  Midterm
//
//  Created by Ducky on 2015. 4. 15..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *_title;
@property (weak, nonatomic) IBOutlet UIImageView *_img;
@property (weak, nonatomic) IBOutlet UILabel *_detail;
@property (nonatomic) NSDictionary * _data;

- (void)setData:(NSDictionary *)data;
@end
