//
//  ListCollectionViewCell.m
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/19.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import "ListCollectionViewCell.h"

@interface ListCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ListCollectionViewCell

- (void)updateWithImage:(NSString *)imgUrl
{
    [self.imageView setImage:[UIImage imageNamed:imgUrl]];
}

@end
