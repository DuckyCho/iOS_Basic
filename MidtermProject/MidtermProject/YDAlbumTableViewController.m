//
//  YDAlbumTableViewController.m
//  Midterm
//
//  Created by Ducky on 2015. 4. 15..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "YDAlbumTableViewController.h"

@interface YDAlbumTableViewController ()

@end

@implementation YDAlbumTableViewController

@synthesize _albumModel, _numberOfSectionsInTableView, _numberOfRowsInSection, _isSorted, _rowSectionMap;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self set_isSorted:NO];
    [self registerNotificationObserver];
    [self set_albumModel:[[YDAlbumModel alloc]initWithDefaultData]];
    self.navigationItem.title = @"Album";
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(sortCell:)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(motion == UIEventSubtypeMotionShake){
        [[self _albumModel] resetData];
    }
}

- (void)sortCell:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortData" object:nil];
}


- (void)registerNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReload:) name:@"dataReady" object:nil];
}

- (void)tableViewReload:(NSNotification *)noti{
    NSDictionary * userInfo  = noti.userInfo;
    if(![userInfo objectForKey:@"sectionRowMap"]){
        [self set_isSorted:NO];
        [self set_numberOfSectionsInTableView:[[userInfo objectForKey:@"numberOfSectionsInTableView"] integerValue]];
        [self set_numberOfRowsInSection:[[userInfo objectForKey:@"numberOfRowsInSection"] integerValue]];
    }
    else{
        [self set_isSorted:YES];
        [self set_numberOfSectionsInTableView:[[userInfo objectForKey:@"numberOfSectionsInTableView"] integerValue]];
        [self set_rowSectionMap:[NSMutableDictionary dictionaryWithDictionary:[userInfo objectForKey:@"sectionRowMap"]]];
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"detailViewShow"]){
        YDDetailViewController * detailView = [segue destinationViewController];
        NSIndexPath * idxPath = [self.tableView indexPathForSelectedRow];
        [detailView setData:[[self _albumModel] getData:idxPath.row]];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self _numberOfSectionsInTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(![self _isSorted])
        return [self _numberOfRowsInSection];
    else{
        return [[[self _rowSectionMap] objectForKey:[NSNumber numberWithInteger:section]] integerValue];
    }
}


-  (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if([self _isSorted]){
        return [[self _albumModel] getSectionName:section];
    }
    else
        return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([self _isSorted]){
        return 17;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDTableViewCell * tableViewCell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellType0" forIndexPath:indexPath];
    if([cell isKindOfClass:[YDTableViewCell class]]){
        tableViewCell = (YDTableViewCell *)cell;
    }
    NSInteger row;
    NSDictionary * data;
    if(![self _isSorted]){
    row = indexPath.row;
    data = [[self _albumModel] getData:row];
    }
    else{
        NSInteger prevSecionCount;
        if(indexPath.section == 0){
            prevSecionCount = [[[self _rowSectionMap] objectForKey:[NSNumber numberWithInteger:indexPath.section]] integerValue];
        }
        else{
            prevSecionCount = [[[self _rowSectionMap] objectForKey:[NSNumber numberWithInteger:indexPath.section-1]] integerValue];
        }
        row = indexPath.section * prevSecionCount + indexPath.row;
        data = [[self _albumModel] getData:row];
    }
    [tableViewCell removeAllSubviews];
    [tableViewCell setData:data];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSInteger row = indexPath.row;
        if(![self _isSorted]){
            [[self _albumModel] deleteData:row];
            [self set_numberOfRowsInSection:[self _numberOfRowsInSection]-1];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else{
            NSInteger prevSecionCount;
            if(indexPath.section == 0){
                prevSecionCount = [[[self _rowSectionMap] objectForKey:[NSNumber numberWithInteger:indexPath.section]] integerValue];
            }
            else{
                prevSecionCount = [[[self _rowSectionMap] objectForKey:[NSNumber numberWithInteger:indexPath.section-1]] integerValue];
            }
            row = indexPath.section * prevSecionCount + indexPath.row;
            [[self _albumModel] deleteData:row];
            NSInteger newRowNum = [[[self _rowSectionMap] objectForKey:[NSNumber numberWithInteger:indexPath.section]] integerValue] -1 ;
            [[self _rowSectionMap] setObject:[NSNumber numberWithInteger:newRowNum] forKey:[NSNumber numberWithInteger:indexPath.section]];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
