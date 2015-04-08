//
//  MyScrollView.m
//  week6
//
//  Created by Ducky on 2015. 4. 8..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView
@synthesize  _imageCacheIndex, _myScrollModel;
- (id)initWithImages{
    if(self = [super init]){
        self.delegate = self;
        [self set_imageCacheIndex:[[NSMutableArray alloc]init]];
        [self set_myScrollModel:[[MyScrollModel alloc]init]];
        self.bounces = NO;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    CGFloat screenHeight = self.frame.size.height;
    NSNumber * imgViewBottom;
    UIImageView * imgView;
    int i = -1;
    int j = 0;
    do{
        i++;
        if(i > 22){
            break;
        }
        imgViewBottom = [[self _imageCacheIndex] objectAtIndex:i];
    } while(scrollView.contentOffset.y + screenHeight > [imgViewBottom floatValue]);

    if( (_curIdx != i || !_curIdx) && i < 23 && i >= 0){
        _curIdx = i;
        j = i;
        while([[[self _imageCacheIndex] objectAtIndex:i] floatValue] -  [[[self _imageCacheIndex] objectAtIndex:j] floatValue] <  [[[self _imageCacheIndex] objectAtIndex:j] floatValue] - scrollView.contentOffset.y + screenHeight){
            j--;
        }
        for(UIView * view in self.subviews){
            if ([view isKindOfClass:[UIImageView class]]) {
                imgView = (UIImageView *)view;
                if( j <= imgView.tag && i >= imgView.tag){
                    _imageCacheArray[imgView.tag] = 1;
                }
                else{
                    _imageCacheArray[imgView.tag] = 0;
                    imgView.image = nil;
                    [view removeFromSuperview];
                }
            }
        }
        
        
        for( ; j <= i ;j++){
            if(!_imageCacheArray[j]){
                UIImage * tmpImage = [[self _myScrollModel] getImageByNumber:j];
                if(!tmpImage){
                    continue;
                }
                imgView = [[UIImageView alloc] initWithImage: tmpImage];
                imgView.tag = j;
                imgView.translatesAutoresizingMaskIntoConstraints = NO;
                [self addSubview:imgView];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:imgView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1.0
                                                              constant:0.0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:imgView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:imgView
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:tmpImage.size.height/tmpImage.size.width
                                                              constant:0.0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:imgView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:imgView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:0.0
                                                              constant:[[[self _imageCacheIndex] objectAtIndex:j-1] floatValue]]];
                [self needsUpdateConstraints];
            }
        }
    }
}

- (void)initImageCacheIndex{
    CGFloat totalHeight = 0;
    UIImage * tmpImage;
    NSString * picPath;
    NSData * picData;
    [[self _imageCacheIndex]addObject:[NSNumber numberWithFloat:totalHeight]];
    for(int i = 1 ; i < 23 ; i++){
        picPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%.2d",i] ofType:@"jpg"];
        picData = [[NSData alloc]initWithContentsOfFile:picPath];
        tmpImage = [[UIImage alloc] initWithData:picData];
        totalHeight += tmpImage.size.height * self.frame.size.width / tmpImage.size.width;
        [[self _imageCacheIndex]addObject:[NSNumber numberWithFloat:totalHeight]];
    }
    self.contentSize = CGSizeMake(self.frame.size.width, totalHeight);

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//}


@end
