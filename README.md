# CLAlertView
一个底部弹出视图
使用方式
CLAlertView *bottomView = [CLAlertView globeBottomView];
bottomView.delegate = self;
bottomView.hlightButton = 1;
bottomView.titleArray = @[@"收入",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出",@"支出"];
bottomView.title = @"记一笔";
[bottomView show];
