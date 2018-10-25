//
//  SHInteractiveAnimatedTransition.m
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/18.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import "SHInteractiveAnimatedTransition.h"

#import "ListViewController.h"
#import "SHScrollDownViewController.h"

@interface SHInteractiveAnimatedTransition ()



@end

@implementation SHInteractiveAnimatedTransition

#pragma mark -
#pragma mark   ==============Present==============
- (void)presentAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是转场后的VC、fromVC就是转场前的VC
    ListViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([fromVC isKindOfClass:[UINavigationController class]]) {
        fromVC = (ListViewController *)[(UINavigationController *)fromVC topViewController];
    }
    SHScrollDownViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //获取点击的cell
    UIView *fromView = [fromVC getCurentCell:fromVC.curIndex];
    
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = transitionContext.containerView;
    
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [fromView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromView convertRect:fromView.bounds toView:containerView];
    
    //设置动画前的各个控件的状态
    fromView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.backView.hidden = YES;
    //tempView 添加到containerView中，要保证在最上层，所以后添加
    [containerView addSubview:toVC.view];
    if (tempView != nil) {
        [containerView addSubview:tempView];
    }
    
    //开始做动画
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        tempView.frame = toVC.backView.frame;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [tempView removeFromSuperview];
        toVC.backView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中断动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
}
#pragma mark -
#pragma mark   ==============Dissmiss==============
- (void)dissmissAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是转场后的VC、fromVC就是转场前的VC
    ListViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([toVC isKindOfClass:[UINavigationController class]]) {
        toVC = (ListViewController *)[(UINavigationController *)toVC topViewController];
    }
    SHScrollDownViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    //获取点击的cell
    UIView *toView = [toVC getCurentCell:toVC.curIndex];
    
    UIView *containerView = transitionContext.containerView;
    
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [fromVC.backView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVC.backView convertRect:fromVC.backView.bounds toView:containerView];
    
    //设置初始状态
    fromVC.backView.hidden = YES;
    //tempView 添加到containerView中
    if (tempView != nil) {
        [containerView addSubview:tempView];
    }
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    [UIView animateWithDuration:duration animations:^{
        tempView.frame = [toView convertRect:toView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
        if (wasCancelled) {
            //手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            [tempView removeFromSuperview];
            fromVC.backView.hidden = NO;
        }else{
            //手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            toView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
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
