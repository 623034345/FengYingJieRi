//
//  ViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/23.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//
#define APP_DELEGATE_INSTANCE \
((AppDelegate *)([UIApplication sharedApplication].delegate))
#import "ViewController.h"
#import "NavigationViewController.h"
#import "FYJTheConstellationViewController.h"
#import "TheIunarCalendarViewController.h"
#import "YJWiFiViewController.h"
#import "PlayViewController.h"
#import "VPNViewController.h"
#import "HealthViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *table;
@end
static NSString *indenfOnCell = @"fyjCell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getGeneral];
    self.title = @"冯英杰";
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
     [img performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"wo"] afterDelay:1.0 inModes:@[NSDefaultRunLoopMode]];
    [self.view addSubview:img];
    [self.dataArr addObject:@"计算年龄星座"];
    [self.dataArr addObject:@"农历日历"];
    [self.dataArr addObject:@"健康"];

    [self.view addSubview:self.table];
    self.table.opaque = YES;
    
    
}
-(void)loginHome
{
    FYJTheConstellationViewController *fvc = [[FYJTheConstellationViewController alloc] init];
    TheIunarCalendarViewController *tvc = [[TheIunarCalendarViewController alloc] init];
    HealthViewController *yvc = [[HealthViewController alloc] init];
    NSArray *tabbarImgs =[NSArray arrayWithObjects:@"homeH",@"shopH",@"shopsH", nil];
    NSArray *tabbarSelectImgs =[NSArray arrayWithObjects:@"homeR",@"shopR",@"mineR", nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"健康",@"星座",@"日历", nil];
    NSArray *views =[NSArray arrayWithObjects:fvc,tvc,yvc, nil];
    NSMutableArray *navArr =[[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0; i < views.count; i++)
    {
        UIViewController *view =views[i];
        
        view.tabBarItem.selectedImage = [[UIImage imageNamed:[tabbarSelectImgs objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        view.tabBarItem.image = [[UIImage imageNamed:[tabbarImgs objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        view.tabBarItem.title = [titleArr objectAtIndex:i];
        
        view.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
        [view.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-2, -2)];
        
        
        
        NavigationViewController *nav=[[NavigationViewController alloc]initWithRootViewController:view];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [navArr addObject:nav];
        
    }
    
    
    UITabBarController *tabBarVContro =[[UITabBarController alloc]init];
    [tabBarVContro.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"bigABtn"]];
    tabBarVContro.tabBar.tintColor = [UIColor blueColor];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];

    backView.backgroundColor = [UIColor whiteColor];
    [tabBarVContro.tabBar insertSubview:backView atIndex:0];
    tabBarVContro.tabBar.opaque = YES;
    tabBarVContro.viewControllers =navArr;
    
    [UIApplication sharedApplication].delegate.window.rootViewController =tabBarVContro;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenfOnCell forIndexPath:indexPath];
   
    cell.opaque = YES;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.alpha = 0.9;
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
    if (indexPath.row == 2) {
        HealthViewController *yvc = [[HealthViewController alloc] init];
        [self.navigationController pushViewController:yvc animated:YES];
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor clearColor];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:indenfOnCell];
    }
    return _table;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
