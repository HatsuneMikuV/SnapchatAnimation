//
//  ViewController.m
//  SnapChatAnimation
//
//  Created by Joe.l on 2018/10/18.
//  Copyright © 2018年 anglemiku.v. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

#pragma mark -
#pragma mark   ==============LifeCycle==============
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArr = @[@"", @""];
    
    [self setSubviews];
}

#pragma mark -
#pragma mark   ==============setSubviews==============
- (void)setSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    [self.view addSubview:tableView];
    
    [tableView reloadData];
}
#pragma mark -
#pragma mark   ==============UITableViewDelegate==============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < self.dataArr.count) {
        
        [self.navigationController presentViewController:[[ListViewController alloc] init] animated:YES completion:nil];
    }
}
#pragma mark -
#pragma mark   ==============UITableViewDataSource==============

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (indexPath.row < self.dataArr.count) {
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    return cell;
}

@end
