//
//  BaseViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2018/6/6.
//  Copyright © 2018年 Macintosh HD. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - tableViewDelegate ----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
//创建table
-(UITableView *)table
{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        
        if (self.navigationController.viewControllers.count == 1)
        {
            _table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - [self tabbarHeight] - [self navHeight]);
        }
//        else if (self.navigationController.navigationBar.hidden == NO)
//        {
//            _table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//        }
        if (@available(iOS 11.0, *)){
            _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _table.separatorStyle = NO;
        _table.delegate = self;
        _table.dataSource = self;
        // 在新加载的数据加入到data数组之前先取得没有添加数据时data的数据量 data.count;
        //        NSInteger count = self.data.count;
        //        // 设置加载数据后数据显示位置 使刷新出的数据显示在上排
        //        NSInteger position = count>0 ? count-1 : count;
        //        [self.tableView scrollToRowAtIndexPath:[NSIndexPath
        //                                                atScrollPosition:UITableViewScrollPositionTop
        //                                                animated:YES];
    }
    return _table;
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)bannerArr
{
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}
#pragma mark -获取TabBar高度
-(float)tabbarHeight
{
    if (iPhoneX)
    {
        return 49.f+34.f;
    }
    else
    {
        return 49;
    }
}
#pragma mark -获取导航高度
-(float)navHeight
{
    if (iPhoneX)
    {
        return 88.f;
    }
    else
    {
        return 64.f;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
