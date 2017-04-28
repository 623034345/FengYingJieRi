//
//  VPNViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/4/13.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "VPNViewController.h"
#import <NetworkExtension/NetworkExtension.h>
@interface VPNViewController ()

@end

@implementation VPNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NEVPNManager *manager = [NEVPNManager sharedManager];
    
//    NEVPNManager初始化后,系统设置可以使用loadFromPreferencesWithCompletionHandler:加载方法:
    
    [manager loadFromPreferencesWithCompletionHandler:^(NSError *error) {
        
        // Put your codes here...
        if(error) {
            
            NSLog(@"Load error: %@", error);
            
        } else {
            
            // No errors! The rest of your codes goes here...
            NEVPNProtocolIPSec *p = [[NEVPNProtocolIPSec alloc] init];
            
            p.username = @"[Your username]";
            
            p.passwordReference = @"[VPN user password from keychain]";
            
            p.serverAddress = @"[Your server address]";
            
            p.authenticationMethod = NEVPNIKEAuthenticationMethodSharedSecret;
            
            p.sharedSecretReference = @"[VPN server shared secret from keychain]";
            
            p.localIdentifier = @"[VPN local identifier]";
            
            p.remoteIdentifier = @"[VPN remote identifier]";
            
            p.useExtendedAuthentication = YES;
            
            p.disconnectOnSleep = NO;
            
        }
    }];
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
