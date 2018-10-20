//
//  SHInteractiveAnimatedTransition.m
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/18.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import "SHInteractiveAnimatedTransition.h"


@interface SHInteractiveAnimatedTransition ()



@end

@implementation SHInteractiveAnimatedTransition

#pragma mark -
#pragma mark   ==============Present==============
- (void)presentAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    
}
#pragma mark -
#pragma mark   ==============Dissmiss==============
- (void)dissmissAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    
}
#pragma mark -
#pragma mark   ==============Push==============
- (void)pushAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    
}
#pragma mark -
#pragma mark   ==============Pop==============
- (void)popAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    
}
#pragma mark -
#pragma mark   ==============UIViewControllerAnimatedTransitioning==============
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.transitionType == SHInteractiveShowStylePresent) {
        [self presentAnimation:transitionContext];
    } else if (self.transitionType == SHInteractiveShowStyleDissmiss) {
        [self dissmissAnimation:transitionContext];
    } else if (self.transitionType == SHInteractiveShowStylePush) {
        [self pushAnimation:transitionContext];
    } else if (self.transitionType == SHInteractiveShowStylePop) {
        [self popAnimation:transitionContext];
    }
}
@end
