//
//  ViewController.m
//  QZBirthdaySelector
//
//  Created by wymany on 15/11/18.
//  Copyright © 2015年 booksky. All rights reserved.
//

#import "ViewController.h"
#import "QZDateSelectorView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor orangeColor];
    leftButton.frame = CGRectMake(30, 100, 100, 40);
    [leftButton setTitle:@"选择器1" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showDateSelectorLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor orangeColor];
    rightButton.frame = CGRectMake(200, 100, 100, 40);
    [rightButton setTitle:@"选择器2" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(showDateSelectorRight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
}

- (void)showDateSelectorLeft{
    QZDateSelectorView *dateView = [[QZDateSelectorView alloc] init];
    dateView.title = @"标题10个字长吗";
    dateView.titleLabel.textColor = [UIColor whiteColor];
    dateView.bottomSelectView.backgroundColor = [UIColor blackColor];
    dateView.datePickViewCharacterColor = [UIColor whiteColor];
    [dateView.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dateView setupWithDefaultDateString:@"1992-06-15" cancel:^{
        NSLog(@"取消");
    } confirm:^(NSString *dateString, NSDate *date) {
        NSLog(@"改变为：%@",dateString);
    }];
}

- (void)showDateSelectorRight{
    NSDate *date = [NSDate date];
    QZDateSelectorView *dateView = [[QZDateSelectorView alloc] init];
    [dateView setupWithDefaultDate:date cancel:^{
        NSLog(@"取消");
    } confirm:^(NSString *dateString, NSDate *date) {
        NSLog(@"改变为：%@",dateString);
    }];
}

@end
