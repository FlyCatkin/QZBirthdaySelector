//
//  QZDateSelectorView.h
//  QZBirthdaySelector
//
//  Created by wymany on 15/11/18.
//  Copyright © 2015年 booksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QZDatePickerView,QZDateSelectorToolBarView;

typedef void (^QZDateSelectCancelBlock) ();
typedef void (^QZDateSelectConfirmBlock) (NSString *dateString,NSDate *date);

@interface QZDateSelectorView : UIView

/**
 *  底部View,包括时间选择器datePickerView和dateToolBar;
 */
@property (nonatomic, strong) UIView *bottomSelectView;

/**
 *  时间选择器
 */
@property (nonatomic ,strong) QZDatePickerView *datePickerView;

/**
 *  包含取消按钮、标题label、确认按钮
 */
@property (nonatomic ,strong) QZDateSelectorToolBarView *dateToolBar;

/**
 *  设置标题
 */
@property (nonatomic,copy) NSString *title;

/**
 * titleLabel
 *
 */
@property (nonatomic,strong) UILabel *titleLabel;

/**
 *  取消按钮
 *
 */
@property (nonatomic,strong) UIButton *cancelButton;

/**
 *  确认按钮
 *
 */
@property (nonatomic,strong) UIButton *confirmButton;

/**
 *  动画时间
 */
@property (nonatomic,assign) CGFloat animateDuration;

/**
 *  时间字体颜色
 */
@property (nonatomic ,strong) UIColor *datePickViewCharacterColor;

/**
 * 时间字体
 *
 */
@property (nonatomic ,strong) UIColor *datePickViewCharacterFont;

/**
 *  设置取消和确认事件
 *
 *  @param defaultDateString   格式为@"0000-00-00"的时间字符串
 */
- (void)setupWithDefaultDateString:(NSString *)defaultDateString cancel:(QZDateSelectCancelBlock)cancelBlock confirm:(QZDateSelectConfirmBlock)confirmBlock;

/** 
 *  设置取消和确认事件
 *
 *  @param defaultDate   格式为@"0000-00-00"的时间字符串*
 */
- (void)setupWithDefaultDate:(NSDate *)defaultDate cancel:(QZDateSelectCancelBlock)cancelBlock confirm:(QZDateSelectConfirmBlock)confirmBlock;


@end
