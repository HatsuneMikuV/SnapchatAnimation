
//
//  SHLeftRigntScrollLayout.m
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/19.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import "SHLeftRigntScrollLayout.h"

@implementation SHLeftRigntScrollLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.minimumLineSpacing = 0;
    self.minimumLineSpacing = 0;
    self.sectionInset = UIEdgeInsetsZero;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat hafWidth = self.collectionView.bounds.size.width * 0.5;
    // 屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + hafWidth;
    // 刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        
        CGFloat distance = fabs(attributes.center.x - centerX);
        // 移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance / self.collectionView.bounds.size.width;
        // 把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI / 3));
        if (self.delegate && [self.delegate respondsToSelector:@selector(scrollLayout:scale:)] && (distance < hafWidth)) {
            CGFloat scaleLeft = (hafWidth - distance) / hafWidth;
            [self.delegate scrollLayout:self scale:scaleLeft];
        }
        // 设置cell的缩放
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 取当前屏幕内显示的cell
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    // 屏幕中线
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    CGFloat minDistance = MAXFLOAT;
    // 计算哪个cell的中心点距屏幕中心点最近，然后保留其相差的距离
    for (UICollectionViewLayoutAttributes *attributes in attrs) {

        CGFloat offset = attributes.center.x - centerX;
        if (fabs(offset) <= fabs(minDistance)) {
            minDistance = offset;
        }
    }
    // 重新计算偏移值。将屏幕滑动到最近的那个cell位置
    CGFloat XX = proposedContentOffset.x + minDistance;
    
    return CGPointMake(XX, proposedContentOffset.y);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
