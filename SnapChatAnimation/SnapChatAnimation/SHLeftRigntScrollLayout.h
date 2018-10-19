//
//  SHLeftRigntScrollLayout.h
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/19.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SHLeftRigntScrollLayout;

@protocol SHLeftRigntScrollLayoutDelegate <NSObject>


/**
 @param scale 0-1
 */
- (void)scrollLayout:(SHLeftRigntScrollLayout *)layout scale:(CGFloat)scale;

@end

@interface SHLeftRigntScrollLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<SHLeftRigntScrollLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
