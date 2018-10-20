//
//  SHScrollDownViewController.m
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/18.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import "SHScrollDownViewController.h"
#import "SHInteractiveAnimatedTransition.h"

@interface SHScrollDownViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) SHInteractiveAnimatedTransition *transitionAnimation;

@end

@implementation SHScrollDownViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitionAnimation =  [[SHInteractiveAnimatedTransition alloc] init];
        self.transitionAnimation.transitionType = SHInteractiveShowStylePresent;
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"向下滑动消失";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backClick)];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:backView.bounds];
    [imageView setImage:[UIImage imageNamed:self.imageUrl]];
    [backView addSubview:imageView];
    [self.view addSubview:self.backView];
    _backView = backView;
    
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizer:)];
    [self.view addGestureRecognizer:tap];
}
#pragma mark -
#pragma mark   ==============Actions==============
- (void)backClick
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)interactiveTransitionRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    
    CGFloat scale = 1 - translation.y / self.view.bounds.size.height;
    scale = scale < 0 ? 0 : scale;
    scale = scale > 1 ? 1 : scale;
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            self.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:scale];
            self.backView.center = CGPointMake(self.view.center.x + translation.x * scale, self.view.center.y + translation.y);
            self.backView.transform = CGAffineTransformMakeScale(scale, scale);
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self gestureRecognizerComplete:scale];
            break;
    }
}
- (void)gestureRecognizerComplete:(CGFloat)scale
{
    if (scale < 0.75) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.backgroundColor = UIColor.blackColor;
            self.backView.center = self.view.center;
            self.backView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            self.backView.transform = CGAffineTransformIdentity;
        }];
    }
}
#pragma mark -
#pragma mark   ==============UIViewControllerTransitioningDelegate==============
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.transitionAnimation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.transitionAnimation;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
