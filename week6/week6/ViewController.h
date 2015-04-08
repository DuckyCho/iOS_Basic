//
//  ViewController.h
//  week6
//
//  Created by Ducky on 2015. 4. 8..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"
@interface ViewController : UIViewController
{
    @private
    MyScrollView * _myScrollView;
}

@property MyScrollView * _myScrollView;
@end

