//
//  ListViewController.h
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/18.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHTransitionStyle) {
    SHTransitionStyleNone = 0,
    SHTransitionStyleLeftRight,
    SHTransitionStyleDown,
    SHTransitionStyleLeftRightDown,
};

NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : UIViewController

@property (nonatomic, assign) SHTransitionStyle type;

- (UIView *)getCurentCell:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
