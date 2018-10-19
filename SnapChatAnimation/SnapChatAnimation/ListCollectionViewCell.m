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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [imageView setContentMode:(UIViewContentModeScaleAspectFit)];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)updateWithImage:(NSString *)imgUrl
{
    [self.imageView setImage:[UIImage imageNamed:imgUrl]];
}

@end
