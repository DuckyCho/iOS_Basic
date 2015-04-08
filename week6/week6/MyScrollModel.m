//
//  MyScrollModel.m
//  week6
//
//  Created by Ducky on 2015. 4. 8..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "MyScrollModel.h"

@implementation MyScrollModel


- (UIImage *)getImageByNumber:(int)idx{
    NSString * picPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%.2d",idx] ofType:@"jpg"];
    NSData * picData = [[NSData alloc]initWithContentsOfFile:picPath];
    return [[UIImage alloc] initWithData:picData];
}
@end
