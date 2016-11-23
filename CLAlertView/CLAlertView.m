//
//  YJGlobeBottomView.m
//  E_Jian
//
//  Created by zyyt on 16/4/14.
//  Copyright © 2016年 Justin. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
#import "CLAlertView.h"
//#import "UITableViewCell+CreatCell.h"
//#import "UIColor+RGBChange.h"
@interface CLAlertView ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UILabel *titleLabel;

@property (weak,nonatomic) UITableView *tableView;

@property (weak,nonatomic) UIButton *disSelectButton;


@property (weak,nonatomic) UIView *backView;
@end

@implementation CLAlertView
+ (id)globeBottomView{
    return [[self alloc]init];
}
- (void)show{
    //    YJGlobeBottomView *globe = [[YJGlobeBottomView alloc]init];
    UIWindow *currentWindows = [UIApplication sharedApplication].keyWindow;
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    [currentWindows addSubview:self];
    
    [UIView animateWithDuration:.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.backView.frame = ScreenBounds;
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dissMissView];
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    self.frame = ScreenBounds;
    [self setUpCellSeparatorInset];
}

- (void)setTitleArray:(NSArray *)titleArray{
    
    _titleArray = titleArray;
    
    if (titleArray.count * 51 >= (ScreenHeight *2/3- 52)) {
        self.backView.frame = CGRectMake(0, ScreenHeight *1/3 - 51, ScreenWidth, ScreenHeight);
        
        self.tableView.frame = CGRectMake(0, ScreenHeight *1/3, ScreenWidth, ScreenHeight *2/3- 55);
        self.titleLabel.center = CGPointMake(ScreenWidth/2, ScreenHeight *1/3 - 26);
        
    }else{
        self.backView.frame = CGRectMake(0, ScreenHeight -  titleArray.count * 51 - 99, ScreenWidth, ScreenHeight);
        
        self.tableView.frame = CGRectMake(0, ScreenHeight -  self.titleArray.count * 51 - 55, ScreenWidth, titleArray.count * 51);
        self.titleLabel.center = CGPointMake(ScreenWidth/2, ScreenHeight -  titleArray.count * 51 - 77);
    }
    self.disSelectButton.frame = CGRectMake(0, ScreenHeight - 51, ScreenWidth, 51);
    
}
- (void)setHlightButton:(NSInteger)hlightButton{
    _hlightButton = hlightButton;
    _hlightString = @"";
    [self.tableView reloadData];
}
- (void)setHlightString:(NSString *)hlightString{
    _hlightString = hlightString;
    _hlightButton = -1;
    [self.tableView reloadData];
}
- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}
- (void)setColorStr:(UIColor *)colorStr{
    _colorStr = colorStr;
    [self.tableView reloadData];
}
#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
        titleLabel.bounds = CGRectMake(0, 0, ScreenWidth, 51);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor colorWithWhite:0.239 alpha:1.000];
        [self.backView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UIView *)backView{
    if (_backView == nil) {
        
        UIView *view = [[UIView alloc]init];
        view.bounds = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self addSubview:view];
        _backView = view;
    }
    return _backView;
}
- (UIButton *)disSelectButton{
    if (_disSelectButton == nil) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setAdjustsImageWhenHighlighted:YES];
        [button addTarget:self action:@selector(dissMissView) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:button];
        _disSelectButton = button;
    }
    return _disSelectButton;
}
- (void)dissMissView{
    
    [UIView animateWithDuration:.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.backView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        tableView.bounces = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.backView addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.frame = CGRectMake(0,0, ScreenWidth, 51);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == self.hlightButton || [self.titleArray[indexPath.row] isEqualToString:self.hlightString]) {
        if (self.colorStr == nil) {
            cell.textLabel.textColor = [UIColor colorWithRed:0.983 green:0.834 blue:0.206 alpha:1.000];
        }else {
            cell.textLabel.textColor = self.colorStr;
        }
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(globeBottomViewButtonClick:)]) {
        [self.delegate globeBottomViewButtonClick:indexPath.row];
    }
    
    if (self.globeBottomView) {
        self.globeBottomView(indexPath.row, _titleArray[indexPath.row]);
    }
    [self dissMissView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
}
- (void)setUpCellSeparatorInset
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
@end
