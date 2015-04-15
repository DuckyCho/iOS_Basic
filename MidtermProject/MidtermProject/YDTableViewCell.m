//
//  YDTableViewCell.m
//  MidtermProject
//
//  Created by Ducky on 2015. 4. 15..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "YDTableViewCell.h"

@implementation YDTableViewCell
@synthesize _title, _detail;

- (void)awakeFromNib {
    // Initialization code
    

    
}

- (void)setData:(NSDictionary *)data{
    [self set_title:[[UILabel alloc] init]];
    [self set_detail:[[UILabel alloc] init]];
    [[self _title] setTextColor:[UIColor whiteColor]];

    [self _title].text = [data objectForKey:@"title"];
    [[self _title] setFont:[UIFont fontWithName:@"HelveticaNeue" size:17]];
    [self _title].translatesAutoresizingMaskIntoConstraints = NO;
    [[self _detail] setTextColor:[UIColor grayColor]];
    [self _detail].text = [data objectForKey:@"date"];
    [[self _detail] setFont:[UIFont fontWithName:@"HelveticaNeueLight" size:10]];
    [self _detail].translatesAutoresizingMaskIntoConstraints = NO;
    self.clipsToBounds =YES;
    self.backgroundView.clipsToBounds=YES;
    [self setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:[data objectForKey:@"image"]]]];
    [self backgroundView].contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    

    [self addSubview:[self _title]];
    [self addSubview:[self _detail]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self _title]
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:-20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self _title]
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:-20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self _title]
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
  
    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self _detail]
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:[self _title]
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self _detail]
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:[self _title]
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:5.0]];

}

- (void)removeAllSubviews{
    for(UIView * view in self.subviews){
        [view removeFromSuperview];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
