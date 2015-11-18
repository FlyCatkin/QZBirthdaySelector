//
//  QZDatePickerView.m
//  QZBirthdaySelector
//
//  Created by wymany on 15/11/18.
//  Copyright © 2015年 booksky. All rights reserved.
//

#import "QZDatePickerView.h"

static const NSInteger kYearComponent = 0;
static const NSInteger kMonthComponent = 1;
static const NSInteger kdayComponent = 2;


static const NSUInteger kDefaultBeginYear = 1915;
static const NSUInteger kDefaultEndYear = 2050;



#define BBUScreen_bounds [UIScreen mainScreen].bounds
#define BBUScreen_width [UIScreen mainScreen].bounds.size.width
#define BBUScreen_height [UIScreen mainScreen].bounds.size.height

@interface QZDatePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;
@property (nonatomic, strong) NSArray *daysOfEveryMouth;
@property (nonatomic, strong) NSMutableDictionary *attributesDic;

@end

@implementation QZDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInitialProperty];
    }
    return self;
}


#pragma mark - 私有方法

- (void)setupInitialProperty
{
    self.delegate = self;
    self.dataSource = self;
    self.beginYear = kDefaultBeginYear;
    self.endYear = kDefaultEndYear;
    self.characterColor = [UIColor blackColor];
    self.characterFont = [UIFont systemFontOfSize:24.f];
    NSString *defaultDateString = @"1990-07-15";
    [self selectDefaultDateString:defaultDateString];
}

- (void)selectDefaultDateString:(NSString *)defaultDateString
{
    if (!defaultDateString || [defaultDateString isEqualToString:@""]) {
        defaultDateString = @"1990-07-15";
    }
    //获得年份和其对应的row
    NSInteger year = [[defaultDateString substringToIndex:4] integerValue];
    NSInteger month = [[defaultDateString substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day = [[defaultDateString substringWithRange:NSMakeRange(8, 2)] integerValue];
    
    NSInteger yearRow = year - self.beginYear;
    NSInteger monthRow = month - 1;
    NSInteger dayRow = day - 1;
    
    if (yearRow < 0 || yearRow > self.endYear -self.beginYear) {
        yearRow = 1990 - self.beginYear;
    }
    
    if (monthRow < 0 || monthRow > 11) {
        yearRow = 0;
    }
    
    if (day < 0 || day > 30) {
        yearRow = 0;
    }
    
    [self selectRow:yearRow inComponent:kYearComponent animated:NO];
    [self selectRow:monthRow inComponent:kMonthComponent animated:NO];
    [self pickerView:self didSelectRow:monthRow inComponent:kMonthComponent];
    [self selectRow:dayRow inComponent:kdayComponent animated:NO];
}

#pragma mark - 代理

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case kYearComponent:
            return self.yearArray.count;
            break;
        case kMonthComponent:
            return self.monthArray.count;
            break;
        case kdayComponent:
            return self.dayArray.count;
            break;
    }
    return 0;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case kYearComponent:
            return [[NSAttributedString alloc] initWithString:self.yearArray[row] attributes:self.attributesDic];
        case kMonthComponent:
            return [[NSAttributedString alloc] initWithString:self.monthArray[row] attributes:self.attributesDic];
        case kdayComponent:
            return [[NSAttributedString alloc] initWithString:self.dayArray[row] attributes:self.attributesDic];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //判断是否是闰年
    BOOL isLeapYear = NO;
    NSInteger selectYear = [pickerView selectedRowInComponent:kYearComponent] + _beginYear;
    if (((selectYear % 4 == 0) && (selectYear % 100 != 0)) || (selectYear % 400 == 0)) {
        isLeapYear = YES;
    }
    
    NSInteger selectMonthRow = [pickerView selectedRowInComponent:kMonthComponent];
    
    NSMutableArray *dayArray = [NSMutableArray array];
    NSInteger dayCount = (isLeapYear && selectMonthRow == 1)?[self.daysOfEveryMouth[selectMonthRow] integerValue] + 1:[self.daysOfEveryMouth[selectMonthRow] integerValue];
    for (NSInteger i = 0; i < dayCount; i++) {
        [dayArray addObject:[NSString stringWithFormat:@"%ld日",(long)i + 1]];
    }
    self.dayArray = dayArray;
    
    [self reloadAllComponents];
    
}

#pragma mark - setter getter方法

- (NSString *)selectDateString
{
    NSInteger selectYearRow =  [self selectedRowInComponent:kYearComponent];
    NSInteger selectMonthRow =  [self selectedRowInComponent:kMonthComponent];
    NSInteger selectDayRow =  [self selectedRowInComponent:kdayComponent];
    
    NSString *dateString = [NSString stringWithFormat:@"%lu-%02lu-%02lu",(unsigned long)selectYearRow + self.beginYear, (unsigned long)selectMonthRow + 1, (unsigned long)selectDayRow + 1];
    return dateString;
}

- (NSDate *)selectDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self.selectDateString];
    return date;
}

- (NSMutableArray *)yearArray
{
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
        for (NSUInteger i = self.beginYear; i <= self.endYear ; i++)
        {
            [_yearArray addObject:[NSString stringWithFormat:@"%lu年",(unsigned long)i]];
        }
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray
{
    if (!_monthArray) {
        _monthArray = [NSMutableArray array];
        for (int i = 1; i <= 12 ; i++)
        {
            [_monthArray addObject:[NSString stringWithFormat:@"%d月",i]];
        }
    }
    return _monthArray;
}

- (NSArray *)daysOfEveryMouth
{
    if (!_daysOfEveryMouth) {
        _daysOfEveryMouth = @[@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31"];
    }
    return _daysOfEveryMouth;
}

- (NSMutableDictionary *)attributesDic
{
    if (!_attributesDic) {
        _attributesDic = [[NSMutableDictionary alloc] init];
    }
    if (_characterColor) {
        _attributesDic[NSForegroundColorAttributeName] = _characterColor;
    }

    if (_characterFont) {
        _attributesDic[NSFontAttributeName] = _characterFont;
    }
    return _attributesDic;
}


@end
