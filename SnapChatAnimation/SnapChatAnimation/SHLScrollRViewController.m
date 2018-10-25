//
//  SHLScrollRViewController.m
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/18.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import "SHLScrollRViewController.h"
#import "ListCollectionViewCell.h"
#import "SHLeftRigntScrollLayout.h"

@interface SHLScrollRViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, SHLeftRigntScrollLayoutDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation SHLScrollRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setSubviews];

    CGFloat width = self.view.bounds.size.width;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.5 - 60, 20, 120, 44)];
    titleLabel.text = @"左右滑动";
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
#pragma mark -
#pragma mark   ==============setSubviews==============
- (void)setSubviews
{
    
    SHLeftRigntScrollLayout *layout = [[SHLeftRigntScrollLayout alloc] init];
    layout.itemSize = self.view.bounds.size;
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:ListCollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    [collectionView reloadData];
    
    if (self.curIndex > 0) {
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.curIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
    }
}
#pragma mark -
#pragma mark   ==============UICollectionViewDataSource==============
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.item < self.dataArr.count) {
        [cell updateWithImage:self.dataArr[indexPath.item]];
    }
    return cell;
}

#pragma mark -
#pragma mark   ==============SHLeftRigntScrollLayoutDelegate==============
- (void)scrollLayout:(SHLeftRigntScrollLayout *)layout scale:(CGFloat)scale
{
    if (scale > 0.35) {
        CGFloat alpha = 5.0 / 3 * scale - 2.0 / 3;
        self.titleLabel.alpha = alpha;
        self.backBtn.alpha = alpha;
    }else {
        self.titleLabel.alpha = 0;
        self.backBtn.alpha = 0;
    }
    CGRect frame = self.titleLabel.frame;
    //20  状态栏的高度，请根据机型获取
    frame.origin.y = 20 + (scale - 1) * 44;
    self.titleLabel.frame = frame;
    
    frame = self.backBtn.frame;
    //20  状态栏的高度，请根据机型获取
    frame.origin.y = 20 + (scale - 1) * 44;
    self.backBtn.frame = frame;
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
