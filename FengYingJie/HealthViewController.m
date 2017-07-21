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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNextBtnWithTitle:@"保存数据" fuction:@selector(save)];

    [self jiankang];
    [self creatBackBtn];
  
    [self getData];

}
-(void)save
{
    [FYJAvCloud getDataWithClassName:@"FYJ_TABLE" WhereForKey:@"content" Eqyato:@"你好啊" QueryType:QueryTypeContainsStr Success:^(id object) {
        NSLog(@"%@",object);
    } Faill:^(id faillStr) {
        
    }];
// 
//    [FYJAvCloud getDataWithClassName:@"FYJ_TABLE" objectId:nil success:^(id object) {
//        NSLog(@"%@",object);
//    } faill:^(id faillStr) {
//        NSLog(@"错误:%@",faillStr);
//    }];
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
-(void)creatBackBtn
{
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.bounds = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"my_headerImg"]
             forState:UIControlStateNormal];

    [backBtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.layer.masksToBounds = YES;
    backBtn.layer.cornerRadius = 25;
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
      self.navigationItem.leftBarButtonItem = backBtnItem;
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
    
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn1.frame = CGRectMake(0, HEIGHT - 100, WIDTH, 50);
//    btn1.centerX = self.view.centerX;
//    [btn1 setTitle:@"高仿走步" forState:UIControlStateNormal];
//    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn1 setBackgroundColor:UICOLOR_HEX(0x254121)];
//    [btn1 addTarget:self action:@selector(setUpBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn1];
//    btn1.layer.masksToBounds = YES;
//    btn1.layer.cornerRadius = 5;
    
    
    [self gongli];
    [self bushu];
    
    
    
    
    
    
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
//    [self shua];

}
-(void)bushu
{
    HealthKitManage *manage = [HealthKitManage shareInstance];
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
