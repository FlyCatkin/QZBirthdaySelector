//
//  QZDateSelectorView.m
//  QZBirthdaySelector
//
//  Created by wymany on 15/11/18.
//  Copyright © 2015年 booksky. All rights reserved.
//

#import "QZDateSelectorView.h"
#import "QZDateSelectorToolBarView.h"
#import "QZDatePickerView.h"

static const CGFloat kHorizontalMargin = 20.f;
static const CGFloat kVerticaMargin = 25.f;

static const NSTimeInterval kAnimateDuration = 0.4;


#define BBUScreen_bounds [UIScreen mainScreen].bounds
#define BBUScreen_width [UIScreen mainScreen].bounds.size.width
#define BBUScreen_height [UIScreen mainScreen].bounds.size.height

@interface QZDateSelectorView ()


@property (nonatomic, strong) UIButton *backgroudButton;

@property (nonatomic, copy) QZDateSelectCancelBlock cancelBlock;
@property (nonatomic, copy) QZDateSelectConfirmBlock confirmBlock;

@end

@implementation QZDateSelectorView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


#pragma mark - 公共API

- (void)setupWithDefaultDate:(NSDate *)defaultDate cancel:(QZDateSelectCancelBlock)cancelBlock confirm:(QZDateSelectConfirmBlock)confirmBlock
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *defaultDateString = [formatter stringFromDate:defaultDate];
    [self setupWithDefaultDateString:defaultDateString cancel:cancelBlock confirm:confirmBlock];
}

- (void)setupWithDefaultDateString:(NSString *)defaultDateString cancel:(QZDateSelectCancelBlock)cancelBlock confirm:(QZDateSelectConfirmBlock)confirmBlock
{
    [self.datePickerView selectDefaultDateString:defaultDateString];
    [UIView animateWithDuration:self.animateDuration animations:^{
        CGRect frame = self.bottomSelectView.frame;
        frame.origin.y = BBUScreen_height - self.bottomSelectView.frame.size.height;
        self.bottomSelectView.frame = frame;
        self.backgroudButton.alpha = 0.3;
    }];
    
    self.cancelBlock = cancelBlock;
    self.confirmBlock = confirmBlock;
}


#pragma mark - 私有方法

- (void)setupView
{
    //主控件
    self.frame = BBUScreen_bounds;
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    //半透明蒙版
    self.backgroudButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroudButton.frame = BBUScreen_bounds;
    self.backgroudButton.backgroundColor = [UIColor blackColor];
    [self.backgroudButton addTarget:self action:@selector(doClickCancel) forControlEvents:UIControlEventTouchUpInside];
    self.backgroudButton.alpha = 0.f;
    [self addSubview:self.backgroudButton];
    
    //底部选择器
    self.bottomSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, BBUScreen_height, BBUScreen_width, 250.f)];
    self.bottomSelectView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomSelectView];
    
    //toolbar
    [self setupToolBar];
    
    //时间选择器
    [self setupDatePickerView];
    
}

- (void)setupToolBar
{
    self.dateToolBar = [[QZDateSelectorToolBarView alloc] initWithFrame:CGRectMake(0, 0, self.bottomSelectView.frame.size.width, 50)];
    [self.bottomSelectView addSubview:self.dateToolBar];
    
    self.cancelButton = self.dateToolBar.cancelButton;
    self.titleLabel = self.dateToolBar.titleLabel;
    self.confirmButton = self.dateToolBar.confirmButton;
    
    [self.dateToolBar doClickCancel:^{
        [self doClickCancel];
    } confirm:^{
        [self doClickConfirm];
    }];
}

- (void)setupDatePickerView
{
    CGFloat datePickerViewX = kHorizontalMargin;
    CGFloat datePickerViewW = BBUScreen_width - 2 * datePickerViewX;
    CGFloat datePickerViewH = 180.f;
    CGFloat datePickerViewY = self.bottomSelectView.frame.size.height - kVerticaMargin - datePickerViewH;
    self.datePickerView = [[QZDatePickerView alloc] initWithFrame:CGRectMake(datePickerViewX, datePickerViewY, datePickerViewW, datePickerViewH)];
    [self.bottomSelectView addSubview:self.datePickerView];
}

- (void)doClickCancel
{
    [UIView animateWithDuration:self.animateDuration animations:^{
        CGRect frame = self.bottomSelectView.frame;
        frame.origin.y = BBUScreen_height;
        self.bottomSelectView.frame = frame;
        self.backgroudButton.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.cancelBlock();
    }];
}

- (void)doClickConfirm
{
    [UIView animateWithDuration:self.animateDuration animations:^{
        CGRect frame = self.bottomSelectView.frame;
        frame.origin.y = BBUScreen_height;
        self.bottomSelectView.frame = frame;
        self.backgroudButton.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        NSString *dateString = self.datePickerView.selectDateString;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [formatter dateFromString:dateString];
        self.confirmBlock(dateString,date);
    }];
}

#pragma mark - setter、getter方法

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.dateToolBar.titleLabel.text = title;
}

- (void)setDatePickViewCharacterColor:(UIColor *)datePickViewCharacterColor
{
    _datePickViewCharacterColor = datePickViewCharacterColor;
    self.datePickerView.characterColor = datePickViewCharacterColor;
    [self.datePickerView reloadAllComponents];
}

- (void)setDatePickViewCharacterFont:(UIColor *)datePickViewCharacterFont
{
    _datePickViewCharacterFont = datePickViewCharacterFont;
    self.datePickerView.characterColor = datePickViewCharacterFont;
    [self.datePickerView reloadAllComponents];
}

- (CGFloat)animateDuration
{
    if (_animateDuration <= 0) {
        _animateDuration = kAnimateDuration;
    }
    return _animateDuration;
}

@end