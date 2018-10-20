//
//  SHInteractiveAnimatedTransition.h
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/18.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHInteractiveShowStyle) {
    SHInteractiveShowStylePresent = 0,
    SHInteractiveShowStyleDissmiss,
    SHInteractiveShowStylePush,
    SHInteractiveShowStylePop,
};

NS_ASSUME_NONNULL_BEGIN

@interface SHInteractiveAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) SHInteractiveShowStyle transitionType;

@end

NS_ASSUME_NONNULL_END
