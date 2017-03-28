//
//  GetDate.h
//  ForNowIosSupper
//
//  Created by fornowIOS on 15/4/13.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^compressOne)(NSArray *datas);

/*
 *数据校验
 */
@interface GlobalCenter : NSObject

+ (GlobalCenter *)sharedInstance;
- (NSString *)md5Str:(NSString *)str;
- (NSString *)firstStr:(NSString *)firstStr
             secondStr:(NSString *)secondStr
              splitStr:(NSString *)splitStr;
- (NSString *)isTrimmingStr:(NSString *)str;
- (BOOL)isNullStr:(NSString *)str;
- (BOOL)isMobileStr:(NSString *)str;
- (BOOL)isNicknameStr:(NSString *)str;
- (BOOL)isPasswordStr:(NSString *)str;
- (BOOL)isCodeStr:(NSString *)str;
- (BOOL)isAgeStr:(NSString *)str;
- (BOOL)isImageUrl:(NSString *)str;
- (BOOL)isCameraAvailable;
- (BOOL)isFrontCameraAvailable;
- (BOOL)isPhotoLibraryAvailable;
- (BOOL)charkMoneyStr:(NSString *)str;
- (BOOL) checkCardNo:(NSString*) cardNo;
- (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;
- (UIImage *)imageWithScale:(UIImage *)sourceImage
                       size:(CGSize)size;

- (NSString *)gmtTimeToLocaleDate:(NSString *)gmtTime;
- (NSString *)dateToWeek:(NSString *)dateStr;

-(float)TextHeightSize:(CGSize)size
                  Font:(int)font
                  Text:(NSString *)text;
- (NSString *) decimalwithfloatV:(float)floatV;
-(NSString *)utfstr:(NSString *)str;
-(NSString *)phone:(NSString *)str;
-(NSString*) uuid;
@end
