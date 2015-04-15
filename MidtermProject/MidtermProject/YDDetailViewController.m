//
//  YDDetailViewController.m
//  Midterm
//
//  Created by Ducky on 2015. 4. 15..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "YDDetailViewController.h"

@interface YDDetailViewController ()

@end

@implementation YDDetailViewController

@synthesize _data;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _title].text = [[self _data] objectForKey:@"title"];
    [[self _title] setTextAlignment:NSTextAlignmentCenter];
    [self _detail].text = [[self _data] objectForKey:@"date"];
    UIImage * img = [UIImage imageNamed:[[self _data] objectForKey:@"image"]];
    [self _img].image = img;
    CGFloat ratio = img.size.height / img.size.width;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:[self _img]
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.7
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:[self _img]
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self _img]
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:ratio
                                                           constant:0.0]];
    [self.view updateConstraints];
}

- (void)setData:(NSDictionary *)data{
    [self set_data:data];
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
