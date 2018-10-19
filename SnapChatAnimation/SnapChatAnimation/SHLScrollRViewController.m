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

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation SHLScrollRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"左右滑动";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backClick)];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.dataArr = @[@"image0",
                     @"image1",
                     @"image2",
                     @"image3",
                     @"image4",
                     @"image5",
                     @"image6",
                     @"image7",
                     @"image8",
                     @"image9",
                     @"image10"];
    
    [self setSubviews];
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
        [self.navigationController.navigationBar setAlpha:alpha];
    }else {
        [self.navigationController.navigationBar setAlpha:0];
    }
    CGRect frame = self.navigationController.navigationBar.frame;
    //20  状态栏的高度，请根据机型获取
    frame.origin.y = 20 + (scale - 1) * 44;
    self.navigationController.navigationBar.frame = frame;
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
