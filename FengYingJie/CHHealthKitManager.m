//
//  CHHealthKitManager.m
//  CH_HealthCareTest
//
//  Created by 陈浩 on 2017/4/14.
//  Copyright © 2017年 easyGroup. All rights reserved.
//

#import "CHHealthKitManager.h"
#import <HealthKit/HealthKit.h>

@implementation CHHealthKitManager

+(id)shareInstance{
     static id manager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
        
    });
    return manager;
}

-(NSSet *)typesToWrite{
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distance = [HKObjectType quantityTypeForIdentifier: HKQuantityTypeIdentifierDistanceWalkingRunning];
    return [NSSet setWithObjects:stepType,distance, nil];
}


//设置读写以下为设置的权限类型：
- (NSSet *)typesToRead {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distance = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    return [NSSet setWithObjects:stepType,distance, nil];
}

-(void)getAuthorizedForHealthKit:(void (^)(BOOL))finish{
    //需要确定设备支持HealthKit
    if (![HKHealthStore isHealthDataAvailable]) {
        return;
    }
    if(self.healthStore == nil){
        self.healthStore = [[HKHealthStore alloc] init];
    }
    NSSet * typesToShare = [self typesToWrite];
    NSSet * typesToRead = [self typesToRead];
    [self.healthStore requestAuthorizationToShareTypes:typesToShare readTypes:typesToRead completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finish(YES);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Health has not authorized!");
                finish(NO);
            });
        }
    }];
}

//获取步数
- (void)getStepCount:(void(^)(double value, NSError *error))completion
{
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:[CHHealthKitManager predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            NSInteger totleSteps = 0;
            for(HKQuantitySample *quantitySample in results)
            {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *heightUnit = [HKUnit countUnit];
                double usersHeight = [quantity doubleValueForUnit:heightUnit];
                totleSteps += usersHeight;
            }
            completion(totleSteps,error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}

//获取公里数
- (void)getDistance:(void(^)(double value, NSError *error))completion
{
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:distanceType predicate:[CHHealthKitManager predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        if(error)
        {
            completion(0,error);
        }
        else
        {
            double totleSteps = 0;
            for(HKQuantitySample *quantitySample in results)
            {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *distanceUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
                double usersHeight = [quantity doubleValueForUnit:distanceUnit];
                totleSteps += usersHeight;
            }
            completion(totleSteps,error);
        }
    }];
    [self.healthStore executeQuery:query];
}

//添加步数
-(void)recordStep:(double)step callBack:(void (^)(BOOL))completion{
    //  categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    if ([HKHealthStore isHealthDataAvailable] ) {
        HKQuantity *stepQuantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:step];
        HKQuantitySample *stepSample = [HKQuantitySample quantitySampleWithType:stepType quantity:stepQuantity startDate:[NSDate date] endDate:[NSDate date]];
        [self.healthStore saveObject:stepSample withCompletion:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(YES);
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(NO);
                });
            }
        }];
    }
}

//添加公里数
-(void)recordKilo:(double)kilo callBack:(void (^)(BOOL))completion{
    
    self.healthStore = [[HKHealthStore alloc] init];

    //  categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    NSSet *writeDataTypes = [self dataTypesToWrite];

    if ([HKHealthStore isHealthDataAvailable] ) {
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:nil completion:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"hh 成功了");
            }
            else
            {
                NSLog(@"hh  %@",error);

            }
        }];
        HKQuantity *stepQuantity = [HKQuantity quantityWithUnit:[HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo] doubleValue:kilo];
        HKQuantitySample *stepSample = [HKQuantitySample quantitySampleWithType:stepType quantity:stepQuantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
        [self.healthStore saveObject:stepSample withCompletion:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(YES);
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(NO);
                });
            }
        }];
    }
    

 

    
//    HKHealthStore *healthStore = [[HKHealthStore alloc]init];
//    
//    double stepsCounts = kilo;
//    
//    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
//    NSSet *writeDataTypes = [NSSet setWithObjects:stepCountType, nil];
//    [healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:nil completion:^(BOOL success, NSError * _Nullable error) {
//    }];
//    HKQuantityType * quantityTypeIdentifier = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:stepsCounts];
//    
//    HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:quantityTypeIdentifier quantity:quantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
//    
//    [healthStore saveObject:temperatureSample withCompletion:^(BOOL success, NSError * _Nullable error) {
//        if (success) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"success");
//            });
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"fail");
//            });
//        }
//    }];
    

}


/*!
 *  @brief  当天时间段
 *
 *  @return 时间段
 */
+ (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}
- (NSSet *)dataTypesToWrite {
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *walkType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];

    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType,stepType,walkType, nil];
}
@end
