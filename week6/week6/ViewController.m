//
//  ViewController.m
//  week6
//
//  Created by Ducky on 2015. 4. 8..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize _myScrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self set_myScrollView:[[MyScrollView alloc] initWithImages]];
    [self _myScrollView].translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_myScrollView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:[self _myScrollView]
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:[self _myScrollView]
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:[self _myScrollView]
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:[self _myScrollView]
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
}

- (void)viewDidLayoutSubviews{
    [[self _myScrollView] initImageCacheIndex];
    [[self _myScrollView] scrollViewDidScroll:[self _myScrollView]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
