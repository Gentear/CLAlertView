//
//  YJGlobeBottomView.h
//  E_Jian
//
//  Created by zyyt on 16/4/14.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CLAlertViewDelegate <NSObject>

/**
 *  按钮点击回调  从0开始
 *
 *  @param index <#index description#>
 */
@optional


- (void)globeBottomViewButtonClick:(NSInteger)index;

@end

@interface CLAlertView : UIView

/**
 *  名字数组
 */
@property (strong,nonatomic) NSArray *titleArray;
/**
 *  标题
 */
@property (strong,nonatomic) NSString *title;
/**
 *   高亮的行数
 */
@property (assign,nonatomic) NSInteger hlightButton;
/**
 *  高亮的文字
 */
@property (strong,nonatomic) NSString *hlightString;
/**
 *  高亮文字颜色
 */
@property (strong,nonatomic) UIColor *colorStr;

@property (nonatomic,copy)void (^globeBottomView)(NSInteger index, NSString *string);

@property (strong, nonatomic) id<CLAlertViewDelegate>delegate;

+ (id)globeBottomView;

- (void)show;
@end
