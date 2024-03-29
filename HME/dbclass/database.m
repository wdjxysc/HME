//
//  database.m
//  HME
//
//  Created by 夏 伟 on 13-12-25.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "database.h"
#import <sqlite3.h>

@implementation database

+(BOOL)insert:(NSString *)sqlstring
{
    BOOL b = 0;
    
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    char* errorMsg;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    if(sqlite3_exec(database, [sqlstring UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){//备注2
        //插入数据失败，关闭数据库
        sqlite3_close(database);
        //        NSAssert1(0, @"插入数据失败：%@", errorMsg);
        NSLog(@"插入数据失败：%s",errorMsg);
        sqlite3_free(errorMsg);
    }
    else
    {
        b = 1;
    }
    //关闭数据库
    sqlite3_close(database);
    
    
    return b;
}

+(BOOL)delete:(NSString *)sqlstring
{
    bool b = 0;
    
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    char* errorMsg;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    if(sqlite3_exec(database, [sqlstring UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){//备注2
        //插入数据失败，关闭数据库
        sqlite3_close(database);
        //        NSAssert1(0, @"插入数据失败：%@", errorMsg);
        NSLog(@"删除数据失败：%s",errorMsg);
        sqlite3_free(errorMsg);
    }
    else
    {
        b = 1;
    }
    //关闭数据库
    sqlite3_close(database);
    
    return b;
}

+(BOOL)update:(NSString *)sqlstring
{
    bool b = 0;
    
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    char* errorMsg;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    if(sqlite3_exec(database, [sqlstring UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){//备注2
        //插入数据失败，关闭数据库
        sqlite3_close(database);
        //        NSAssert1(0, @"插入数据失败：%@", errorMsg);
        NSLog(@"更新数据失败：%s",errorMsg);
        sqlite3_free(errorMsg);
    }
    else
    {
        b = 1;
    }
    //关闭数据库
    sqlite3_close(database);
    
    return b;
}

/**
 通过用户名查找用户信息.
 @param username 用户名
 */
+(NSDictionary *)selectUserByName:(NSString *)username
{
    NSDictionary *returndata;
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    
    NSString *sqlQuery = [[NSString alloc]initWithFormat:@"SELECT USERID,USERNAME,PASSWORD, WEIGHT,BRITHDAY,SEX,HEIGHT,SPORTLVL FROM USER WHERE USERNAME = '%@' ORDER BY USERID ASC",username];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int userid = sqlite3_column_double(statement, 0);
            char *username = (char *)sqlite3_column_text(statement,1);
            char *password = (char *)sqlite3_column_text(statement,2);
            double weight = sqlite3_column_double(statement, 3);
            char *brithday = (char *)sqlite3_column_text(statement,4);
            int sex = sqlite3_column_double(statement, 5);
            int height = sqlite3_column_double(statement, 6);
            int sportlvl = sqlite3_column_double(statement, 7);
            
            NSString *weightstr = [[NSString alloc]initWithFormat:@"%.1f",weight];
            
            returndata =[[NSDictionary alloc] initWithObjectsAndKeys:
                         [[NSString alloc] initWithFormat:@"%d", userid],
                         @"Userid",
                         [[NSString alloc] initWithFormat:@"%s", username],
                         @"UserName",
                         [[NSString alloc] initWithFormat:@"%s", password],
                         @"PassWord",
                         weightstr,
                         @"Weight",
                         [[NSString alloc] initWithFormat:@"%s", brithday],
                         @"Brithday",
                         [[NSString alloc] initWithFormat:@"%d", sex],
                         @"Sex",
                         [[NSString alloc] initWithFormat:@"%d", height],
                         @"Height",
                         [[NSString alloc] initWithFormat:@"%d", sportlvl],
                         @"Sportlvl",
                         nil];
        }
    }
    //关闭数据库
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
    return returndata;
}


+(NSMutableArray *)getBodyFatDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    sqlite3 *database;
    NSString *filePath = [self dataFilePath];
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    NSMutableArray *bodyfatdataArray = [[NSMutableArray alloc] init];
    NSString *bodyfatsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM BODYFATDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC",username,date1str,date2str];
    sqlite3_stmt * bodyfatstatement;
    
    if (sqlite3_prepare_v2(database, [bodyfatsqlQuery UTF8String], -1, &bodyfatstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(bodyfatstatement) == SQLITE_ROW) {
            double weight = sqlite3_column_double(bodyfatstatement, 7);
            double fat = sqlite3_column_double(bodyfatstatement, 8);
            int visceralfat = sqlite3_column_int(bodyfatstatement, 9);
            double water = sqlite3_column_double(bodyfatstatement, 10);
            double bone = sqlite3_column_double(bodyfatstatement, 11);
            double muscle = sqlite3_column_double(bodyfatstatement, 12);
            int bmr = sqlite3_column_int(bodyfatstatement, 13);
            double bmi = sqlite3_column_double(bodyfatstatement, 14);
            char *testtimechar = (char *)sqlite3_column_text(bodyfatstatement, 15);
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            NSString *weightstr = [[NSString alloc]initWithFormat:@"%.1f",weight];
            NSString *fatstr = [[NSString alloc]initWithFormat:@"%.1f",fat];
            NSString *visceralfatstr = [[NSString alloc]initWithFormat:@"%d",visceralfat];
            NSString *waterstr = [[NSString alloc]initWithFormat:@"%.1f",water];
            NSString *bonestr = [[NSString alloc]initWithFormat:@"%.1f",bone];
            NSString *musclestr = [[NSString alloc]initWithFormat:@"%.1f",muscle];
            NSString *kcalstr = [[NSString alloc]initWithFormat:@"%d",bmr];
            NSString *bmistr = [[NSString alloc]initWithFormat:@"%.1f",bmi];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     [[NSString alloc] initWithFormat:@"%@", testtimestr],
                                     @"TestTime",
                                     weightstr,
                                     @"Weight",
                                     fatstr,
                                     @"Fat",
                                     musclestr,
                                     @"Muscle",
                                     waterstr,
                                     @"Water",
                                     bonestr,
                                     @"Bone",
                                     visceralfatstr,
                                     @"VisceralFat",
                                     kcalstr,
                                     @"BMR",
                                     bmistr,
                                     @"BMI",
                                     nil];
            
            //NSLog(@"USERNAME:%@  AGE:%d  SEX:%@",weightstr,age, nsAddressStr);
            
            [bodyfatdataArray addObject:dataRow1];
            
        }
    }
    
    sqlite3_finalize(bodyfatstatement);
    sqlite3_close(database);
    return bodyfatdataArray;
}


+(NSMutableArray *)getWeightDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSMutableArray *weightdataArray = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    NSString *weightsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM WEIGHTDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC",username,date1str,date2str];
    //sqlQuery = @"SELECT * FROM WEIGHTDATA WHERE USERID = 1";
    sqlite3_stmt * weightstatement;
    
    if (sqlite3_prepare_v2(database, [weightsqlQuery UTF8String], -1, &weightstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(weightstatement) == SQLITE_ROW) {
            double weight = sqlite3_column_double(weightstatement, 3);
            char *testtimechar = (char *)sqlite3_column_text(weightstatement, 4);
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            NSString *weightstr = [[NSString alloc]initWithFormat:@"%.1f",weight];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     [[NSString alloc] initWithFormat:@"%@", testtimestr],
                                     @"TestTime",
                                     weightstr,
                                     @"Weight",
                                     nil];
            [weightdataArray addObject:dataRow1];
        }
    }
    sqlite3_finalize(weightstatement);
    sqlite3_close(database);
    return weightdataArray;
}


/**
 查询当前用户在一段时间内的血压数据。
 @param username 用户名
 @param begintime 开始时间
 @param endtime   结束时间
 */
+(NSMutableArray *)getBloodPressDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSMutableArray *bpdataArray = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    NSString *bpsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM BLOODPRESSDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC", username, date1str, date2str];
    //sqlQuery = @"SELECT * FROM WEIGHTDATA WHERE USERID = 1";
    sqlite3_stmt * bpstatement;
    
    if (sqlite3_prepare_v2(database, [bpsqlQuery UTF8String], -1, &bpstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(bpstatement) == SQLITE_ROW) {
            double sys = sqlite3_column_double(bpstatement, 3);
            double dia = sqlite3_column_double(bpstatement, 4);
            double pulse = sqlite3_column_double(bpstatement, 5);
            char *testtimechar = (char *)sqlite3_column_text(bpstatement, 6);
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            NSString *sysstr = [[NSString alloc]initWithFormat:@"%.1f",sys];
            NSString *diastr = [[NSString alloc]initWithFormat:@"%.1f",dia];
            NSString *pulsestr = [[NSString alloc]initWithFormat:@"%.1f",pulse];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     [[NSString alloc] initWithFormat:@"%@", testtimestr],
                                     @"TestTime",
                                     sysstr,
                                     @"SYS",
                                     diastr,
                                     @"DIA",
                                     pulsestr,
                                     @"Pulse",
                                     nil];
            [bpdataArray addObject:dataRow1];
        }
    }
    sqlite3_finalize(bpstatement);
    sqlite3_close(database);
    return bpdataArray;
}

/**
 查询当前用户在一段时间内的血糖数据。
 @param username 用户名
 @param begintime 开始时间
 @param endtime   结束时间
 */
+(NSMutableArray *)getGlucoseDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSMutableArray *bpdataArray = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    NSString *bpsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM GLUCOSEDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC", username, date1str, date2str];
    //sqlQuery = @"SELECT * FROM WEIGHTDATA WHERE USERID = 1";
    sqlite3_stmt * bpstatement;
    
    if (sqlite3_prepare_v2(database, [bpsqlQuery UTF8String], -1, &bpstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(bpstatement) == SQLITE_ROW) {
            double glucose = sqlite3_column_double(bpstatement, 3);
            char *testtimechar = (char *)sqlite3_column_text(bpstatement, 4);
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            NSString *glucosestr = [[NSString alloc]initWithFormat:@"%.1f",glucose];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     [[NSString alloc] initWithFormat:@"%@", testtimestr],
                                     @"TestTime",
                                     glucosestr,
                                     @"Glucose",
                                     nil];
            [bpdataArray addObject:dataRow1];
        }
    }
    sqlite3_finalize(bpstatement);
    sqlite3_close(database);
    return bpdataArray;
}



+(BOOL)createtabel:(NSString *)sqlstring
{
    BOOL b = 0;
    
    //确定是否有数据文件及相应表，若无则创建
    NSString *filePath = [self dataFilePath];
    
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    char* errorMsg;
    
    if(sqlite3_exec(database, [sqlstring UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){//备注2
        //创建表失败，关闭数据库
        sqlite3_close(database);
        NSAssert1(0, @"创建表失败：%s", errorMsg);
        sqlite3_free(errorMsg);
    }
    else
    {
        b =1;
    }
    
    sqlite3_close(database);
    
    return b;
}

+(BOOL)initDataBase
{
    BOOL b = 0;
    
    //创建脂肪秤数据表 数据id，用户id，用户名，年龄，性别，运动等级，身高，体重，脂肪率，内脏脂肪等级，水分率，骨量，肌肉量，BMR(基础代谢)，BMI，测试时间，版本号，是否发送
    NSString *sqlCreateFatTable = @"CREATE TABLE IF NOT EXISTS BODYFATDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, AGE INTEGER, SEX INTEGER, SPORTLVL INTEGER, HEIGHT INTEGER, WEIGHT FLOAT, BODYFAT FLOAT, VISCERALFAT INTEGER, WATER FLOAT, BONE FLOAT, MUSCLE FLOAT, BMR INTEGER, BMI FLOAT, TESTTIME TIMESTAMP, VERSION FLOAT,ISSEND TEXT)";
    
    //创建健康秤数据表 数据id，用户id，用户名，体重，测量时间，是否上传
    NSString *sqlCreateWeightTable = @"CREATE TABLE IF NOT EXISTS WEIGHTDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, WEIGHT FLOAT, TESTTIME TIMESTAMP, ISSEND TEXT)";

    //创建用户表 用户id，用户名，生日，性别(0男,1女)，运动级别(1白领，2普通，3运动员),身高（cm），体重，步幅，密码，
    NSString *sqlCreateUserTable = @"CREATE TABLE IF NOT EXISTS USER(USERID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, BRITHDAY TIMESTAMP, SEX INTEGER, SPORTLVL INTEGER, HEIGHT INTEGER, WEIGHT FLOAT, STEPLENGTH INTEGER, PASSWORD TEXT)";
    
    //创建血压计数据表 数据id，用户id，用户名，体重，测量时间，是否上传
    NSString *sqlCreateBloodPressTable = @"CREATE TABLE IF NOT EXISTS BLOODPRESSDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, SYS FLOAT, DIA FLOAT, PULSE FLOAT, TESTTIME TIMESTAMP, ISSEND TEXT)";
    
    //创建血糖仪数据表 数据id，用户id，用户名，体重，测量时间，是否上传
    NSString *sqlCreateBGlucoseTable = @"CREATE TABLE IF NOT EXISTS GLUCOSEDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, GLUCOSE FLOAT, TESTTIME TIMESTAMP, ISSEND TEXT)";
    
    [self createtabel:sqlCreateFatTable];
    [self createtabel:sqlCreateWeightTable];
    [self createtabel:sqlCreateUserTable];
    [self createtabel:sqlCreateBloodPressTable];
    b = [self createtabel:sqlCreateBGlucoseTable];
    
    return b;
}


+(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kSqliteFileName];
}



@end
