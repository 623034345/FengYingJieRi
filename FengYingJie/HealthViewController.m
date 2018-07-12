//
//  HealthViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/4/21.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "HealthViewController.h"
#import <HealthKit/HealthKit.h>
#import <UIKit/UIDevice.h>
#import "HealthKitManage.h"
#import "CHHealthKitManager.h"
#import "VPNViewController.h"
#import "UIImageView+WebCache.h"
#import "LeftViewController.h"
#import "CYWebViewController.h"
#import "VideosViewController.h"
#import "MLHealthManager.h"
#define UIDeviceOrientationIsPortrait(orientation)  ((orientation) == UIDeviceOrientationPortrait || (orientation) == UIDeviceOrientationPortraitUpsideDown)
#define UIDeviceOrientationIsLandscape(orientation) ((orientation) == UIDeviceOrientationLandscapeLeft || (orientation) == UIDeviceOrientationLandscapeRight)
//#import "SetUpViewController.h"
@interface HealthViewController ()<UITextFieldDelegate>{
    CHHealthKitManager *_manager;
    dispatch_source_t _timer;

}
@property (nonatomic,strong) HKHealthStore *healthStore;
@property (nonatomic, strong) UILabel *pedoLab;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *addString;
@property (nonatomic, strong) NSString *bushuString;
@property (nonatomic, strong) NSString *gongliString;


@end

@implementation HealthViewController
@synthesize viewController = _viewController;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"健康";
    [self gongli];
    [self bushu];
    
    MLHealthManager *manager = [[MLHealthManager alloc] init];
    [manager getIphoneHealthData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNextBtnWithTitle:@"视频" fuction:@selector(save)];

    [self jiankang];
  
    [self getData];
    
    

}
-(void)save{
    
    HealthKitManage *manage = [HealthKitManage shareInstance];
    [manage fetchAllHealthDataByDay:^(double setup) {
        NSLog(@"防作弊数据: %f",setup);
    }];
    return;
    /*
     系统定义的type：
     
     kCATransitionFade //淡出
     kCATransitionMoveIn //覆盖原图
     kCATransitionPush //推出
     kCATransitionReveal //底部显出来
     举例:animation.type = kCATransitionPush;
     
     翻转方向SubType:
     kCATransitionFromRight
     kCATransitionFromLeft // 默认值
     kCATransitionFromTop
     kCATransitionFromBottom
     
     设置其他动画类型的方法(type)需要用字符串类型取值
     pageCurl 向上翻一页
     pageUnCurl 向下翻一页
     rippleEffect 滴水效果
     suckEffect 收缩效果，如一块布被抽走
     cube 立方体效果
     oglFlip 上下翻转效果
     比如: animation.type =@"pageCurl";
     */
    VideosViewController *vc = [[VideosViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;

    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionReveal;
//    animation.type =@"cube";
    animation.subtype = kCATransitionFromRight;
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    //注意以下方法必须animated设置NO,而且返回的动画还是默
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)getData
{

    
}
- (void)viewWillLayoutSubviews

{
    
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    
}
#pragma mark - 屏幕翻转就会调用
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    // 记录当前是横屏还是竖屏
//    BOOL isLandscape = size.width == WIDTH;
    
    // 翻转的时间
    CGFloat duration = [coordinator transitionDuration];
    
    [UIView animateWithDuration:duration animations:^{
        
        // 1.设置dockview的frame
        
        // 2.屏幕翻转后(设置完dockview的frame)要重新设置contentView的x值
        
    }];
}
-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    if (orientation == UIDeviceOrientationPortrait ||orientation ==
        UIDeviceOrientationPortraitUpsideDown) { // 竖屏
        NSLog(@"竖屏");

    } else { // 横屏
        NSLog(@"横屏");

    }
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {

    
    switch (interfaceOrientation) {
        caseUIInterfaceOrientationPortrait:
            //home健在下
            
            NSLog(@"home健在下");
            break;
        caseUIInterfaceOrientationPortraitUpsideDown:
            //home健在上
            NSLog(@"home健在上");

            break;
        caseUIInterfaceOrientationLandscapeLeft:
            //home健在左
            NSLog(@"home健在左");


            break;
        caseUIInterfaceOrientationLandscapeRight:
            //home健在右
            NSLog(@"home健在右");


            break;
        default:
            break;
            
            
    }
}

-(void)backBtn
{
    
}
-(void)jiankang
{
    self.title = @"修改健康步数";
    _manager = [CHHealthKitManager shareInstance];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _healthStore = [[HKHealthStore alloc] init];
    _pedoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, WIDTH / 2, WIDTH / 2)];
    _pedoLab.centerX = self.view.centerX;
    _pedoLab.layer.masksToBounds = YES;
    _pedoLab.layer.cornerRadius = WIDTH / 4;
    _pedoLab.backgroundColor = UICOLOR_HEX(0xFF69B4);
    _pedoLab.textColor = [UIColor whiteColor];
    _pedoLab.textAlignment = NSTextAlignmentCenter;
    _pedoLab.numberOfLines = 0;
    [self.view addSubview:_pedoLab];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80 + WIDTH / 2 + 30, 150, 40)];
    _textField.backgroundColor = UICOLOR_HEX(0xf5f5f5);
    _textField.delegate = self;
    _textField.centerX =self.view.centerX;
    [self.view addSubview:_textField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, HEIGHT - 150, 100, 40);
    btn.centerX = self.view.centerX;
    [btn setTitle:@"增加步数" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:UICOLOR_HEX(0x254121)];
    [btn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    

    
   
    
    
    
    
    
    
    if(![HKHealthStore isHealthDataAvailable]){
        NSLog(@"设备不支持healthkit");
    }
    else
    {
        //        5，获取权限和获取数据
        
        //    此处获取权限的写入和读取 获取之后才可以加到数据中
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                
            }else{
                
            }
        }];
    }

}
-(void)creatBackGroundImage
{
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:img];
    
    [img sd_setImageWithURL:[NSURL URLWithString:@"http://125.69.90.201/upload/user/1/2017-05-11/1494496995046_8888_82.jpg"]];
}


-(void)setUpBtn
{
    VPNViewController *vcv = [[VPNViewController alloc] init];
    [self.navigationController pushViewController:vcv animated:YES];

}
-(void)bushu
{
    HealthKitManage *manage = [HealthKitManage shareInstance];
    [manage fetchAllHealthDataByDay:^(double setup) {
        NSLog(@"防作弊数据: %f",setup);
    }];
    [manage authorizeHealthKit:^(BOOL success, NSError *error) {
        
        if (success) {
            NSLog(@"success");
            [manage getStepCount:^(double value, NSError *error) {
                NSLog(@"1count-->%.0f", value);
                NSLog(@"1error-->%@", error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    stepLabel.text = [NSString stringWithFormat:@"步数：%.0f步", value];
                    _bushuString = [NSString stringWithFormat:@"%.0f步", value];
                    _pedoLab.text = [NSString stringWithFormat:@"%@\n%@",_bushuString,_gongliString];

                });
                
            }];
        }
        else {
            NSLog(@"fail");
        }
    }];

}
-(void)gongli
{
    HealthKitManage *manage = [HealthKitManage shareInstance];
    [manage authorizeHealthKit:^(BOOL success, NSError *error) {
        
        if (success) {
            NSLog(@"success");
            [manage getDistance:^(double value, NSError *error) {
                NSLog(@"2count-->%.2f", value);
                NSLog(@"2error-->%@", error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
//                    distanceLabel.text = [NSString stringWithFormat:@"公里数：%.2f公里", value];
                    _gongliString = [NSString stringWithFormat:@"%.0f公里", value];

                });
                
            }];
        }
        else {
            NSLog(@"fail");
        }
    }];
}

-(void)addBtn
{
    [self _addStepsCounts];
    double stepsCounts = [_addString doubleValue];


    [_manager recordKilo:stepsCounts / 2 / 1000 callBack:^(BOOL success) {
        if (success) {
            
        }
    }];
//
}

//4，判断设备是否支持




#pragma mark - 设置写入权限
- (NSSet *)dataTypesToWrite {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    return [NSSet setWithObjects:stepType,distanceType, nil];
}
#pragma mark - 设置读取权限
- (NSSet *)dataTypesToRead {
    
//    以下为设置的权限类型：
    
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    return [NSSet setWithObjects:stepType,distanceType, nil];
}


/*
 以下是关于fitness的全部权限介绍可以直接去看HKQuantityType.h文件很详细，有//fitness，// Body Measurements，// Results，// Vitals等
 
 // Fitness
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierStepCount HK_AVAILABLE_IOS_WATCHOS(8_0, 2_0);                 // Scalar(Count),               Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierDistanceWalkingRunning HK_AVAILABLE_IOS_WATCHOS(8_0, 2_0);    // Length,                      Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierDistanceCycling HK_AVAILABLE_IOS_WATCHOS(8_0, 2_0);           // Length,                      Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierDistanceWheelchair HK_AVAILABLE_IOS_WATCHOS(10_0, 3_0);       // Length,               Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierBasalEnergyBurned HK_AVAILABLE_IOS_WATCHOS(8_0, 2_0);         // Energy,                      Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierActiveEnergyBurned HK_AVAILABLE_IOS_WATCHOS(8_0, 2_0);        // Energy,                      Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierFlightsClimbed HK_AVAILABLE_IOS_WATCHOS(8_0, 2_0);            // Scalar(Count),               Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierNikeFuel HK_AVAILABLE_IOS_WATCHOS(8_0, 2_0);                  // Scalar(Count),               Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierAppleExerciseTime HK_AVAILABLE_IOS_WATCHOS(9_3, 2_2);         // Time                         Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierPushCount HK_AVAILABLE_IOS_WATCHOS(10_0, 3_0);                // Scalar(Count),               Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierDistanceSwimming HK_AVAILABLE_IOS_WATCHOS(10_0, 3_0);         // Length,                      Cumulative
 HK_EXTERN HKQuantityTypeIdentifier const HKQuantityTypeIdentifierSwimmingStrokeCount HK_AVAILABLE_IOS_WATCHOS(10_0, 3_0);      // Scalar(Count),               Cumulative
 */

- (void)_addStepsCounts{
    _addString = _textField.text;
    if (_addString == nil || [_addString isEqualToString:@""]) {
        [self _showAlert:@"请填写增加的步数"];
    }else{
        
        double stepsCounts = [_addString doubleValue];
        HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        NSSet *writeDataTypes = [NSSet setWithObjects:stepCountType, nil];
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:nil completion:^(BOOL success, NSError * _Nullable error) {
        }];
        HKQuantityType * quantityTypeIdentifier = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:stepsCounts];
        
        HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:quantityTypeIdentifier quantity:quantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
        [self.healthStore saveObject:temperatureSample withCompletion:^(BOOL success, NSError * _Nullable error) {
            
            //需要回到主线程显示Alert
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self _showAlert:@"添加成功"];
            
                    
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self _showAlert:@"添加失败"];
                });
                
            }
        }];
        
//        if (isSuccess) {
//           
//        }
    }


    
   
}

- (void)_showAlert:(NSString *)tips{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:tips preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"确定");

        
    }];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self _addStepsCounts];
    return YES;
}
// - (void)startStepCountingUpdatesToQueue:(NSOperationQueue *)queue updateOn:(NSInteger)stepCounts withHandler:(CMStepUpdateHandler)handler
//{
//    
//}

-(void)shua
{

    if (_timer==nil) {
        __block int timeout = 10000; //倒计时时间
        _textField.text = @"1";

        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),0.5*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                                        dispatch_source_cancel(_timer);
                                        _timer = nil;
                                        dispatch_async(dispatch_get_main_queue(), ^{
                    
                                        });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        
                    });
                    [self _addStepsCounts];
    
                    
                }
            });
            dispatch_resume(_timer);
        }
    }
}

- (void)myTask
{
    // Do something usefull in here instead of sleeping ...
    sleep(4);
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
