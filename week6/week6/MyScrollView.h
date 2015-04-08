//
//  MyScrollView.h
//  week6
//
//  Created by Ducky on 2015. 4. 8..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MyScrollModel.h"

@interface MyScrollView : UIScrollView <UIScrollViewDelegate>
{
    @private
    CGFloat _screenHeight;
    NSMutableArray * _imageCacheIndex;
    int _imageCacheArray[23];
    MyScrollModel * _myScrollModel;
    int _curIdx;
}

@property NSMutableArray * _imageCacheIndex;
@property MyScrollModel * _myScrollModel;
- (id)initWithImages;
- (void)initImageCacheIndex;

@end
