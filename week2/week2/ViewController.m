//
//  ViewController.m
//  week2
//
//  Created by Ducky on 2015. 3. 11..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "ViewController.h"
#import "NXPersonModel.h"
#import "WordLadder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *personFilePath = [[NSBundle mainBundle] pathForResource:@"persons" ofType:@"txt"];
    NXPersonModel * personModel = [[NXPersonModel alloc]initWithPersonListPath:personFilePath];
    
    //index로 이름, 번호, 팀번호, person dictionary 가져오기
    for(int i = 0 ; i < [personModel personList].count; i++ ){
        NSLog(@"%@",[personModel personNameAtIndex:i]);
        NSLog(@"%@",[personModel personNumberAtIndex:i]);
        NSLog(@"%@",[personModel personTeamAtIndex:i]);
        NSLog(@"%@",[personModel getPersonObjectAtIndex:i]);
    }
    
    //번호, 이름으로 원하는 person의 attribute 출력
    NSLog(@"%@", [personModel findPersonNameByNumber:[NSNumber numberWithInt: 141083]]);
    NSLog(@"%@", [personModel findPersonNumberByName:@"조영대"]);
    
    
    //sorting
    NSLog(@"이름으로 정렬된 결과입니다");
    NSArray * sortedByNameArr = [personModel sortedByName];
    for(NSDictionary * dic in sortedByNameArr){
        NSLog(@"%@",[dic valueForKey:@"name"]);
    }
    NSLog(@"팀번호로 정렬된 결과입니다");
    NSLog(@"%@",[personModel sortedByTeam]);
    NSLog(@"번호로 정렬된 결과입니다");
    NSLog(@"%@",[personModel sortedByNumber]);


    //플러스 미션 : 다 했습니다.
    WordLadder * wl = [[WordLadder alloc] initWithStartEndWord:@"hit" inputEnd:@"cog" inputDict:[NSArray arrayWithObjects:@"hot",@"dot",@"dog", @"lot",@"log", nil]];
    NSArray * result = [wl getResult];
    NSLog(@"%@",result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
