//
//  LeftViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/6/14.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "LeftViewController.h"
#import "CardIO.h"
#import <CardIOPaymentViewControllerDelegate.h>
#import "SWRevealViewController.h"
#import "VPNViewController.h"
#import "YJWiFiViewController.h"
@interface LeftViewController ()<CardIOPaymentViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _presentedRow;
}

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIImageView *backGroundImg;
@end

@implementation LeftViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [CardIOUtilities preloadCardIO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _presentedRow = 0;
    self.view.backgroundColor = [UIColor blueColor];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 200, 300, 50);
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(card) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    [self.view addSubview:self.backGroundImg];
    [self.view addSubview:self.table];
    
    
}
#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSString *text = nil;
    if (row == 0)
    {
        text = @"Front View Controller";
    }
    else if (row == 1)
    {
        text = @"Map View Controller";
    }
    else if (row == 2)
    {
        text = @"Enter Presentation Mode";
    }
    else if (row == 3)
    {
        text = @"Resign Presentation Mode";
    }
    
    cell.textLabel.text = NSLocalizedString( text,nil );
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    
    SWRevealViewController *revealController = self.revealViewController;
//
// 
    NSInteger row = indexPath.row;
//
//    if ( row == _presentedRow )
//    {
//        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
//        return;
//    }
//    else if (row == 2)
//    {
//        [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
//        return;
//    }
//    else if (row == 3)
//    {
//        [revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
//        return;
//    }

    // otherwise we'll create a new frontViewController and push it with animation
    
    UIViewController *newFrontController = nil;
    
    if (row == 0)
    {
        newFrontController = [[DonwViewController alloc] init];
    }
    
    else if (row == 1)
    {
        newFrontController = [[YJWiFiViewController alloc] init];
    }
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [revealController pushFrontViewController:navigationController animated:YES];
    
    _presentedRow = row;  // <- store the presented row
}


-(UIImageView *)backGroundImg
{
    if (!_backGroundImg)
    {
        _backGroundImg = [[UIImageView alloc] initWithFrame:self.view.frame];
        _backGroundImg.image = [UIImage imageNamed:@"wo"];
    }
    return _backGroundImg;
}

-(UITableView *)table
{
    if (!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
        _table.backgroundColor = [UIColor clearColor];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

-(void)card
{
    [CardIOUtilities preload];

    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    [self presentViewController:scanViewController animated:YES completion:nil];
}
//取消扫描

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}
//扫描完成
- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    // The full card number is available as info.cardNumber, but don't log that!
    NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv);
    NSString *redactedCardNumber = info.cardNumber;     // 卡号
    NSUInteger expiryMonth = info.expiryMonth;          // 月
    NSUInteger expiryYear = info.expiryYear;            // 年
    NSString *cvv = info.cvv;                           // CVV 码
    
    // 显示扫描结果
    NSString *msg = [NSString stringWithFormat:@"Number: %@\n\n expiry: %02lu/%lu\n\n cvv: %@", [self dealCardNumber:redactedCardNumber], expiryMonth, expiryYear, cvv];
    [[[UIAlertView alloc] initWithTitle:@"Received card info" message:msg  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    // Use the card info...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}
// 对银行卡号进行每隔四位加空格处理，自定义方法
- (NSString *)dealCardNumber:(NSString *)cardNumber {
    
    NSString *strTem = [cardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *strTem2 = @"";
    
    if (strTem.length % 4 == 0) {
        
        NSUInteger count = strTem.length / 4;
        for (int i = 0; i < count; i++) {
            NSString *str = [strTem substringWithRange:NSMakeRange(i * 4, 4)];
            strTem2 = [strTem2 stringByAppendingString:[NSString stringWithFormat:@"%@ ", str]];
        }
        
    } else {
        
        NSUInteger count = strTem.length / 4;
        for (int j = 0; j <= count; j++) {
            
            if (j == count) {
                NSString *str = [strTem substringWithRange:NSMakeRange(j * 4, strTem.length % 4)];
                strTem2 = [strTem2 stringByAppendingString:[NSString stringWithFormat:@"%@ ", str]];
            } else {
                NSString *str = [strTem substringWithRange:NSMakeRange(j * 4, 4)];
                strTem2 = [strTem2 stringByAppendingString:[NSString stringWithFormat:@"%@ ", str]];
            }
        }
    }
    
    return strTem2;
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
