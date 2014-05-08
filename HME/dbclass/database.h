//
//  database.h
//  HME
//
//  Created by 夏 伟 on 13-12-25.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define kSqliteFileName                     @"data.db3"
@interface database : NSObject

+(BOOL)insert:(NSString *)sqlstring;
+(BOOL)delete:(NSString *)sqlstring;
+(NSDictionary *)selectUserByName:(NSString *)username;
+(BOOL)update:(NSString *)sqlstring;
+(BOOL)createtabel:(NSString *)sqlstring;
+(BOOL)initDataBase;
+(NSMutableArray *)getBodyFatDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
+(NSMutableArray *)getWeightDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
+(NSMutableArray *)getBloodPressDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
+(NSMutableArray *)getGlucoseDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
@end
