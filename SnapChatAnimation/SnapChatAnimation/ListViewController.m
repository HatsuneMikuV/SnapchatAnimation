//
//  ListViewController.m
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/18.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import "ListViewController.h"
#import "ListCollectionViewCell.h"

#import "SHScrollDownViewController.h"
#import "SHLFDViewController.h"
#import "SHLScrollRViewController.h"

@interface ListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UICollectionView *collectioView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backClick)];

    self.navigationItem.title = @"数据列表";
    
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
    CGFloat itemWidth = (self.view.bounds.size.width - 40) / 3;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    collectionView.backgroundColor = UIColor.whiteColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:ListCollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    [collectionView reloadData];
    self.collectioView = collectionView;
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
#pragma mark   ==============UICollectionViewDelegate==============
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController = nil;
    
    if (self.type == SHTransitionStyleLeftRight) {
        SHLScrollRViewController *vc = [[SHLScrollRViewController alloc] init];
        vc.dataArr = self.dataArr;
        viewController = vc;
    } else if (self.type == SHTransitionStyleDown) {
        SHScrollDownViewController *vc = [[SHScrollDownViewController alloc] init];
        vc.imageUrl = self.dataArr[indexPath.item];
        viewController = vc;
    } else if (self.type == SHTransitionStyleLeftRightDown) {
        SHLFDViewController *vc = [[SHLFDViewController alloc] init];
        vc.dataArr = self.dataArr;
        viewController = vc;
    }
    
    if (viewController) {
        self.curIndex = indexPath.item;
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark   ==============Public==============
- (UIView *)getCurentCell:(NSInteger)index
{
    UIView *cell = [self.collectioView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    if (cell == nil) {
        for (NSIndexPath *indexPath in self.collectioView.indexPathsForVisibleItems) {
            if (index == indexPath.item) {
                cell = [self.collectioView cellForItemAtIndexPath:indexPath];
                break;
            }
        }
    }
    return cell;
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
