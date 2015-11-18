//
//  QZDatePickerView.h
//  QZBirthdaySelector
//
//  Created by wymany on 15/11/18.
//  Copyright © 2015年 booksky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,QZDatePickerViewStyle) {
    QZDatePickerViewStyleDefault,
    QZDatePickerViewStyleBlack,
};

@interface QZDatePickerView : UIPickerView

/**
 *  显示时间界限开始时间默认为1915
 */
@property (nonatomic, assign) NSUInteger beginYear;

/**
 *  显示时间界限endYear2050
 */
@property (nonatomic, assign) NSUInteger endYear;

/**
 *  时间字体颜色
 */
@property (nonatomic ,strong) UIColor *characterColor;

/**
 *  时间字体大小
 */
@property (nonatomic ,strong) UIFont *characterFont;

/**
 *  所选日期
 */
@property (nonatomic ,strong) NSDate *selectDate;

/**
 * 初始选择时间--字符串格式0000-00-00
 */
@property (nonatomic ,copy) NSString *selectDateString;

/**
 *  通过字符串选择日期--字符串格式0000-00-00
 */
- (void)selectDefaultDateString:(NSString *)defaultDateString;

@end
