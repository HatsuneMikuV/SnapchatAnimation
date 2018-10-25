//
//  SHLFDViewController.h
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/18.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHLFDViewController : UIViewController

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong, readonly) UICollectionView *backView;
@property (nonatomic, assign, readonly) CGRect imageFrame;
@property (nonatomic, assign) NSInteger curIndex;

@property (nonatomic, copy) void(^updateCurIndex)(NSInteger curIndex);

@end

NS_ASSUME_NONNULL_END
