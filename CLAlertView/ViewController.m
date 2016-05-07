//
//  ViewController.m
//  CLAlertView
//
//  Created by zyyt on 16/4/30.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import "ViewController.h"
#import "CLAlertView.h"
@interface ViewController ()<CLAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(id)sender {
    CLAlertView *bottomView = [CLAlertView globeBottomView];
    bottomView.delegate = self;
    bottomView.hlightButton = 1;
    bottomView.titleArray = @[@"收入",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出"];
    bottomView.title = @"记一笔";
    [bottomView show];
}

@end
