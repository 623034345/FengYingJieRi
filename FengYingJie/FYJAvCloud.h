//
//  FYJAvCloud.h
//  FengYingJie
//
//  Created by Macintosh HD on 2017/7/19.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//
typedef void(^success)(id object);
typedef void(^FaillStr)(id faillStr);
typedef NS_ENUM(NSInteger,FYJQuery){
    QueryTypeInteger = 1024,//在简单查询中，如果对一个对象的同一属性设置多个条件，那么先前的条件会被覆盖，查询只返回满足最后一个条件的结果
    QueryTypePrefixStr,//字符串前缀查询
    QueryTypeContainsStr,//包含查询
    QueryTypeNotContainsStr,//不包含查询
};
#import <Foundation/Foundation.h>

@interface FYJAvCloud : NSObject

+(void)AVObjectWithClassName:(NSString *)className
                      Object:(id)object
                         Key:(NSString *)key;

+(void)getDataWithClassName:(NSString *)className objectId:(NSString *)objectId success:(success)success faill:(FaillStr)faillStr;
//查询指定条件的数据
+(void)getDataWithClassName:(NSString *)className WhereForKey:(NSString *)key Eqyato:(id)values QueryType:(FYJQuery)queryType Success:(success)successStr Faill:(FaillStr)faillStr;
@end
