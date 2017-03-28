//
//  GetDate.m
//  ForNowIosSupper
//
//  Created by fornowIOS on 15/4/13.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "GlobalCenter.h"
#import <CommonCrypto/CommonDigest.h>
static const void *HUDKEY = &HUDKEY;
static const void *INDICATORKEY = &INDICATORKEY;
static const void *ALERTKEY = &ALERTKEY;
static const void *BGVIEWKEY = &BGVIEWKEY;
static const void *WIFIVIEW = &WIFIVIEW;
@implementation GlobalCenter

static GlobalCenter *instance = nil;

//单例
+ (GlobalCenter *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        instance = [[self alloc] init];
    });
    return instance;
}



- (NSString *)md5Str:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *md5Str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [md5Str appendFormat:@"%02x",result[i]];
    }
    return md5Str;
}

//去除两端空格
- (NSString *)isTrimmingStr:(NSString *)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//拼接字符串
- (NSString *)firstStr:(NSString *)firstStr
             secondStr:(NSString *)secondStr
              splitStr:(NSString *)splitStr
{
    return [NSString stringWithFormat:@"%@%@%@", firstStr, splitStr, secondStr];
}

//是否为空
- (BOOL)isNullStr:(NSString *)str
{
    if ([@"" isEqualToString:str] || NULL == str || nil == str || [@"(null)" isEqualToString:str] || [@"<null>" isEqualToString:str] || [[NSNull null] isEqual:str] || [@"NULL" isEqualToString:str] || [@"nil" isEqualToString:str] || [@"null" isEqualToString:str])
    {
        return YES;
    }
    return NO;
}

//是否为手机号码
- (BOOL)isMobileStr:(NSString *)str
{
    NSString *regex = @"^0{0,1}(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])[0-9]{8}$";
    NSPredicate *regextes = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([regextes evaluateWithObject:str] == YES)
    {
        return YES;
    }
    return NO;
}

//是否是酬金
- (BOOL)charkMoneyStr:(NSString *)str
{
    
    NSString *regex = @"^[0-9]{0}|[0-9]{0,1}|[0-9]{0,2}|[0-9]{0,3}|[0-9]{0,4}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:str])
    {
        return YES;
    }
    return NO;
}

//是否为昵称
- (BOOL)isNicknameStr:(NSString *)str
{
    NSString *regex = @"^[0-9a-zA-Z\u4e00-\u9fa5]{1,20}$";
    NSPredicate *regextes = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([regextes evaluateWithObject:str] == YES)
    {
        return YES;
    }
    return NO;
}

//是否为密码
- (BOOL)isPasswordStr:(NSString *)str
{
    //   ^[a-zA-Z0-9]{1,16}+$
    NSString *regex = @"^(?![a-zA-Z0-9]+$)|(?![^a-zA-Z/D]+$)|(?![^0-9/D]+$).{6,20}$";
    NSPredicate *regextes = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([regextes evaluateWithObject:str] == YES)
    {
        return YES;
    }
    return NO;
}
//是否为银行卡
- (BOOL) checkCardNo:(NSString*) cardNo
{
    //^(\d{16}|\d{19})$
    NSString *regex = @"^[0-9]{14}|[0-9]{15}|[0-9]{16}|[0-9]{17}|[0-9]{18}|[0-9]{19}$";
    NSPredicate *regextes = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([regextes evaluateWithObject:cardNo] == YES)
    {
        return YES;
    }
    return NO;
}
//是否为验证码
- (BOOL)isCodeStr:(NSString *)str
{
    NSString *regex = @"^[0-9]{6}$";
    NSPredicate *regextes = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([regextes evaluateWithObject:str] == YES)
    {
        return YES;
    }
    return NO;
}

//是否为年龄
- (BOOL)isAgeStr:(NSString *)str
{
    NSString *regex = @"([0-9]{0,2})|(1([0-1][0-9]|20))";
    NSPredicate *regextes = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([regextes evaluateWithObject:str] == YES)
    {
        return YES;
    }
    return NO;
}
//是否存在图片
- (BOOL)isImageUrl:(NSString *)str
{
    NSRange range = [str rangeOfString:@"null"];
    if (range.location == NSNotFound)
    {
        return YES;
    }
    else if (str == nil)
    {
        return NO;
    }
    return NO;
}

//是否支持摄像头
- (BOOL)isCameraAvailable
{
//    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if(status == AVAuthorizationStatusAuthorized)
//    {
//        return YES;
// 
//    } else
//    {
//        return NO;
//    }
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

//是否支持前置摄像头
- (BOOL)isFrontCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
//加*****
-(NSString *)phone:(NSString *)str
{
    return [str stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}
//是否支持相册
- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

//颜色转背景
- (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//按比例压缩图片大小
- (UIImage *)imageWithScale:(UIImage *)sourceImage
                       size:(CGSize)size;
{
    UIGraphicsBeginImageContext(size);
    [sourceImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, 1)];
    return newImage;
}




//下载等比图片加强版
- (void)thumbnailWithImageWithoutScale:(UIImage *)image
                                  size:(CGSize)asize
                                 yaSuo:(compressOne)block
{
    NSArray * arr = [NSArray array];
    if (image.size.width > asize.width) {
        UIImage *newimage;
        if (nil == image) {
            newimage = nil;
        }
        else{
            CGSize oldsize = image.size;
            CGRect rect;
            if (asize.width/asize.height > oldsize.width/oldsize.height) {
                rect.size.width = asize.height*oldsize.width/oldsize.height;
                rect.size.height = asize.height;
                rect.origin.x = (asize.width - rect.size.width)/2;
                rect.origin.y = 0;
            }
            else{
                rect.size.width = asize.width;
                rect.size.height = asize.width*oldsize.height/oldsize.width;
                rect.origin.x = 0;
                rect.origin.y = 0;//(asize.height - rect.size.height)/2
            }
            
            
            UIGraphicsBeginImageContext(rect.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
            UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear
            [image drawInRect:rect];
            newimage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            NSValue * value = [NSValue valueWithCGRect:rect];
            arr = @[newimage,value];
            
        }
        block(arr);
    }
    else
    {
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        NSValue *value = [NSValue valueWithCGRect:rect];
        arr = @[image,value];
        block(arr);
    }
    
}
//GMT转为本地时间
- (NSString *)gmtTimeToLocaleDate:(NSString *)gmtTime
{
    if (gmtTime.length > 10)
    {
        gmtTime = [gmtTime substringToIndex:10];
    }
    NSDate *gmtTimeDate = [NSDate dateWithTimeIntervalSince1970:[gmtTime intValue]];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:gmtTimeDate];
    NSDate *localeDate = [gmtTimeDate  dateByAddingTimeInterval: interval];
    NSString *localeDateStr = [NSString stringWithFormat:@"%@", localeDate];
    return localeDateStr;
}

//日期转为星期
- (NSString *)dateToWeek:(NSString *)dateStr
{
    NSString *week = nil;
    switch ([dateStr intValue])
    {
        case 0:
            week = @"周几";
            break;
        case 1:
            week = @"周一";
            break;
        case 2:
            week = @"周二";
            break;
        case 3:
            week = @"周三";
            break;
        case 4:
            week = @"周四";
            break;
        case 5:
            week = @"周五";
            break;
        case 6:
            week = @"周六";
            break;
        case 7:
            week = @"周日";
            break;
        default:
            break;
    }
    return week;
}
//计算文字高度
-(float)TextHeightSize:(CGSize)size
                  Font:(int)font
                  Text:(NSString *)text
{
    CGSize sizeOne =[text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:font]} context:nil].size;
    return sizeOne.height+10;
}
//格式话小数 四舍五入类型
- (NSString *) decimalwithfloatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@"0.00"];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}
//UTF_8编码
-(NSString *)utfstr:(NSString *)str
{
//    NSString *str3 = [str stringByAddingPercentEscapesUsingEncoding:
//                      NSUTF8StringEncoding];
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

//    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSData *str2 = [str dataUsingEncoding:gbkEncoding];
//    NSString *name = [NSString stringWithFormat:@"%@",str2];
    return str1;
}
-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

//- (NSString *)getSaveKey:(int)imageIdx
//{
//    return [NSString stringWithFormat:@"/%d/%d/%.0f/%d.png", [self getYear:[NSDate date]], [self getMonth:[NSDate date]], [[NSDate date] timeIntervalSince1970], imageIdx];
//}

//- (int)getYear:(NSDate *)date
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeStyle:NSDateFormatterMediumStyle];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSInteger unitFlags = NSYearCalendarUnit;
//    NSDateComponents *comps = [calendar components:unitFlags
//                                          fromDate:date];
//    int year = [comps year];
//    return year;
//}
//
//- (int)getMonth:(NSDate *)date
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeStyle:NSDateFormatterMediumStyle];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSInteger unitFlags = NSMonthCalendarUnit;
//    NSDateComponents *comps = [calendar components:unitFlags
//                                          fromDate:date];
//    int month = [comps month];
//    return month;
//}

@end
