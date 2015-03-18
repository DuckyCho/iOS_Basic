//
//  ViewController.m
//  week3
//
//  Created by Ducky on 2015. 3. 18..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize model;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * jsonData = @"￼[{\"id\": \"001\", \"name\" : \"john\"}, {\"id\": \"007\", \"name\" : \"james\"}]";
    NSString * jsonData2 = @"[{\"title\":\"\uc0c8\uae001\",\"image\":\"01.jpg\",\"content\":\"\uc601\ud654\ubcf4\ub7ec\uac00\uc790\",\"comments\":[{\"id\":1,\"user\":\"jobs\",\"comment\":\"apple\"},{\"id\": 4,\"user\":\"cook\",\"comment\":\"apple\"}]},{\"title\":\"\ud1a0\uc774\uc2a4\ud1a0\ub9ac?\",\"image\":\"02.jpg\",\"content\":\"Pixar\",\"comments\":[]},{\"title\":\"ToyStory\",\"image\":\"03.jpg\",\"content\":\"\uc6b0\ub514\uac00\ucd5c\uace0\",\"comments\":[{\"id\":2,\"user\":\"bill\",\"comment\":\"Microsoft\"}]},{\"title\":\"\uadf9\uc7a5\uc740\",\"image\":\"04.jpg\",\"content\":\"\uc5b4\ub514\ub85c\",\"comments\":[{\"id\":4,\"user\":\"cook\",\"comment\":\"apple\"}]}]";
    srand((unsigned)time(NULL));
    JSONSerializer * worker =[[JSONSerializer alloc]init];
    NSObject * resultObj = [worker JSONParser:jsonData];
    NSLog(@"JSON String -> Object // %@",resultObj);
    NSString * resultStr = [worker MyJSONMakerWithArray:(NSArray *)resultObj];
    NSLog(@"NSArray Object -> JSON String // %@",resultStr);
    NSObject * resultObj2 = [worker JSONParser:jsonData2];
    NSLog(@"JSON String -> Object // %@",resultObj2);
    [self setModel: [[Model alloc]initWithDataArr:(NSArray *)resultObj2]];

    NSDictionary * dataDict = [model itemAtIndex:[self getRandNumWithMaxNum:[[model data] count]]];
    NSString * title = [dataDict objectForKey:@"title"];
    NSString * imgName = [dataDict objectForKey:@"image"];
    UIImage * img = [UIImage imageNamed:imgName];
    [[self titleLabel]setText:title];
    [[self imgView]setImage:img];

}

- (IBAction)randButtonTouched:(id)sender {
    NSDictionary * dataDict = [model itemAtIndex:[self getRandNumWithMaxNum:[[model data] count]]];
    NSString * title = [dataDict objectForKey:@"title"];
    NSString * imgName = [dataDict objectForKey:@"image"];
    UIImage * img = [UIImage imageNamed:imgName];
    [[self titleLabel]setText:title];
    [[self imgView]setImage:img];
}

-(int)getRandNumWithMaxNum:(NSUInteger)maxNum{
    return rand()%maxNum;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
