//
//  YDAlbumTableViewController.h
//  Midterm
//
//  Created by Ducky on 2015. 4. 15..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDAlbumModel.h"
#import "YDTableViewCell.h"
#import "YDDetailViewController.h"
@interface YDAlbumTableViewController : UITableViewController


@property (nonatomic) YDAlbumModel * _albumModel;
@property (nonatomic) NSInteger _numberOfSectionsInTableView;
@property (nonatomic) NSInteger _numberOfRowsInSection;
@property (nonatomic) BOOL _isSorted;
@property (nonatomic) NSMutableDictionary * _rowSectionMap;

@end
