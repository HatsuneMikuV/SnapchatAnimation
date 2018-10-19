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

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
#pragma mark   ==============setSubviews==============
- (void)setSubviews
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds];
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
#pragma mark   ==============UICollectionViewDelegate==============
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController = nil;
    
    if (self.type == SHTransitionStyleLeftRight) {
        viewController = [[SHLScrollRViewController alloc] init];
    } else if (self.type == SHTransitionStyleDown) {
        viewController = [[SHScrollDownViewController alloc] init];
    } else if (self.type == SHTransitionStyleLeftRightDown) {
        viewController = [[SHLFDViewController alloc] init];
    }
    
    if (viewController) {
        [self presentViewController:viewController animated:YES completion:nil];
    }
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
