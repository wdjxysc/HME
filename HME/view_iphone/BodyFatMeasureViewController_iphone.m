//
//  BodyFatMeasureViewController_iphone.m
//  HME
//
//  Created by 夏 伟 on 14-2-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "BodyFatMeasureViewController_iphone.h"
#import "BodyFatAnalysisViewController_iphone.h"
#import "EADSessionController.h"
#import "database.h"
#import "MySingleton.h"
#import "EoceneServerConnect.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface BodyFatMeasureViewController_iphone ()

@end

@implementation BodyFatMeasureViewController_iphone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self initMyView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMyView
{
    [backBtn setTitle:[NSString stringWithFormat:@"  %@",NSLocalizedString(@"BACK", nil)] forState:UIControlStateNormal];
    
    testtimeLabel.text = NSLocalizedString(@"TEST_TIME", nil);
    NSDate *date = [[NSDate alloc]init];
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    testtimeDataLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    
    [getdataBtn setTitle:[NSString stringWithFormat:@"  %@",NSLocalizedString(@"GET_DATA", nil)] forState:UIControlStateNormal];
    [adviceBtn setTitle:[NSString stringWithFormat:@"  %@",NSLocalizedString(@"REPORT", nil)] forState:UIControlStateNormal];
    [analysisBtn setTitle:[NSString stringWithFormat:@"  %@",NSLocalizedString(@"ANALYZE", nil)] forState:UIControlStateNormal];
    
    weightLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_WEIGHT", nil)];
    fatLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_FAT", nil)];
    waterLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_WATER", nil)];
    muscleLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_MUSCLE", nil)];
    boneLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_BONE", nil)];
    bmiLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_BMI", nil)];
    bmrLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_BMR", nil)];
    
    weightUnitLabel.text = [NSString stringWithFormat:@"(%@)",NSLocalizedString(@"WEIGHT_UNIT_KG", nil)];
}

-(void)backbtnPressed:(id)sender
{
    //返回上一视图
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)analysisBtnPressed:(id)sender
{
    //适配4Inch屏幕
    NSString *nibName = @"BodyFatAnalysisViewController_iphone";
    if(iPhone5)
    {
        nibName = @"BodyFatAnalysisViewController_iphone_4Inch";
    }
    BodyFatAnalysisViewController_iphone *bodyFatAnalysisViewController_iphone = [[BodyFatAnalysisViewController_iphone alloc]initWithNibName:nibName bundle:nil];
    [self presentViewController:bodyFatAnalysisViewController_iphone animated:NO completion:^{
        NSLog(@"跳转图表页面");
    }];
}

#pragma mark Internal

- (void)_accessoryDidConnect:(NSNotification *)notification
{
    EAAccessory *connectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];
    NSUInteger i = connectedAccessory.connectionID;
    NSLog(@"%lu",(unsigned long)i);
}

- (void)_accessoryDidDisconnect:(NSNotification *)notification
{
    EAAccessory *disconnectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];
    
    if (_selectedAccessory && [disconnectedAccessory connectionID] == [_selectedAccessory connectionID])
    {
        //        [_protocolSelectionActionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    }
    
    int disconnectedAccessoryIndex = 0;
    for(EAAccessory *accessory in _accessoryList) {
        if ([disconnectedAccessory connectionID] == [accessory connectionID]) {
            break;
        }
        disconnectedAccessoryIndex++;
    }
    
    if (disconnectedAccessoryIndex < [_accessoryList count]) {
        [_accessoryList removeObjectAtIndex:disconnectedAccessoryIndex];
        //        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:disconnectedAccessoryIndex inSection:0];
        //        [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
	} else {
        NSLog(@"could not find disconnected accessory in accessory list");
    }
    
    if ([_accessoryList count] == 0) {
        //        [_noExternalAccessoriesPosterView setHidden:NO];
    } else {
        //        [_noExternalAccessoriesPosterView setHidden:YES];
    }
}

-(IBAction)getdataBtnPressed:(id)sender
{
    //    [self insertData:255 diadata:120 pulsedata:90];
    
    
    //清除，重新扫描
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EAAccessoryDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EAAccessoryDidDisconnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EADSessionDataReceivedNotification object:nil];
    _accessoryList = nil;
    _selectedAccessory = nil;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_accessoryDidConnect:) name:EAAccessoryDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_accessoryDidDisconnect:) name:EAAccessoryDidDisconnectNotification object:nil];
    [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
    // watch for received data from the accessory
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_sessionDataReceived:) name:EADSessionDataReceivedNotification object:nil];
    _eaSessionController = [EADSessionController sharedController];
    _accessoryList = [[NSMutableArray alloc] initWithArray:[[EAAccessoryManager sharedAccessoryManager] connectedAccessories]];
    
    
    NSLog(@"pressed");
    for(int i=0;i<_accessoryList.count;i++)
    {
        if([[[_accessoryList objectAtIndex:i] name] isEqualToString:@"TD_MFI_BT"])
        {
            self.bodyfatEADSessionController = [EADSessionController sharedController];
            
            [self.bodyfatEADSessionController setupControllerForAccessory:[_accessoryList objectAtIndex:i] withProtocolString:@"com.foracare.taidocbus.ws"];
            [self setTitle:[self.bodyfatEADSessionController protocolString]];
            [self.bodyfatEADSessionController openSession];
        }
    }
    
    Byte byte[] = {0x51,0x71,0x02,0x00,0x01 ,0xa3,0x68};
    NSData *data = [[NSData alloc] initWithBytes:byte length:24];
    [[EADSessionController sharedController] writeData:data];
    
    //    const char *buf = [[_hexToSendTextField text] UTF8String];
    //    NSMutableData *data = [NSMutableData data];
    //    if (buf)
    //    {
    //        NSInteger len = strlen(buf);
    //
    //        char singleNumberString[3] = {'\0', '\0', '\0'};
    //        uint32_t singleNumber = 0;
    //        for(uint32_t i = 0 ; i < len; i+=2)
    //        {
    //            if ( ((i+1) < len) && isxdigit(buf[i]) && (isxdigit(buf[i+1])) )
    //            {
    //                singleNumberString[0] = buf[i];
    //                singleNumberString[1] = buf[i + 1];
    //                sscanf(singleNumberString, "%x", &singleNumber);
    //                uint8_t tmp = (uint8_t)(singleNumber & 0x000000FF);
    //                [data appendBytes:(void *)(&tmp) length:1];
    //            }
    //            else
    //            {
    //                break;
    //            }
    //        }
    //
    //        [[EADSessionController sharedController] writeData:data];
    //    }
}

// Data was received from the accessory, real apps should do something with this data but currently:
//    1. bytes counter is incremented
//    2. bytes are read from the session controller and thrown away
- (void)_sessionDataReceived:(NSNotification *)notification
{
    EADSessionController *sessionController = (EADSessionController *)[notification object];
    NSInteger bytesAvailable = 0;
    
    double weightdata = 0;
    double fatdata = 0;
    double waterdata = 0;
    double muscledata = 0;
    double bonedata = 0;
    int bmidata = 0;
    int bmrdata = 0;
    int gender = 0;
    int age = 0;
    int height = 0;
    
    while ((bytesAvailable = [sessionController readBytesAvailable]) > 0) {
        NSData *data = [sessionController readData:bytesAvailable];
        Byte *databyte = (Byte *)[data bytes];
        for(int i = 0;i < data.length;i++)
        {
            NSLog(@"%d",databyte[i]);
        }
        
        weightdata = (databyte[16] * 256 +databyte[17])/10.0f;
        fatdata = (databyte[24] * 256 +databyte[26])/10.0f;
        waterdata = (databyte[29] * 256 +databyte[30])/10.0f;
        muscledata = (databyte[26] * 256 +databyte[27])/10.0f;
        bonedata = databyte[28]/10.0f;
        bmidata = (databyte[20] * 256 +databyte[21])/10.0f;
        bmrdata = databyte[22] * 256 +databyte[23];
        gender = databyte[10];
        height = databyte[11];
        age = databyte[14];
        
        
        NSLog(@"%@",data);
        if (data) {
            _totalBytesRead += bytesAvailable;
        }
    }
    
    weightDataLabel.text = [[NSString alloc]initWithFormat:@"%.1f",weightdata];
    fatDataLabel.text = [[NSString alloc]initWithFormat:@"%.1f",fatdata];
    waterDataLabel.text = [[NSString alloc]initWithFormat:@"%.1f",waterdata];
    muscleDataLabel.text = [[NSString alloc]initWithFormat:@"%.1f",muscledata];
    boneDataLabel.text = [[NSString alloc]initWithFormat:@"%.1f",bonedata];
    bmiDataLabel.text = [[NSString alloc]initWithFormat:@"%d",bmidata];
    bmrDataLabel.text = [[NSString alloc]initWithFormat:@"%d",bmrdata];
    
    if(weightdata != 0){
        [self insertData:weightdata fat:fatdata water:waterdata muscle:muscledata bone:bonedata bmi:bmidata bmr:bmrdata visceralfat:1 age:age sex:gender sportlvl:0 height:height];
    }
    
    [self.bodyfatEADSessionController closeSession];
    
    NSLog(@"Bytes Received from Session: %d",_totalBytesRead);
}

-(void)insertData :(double)weight fat:(double)fat water:(double)water muscle:(double)muscle bone:(double)bone bmi:(double)bmi bmr:(int)bmr visceralfat:(int)visceralfat age:(int)age sex:(int)sex sportlvl:(int)sportlvl height:(int)height
{
    NSString *username = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString *issendstr = @"N";
    float version = 1.0f;
    
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO 'BODYFATDATA' ( 'USERNAME', 'AGE', 'SEX', 'SPORTLVL', 'HEIGHT', 'WEIGHT', 'BODYFAT', 'VISCERALFAT', 'WATER', 'BONE', 'MUSCLE', 'BMR', 'BMI', 'TESTTIME', 'VERSION', 'ISSEND') VALUES ('%@', '%d', '%d', '%d', '%d', '%f', '%f', '%d', '%f', '%f', '%f', '%d', '%f', '%@', '%f', '%@')",username, age, sex, sportlvl, height, weight, fat, visceralfat, water, bone, muscle, bmr, bmi, strDate, version, issendstr];
    
    [database insert:sql];
}


-(void)threadUploadData:(id)object
{
    NSDictionary *dic = (NSDictionary *)object;
    int sys = [[dic valueForKey:@"SYS"] intValue];
    int dia = [[dic valueForKey:@"DIA"] intValue];
    int pulse = [[dic valueForKey:@"Pulse"] intValue];
    NSDate *date =[dic valueForKey:@"TESTTIME"];
    
    [EoceneServerConnect uploadBloodPressData:sys dia:dia pulse:pulse testtime:date];
}

@end
