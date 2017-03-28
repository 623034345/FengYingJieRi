//
//  ViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/23.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "ViewController.h"
#import "FYJTextViewController.h"
#import "FYJTheConstellationViewController.h"
#import "TheIunarCalendarViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *table;
@end
static NSString *indenfOnCell = @"fyjCell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"冯英杰";
    [self.dataArr addObject:@"计算年龄星座"];
    [self.dataArr addObject:@"农历日历"];

    [self getGeneral];
    
    [self.view addSubview:self.table];
    self.table.opaque = YES;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenfOnCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.opaque = YES;
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        FYJTheConstellationViewController *fvc = [[FYJTheConstellationViewController alloc] init];
        [self.navigationController pushViewController:fvc animated:YES];
    }
    if (indexPath.row == 1) {
        TheIunarCalendarViewController *tvc = [[TheIunarCalendarViewController alloc] init];
        [self.navigationController pushViewController:tvc animated:YES];
    }
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
        
    }
    return _dataArr;
}
-(UITableView *)table
{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:indenfOnCell];
    }
    return _table;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
