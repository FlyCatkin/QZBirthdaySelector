//
//  QZDateSelectorToolBarView.h
//  QZBirthdaySelector
//
//  Created by wymany on 15/11/18.
//  Copyright © 2015年 booksky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^QZCancelBlock) ();
typedef void (^QZConfirmBlock) ();

@interface QZDateSelectorToolBarView : UIView

/**
 *  取消按钮
 */
@property (nonatomic, strong) UIButton *cancelButton;

/**
 *  确认按钮
 */
@property (nonatomic, strong) UIButton *confirmButton;

/**
 *  名称Label
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  取消确认事件
 */
- (void)doClickCancel:(QZCancelBlock)cancelBlock confirm:(QZConfirmBlock)confirmBlock;

@end
