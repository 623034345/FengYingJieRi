//
//  YJWiFiViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/29.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "YJWiFiViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
//#import ""


@interface YJWiFiViewController ()

@end

@implementation YJWiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",[self SSID]);//
//    {
//        BSSID = "80:89:17:7e:9f:b2";
//        SSID = 123456;
//        SSIDDATA = <31323334 3536>;
//    }
    
}
- (NSDictionary*)SSID
{
    
    NSArray* ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    
    id info = nil;
    
    for (NSString* ifnam in ifs)
        
    {
        
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (info && [info count])
            
            break;
        
    }
    return info;
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
