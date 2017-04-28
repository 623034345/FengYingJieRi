//
//  CHHealthKitManager.h
//  CH_HealthCareTest
//
//  Created by 陈浩 on 2017/4/14.
//  Copyright © 2017年 easyGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface CHHealthKitManager : NSObject


/**
  权限判断 以及对步数距离数据的写入 
 */
@property (nonatomic, strong) HKHealthStore *healthStore;

/**
 单例

 @return 返回该类对象
 */
+(id)shareInstance;

/**
 获取权限的方法

 @param finish 检测是否获取到权限
 */
-(void)getAuthorizedForHealthKit:(void(^)(BOOL isFinished))finish;
/**
 获取步数
 @param completion 步数以及错误信息
 */
- (void)getStepCount:(void(^)(double value, NSError *error))completion;
/**
 获取距离
 @param completion 距离以及错误信息
 */
- (void)getDistance:(void(^)(double value, NSError *error))completion;
/**
 添加步数

 @param step 需要添加的步数
 */
-(void)recordStep:(double)step callBack:(void(^)(BOOL success))completion;

/**
 添加公里数

 @param kilo 需要添加的公里数
 */
-(void)recordKilo:(double)kilo callBack:(void(^)(BOOL success))completion;

@end
