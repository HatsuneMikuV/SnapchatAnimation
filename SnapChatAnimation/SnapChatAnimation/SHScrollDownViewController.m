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
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backBtn;

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

    self.view.backgroundColor = UIColor.blackColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    [imageView setImage:[UIImage imageNamed:self.imageUrl]];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    _backView = imageView;
    
    CGFloat width = self.view.bounds.size.width;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.5 - 60, 20, 120, 44)];
    titleLabel.text = @"向下滑动消失";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.backgroundColor = UIColor.orangeColor;
    titleLabel.clipsToBounds = YES;
    titleLabel.layer.cornerRadius = 22;
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = UIColor.orangeColor;
    backBtn.clipsToBounds = YES;
    backBtn.layer.cornerRadius = 22;
    [self.view addSubview:backBtn];
    self.backBtn = backBtn;
    
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
        [self dismissViewControllerAnimated:YES completion:nil];
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
        [self backClick];
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
    self.transitionAnimation.transitionType = SHInteractiveShowStyleDissmiss;
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
