//
//  HealthKitManage.h
//  FengYingJie
//
//  Created by Macintosh HD on 2017/4/21.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//
#define HKVersion [[[UIDevice currentDevice] systemVersion] doubleValue]
#define CustomHealthErrorDomain @"com.sdqt.healthError"
#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import <UIKit/UIDevice.h>
@interface HealthKitManage : NSObject
@property (nonatomic, strong) HKHealthStore *healthStore;
+(id)shareInstance;
- (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))compltion;
- (NSSet *)dataTypesToWrite;
- (NSSet *)dataTypesRead;
- (void)getStepCount:(void(^)(double value, NSError *error))completion;
//获取公里数
- (void)getDistance:(void(^)(double value, NSError *error))completion;
+ (NSPredicate *)predicateForSamplesToday;
@end
