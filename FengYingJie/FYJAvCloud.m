//
//  FYJAvCloud.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/7/19.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "FYJAvCloud.h"

@implementation FYJAvCloud
//上传 创建  插入数据
+(void)AVObjectWithClassName:(NSString *)className
                      Object:(id)object
                         Key:(NSString *)key
{
    AVObject *todo = [AVObject objectWithClassName:className];
    [todo setObject:object forKey:key];
    [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 存储成功
            NSLog(@"储存成功");
        } else {
            // 失败的话，请检查网络环境以及 SDK 配置是否正确
            NSLog(@"储存失败");
        }
    }];
}

//获取数据
+(void)getDataWithClassName:(NSString *)className objectId:(NSString *)objectId success:(success)success faill:(FaillStr)faillStr
{
    if (objectId) {
        // 第一个参数是 className，第二个参数是 objectId
        AVObject *todo =[AVObject objectWithClassName:className objectId:objectId];
        [todo fetchInBackgroundWithBlock:^(AVObject *avObject, NSError *error) {
            if (avObject) {
                success(avObject);

            }
            else
            {
                faillStr([error localizedDescription]);
            }
        }];
    }
    else
    {
        AVQuery *query = [AVQuery queryWithClassName:className];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            success(objects);

            NSArray<AVObject *> *todos = objects;
            
            for (AVObject *todo in todos) {
                todo[@"status"] = @1;
            }
            
            [AVObject saveAllInBackground:todos block:^(BOOL succeeded, NSError *error) {
                if (error) {
                    // 网络错误
                } else {
                    // 保存成功
                }
            }];
        }];

    }
 
}
//查询指定条件的数据
+(void)getDataWithClassName:(NSString *)className WhereForKey:(NSString *)key Eqyato:(id)values QueryType:(FYJQuery)queryType Success:(success)successStr Faill:(FaillStr)faillStr
{
    switch (queryType) {
        case QueryTypeInteger:
        {
            AVQuery *query = [AVQuery queryWithClassName:className];
            [query whereKey:key equalTo:values];
            // 如果这样写，第二个条件将覆盖第一个条件，查询只会返回 priority = 1 的结果
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (objects) {
                    successStr(objects);
                }
                else
                {
                    faillStr([error localizedDescription]);
                }
            }];
        }
            break;
        //字符串前缀查询
        case QueryTypePrefixStr:
        {
            AVQuery *query = [AVQuery queryWithClassName:className];
            [query whereKey:key hasPrefix:values];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (objects) {
                    successStr(objects);
                }
                else
                {
                    faillStr([error localizedDescription]);
                }
            }];
        }
            break;
        //包含查询
        case QueryTypeContainsStr:
        {
            AVQuery *query = [AVQuery queryWithClassName:className];
            [query whereKey:key containsString:values];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (objects) {
                    successStr(objects);
                }
                else
                {
                    faillStr([error localizedDescription]);
                }
            }];
        }
            break;
        //不包含查询
        case QueryTypeNotContainsStr:
        {
            AVQuery *query = [AVQuery queryWithClassName:className];
            [query whereKey:key matchesRegex:[NSString stringWithFormat:@"^((?!%@).)*$",values]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (objects) {
                    successStr(objects);
                }
                else
                {
                    faillStr([error localizedDescription]);
                }
            }];
        }
            break;
            
        default:
            break;
    }
   
}
/*提供下面的信息有助于更快地解决问题：
 1、问题详情：
 
 看文档说明必须填写objectId,这就是限制了每次只能查询一个表中的一行数据,而实际应用中可能会查询整个表的数据或者分页查询 比如每请求一次只查询十行数据   某些时候也会涉及到多个表的数据组合查询,请问以上问题如何实现?是否有提供API? 谢谢!
 
 2、SDK 版本号：
 pod2017年7月19install的最新版本
 
 3、相关代码片段：
 这是文档提供的查询实例
 // 第一个参数是 className，第二个参数是 objectId
 AVObject *todo =[AVObject objectWithClassName:className objectId:objectId];
 [todo fetchInBackgroundWithBlock:^(AVObject *avObject, NSError *error) {
 
 }];
 4、相关日志：
 （打开日志的方法：[AVOSCloud setAllLogsEnabled:YES];）*/
@end
