//
//  GlucoseMeasureViewController_iphone.m
//  HME
//
//  Created by 夏 伟 on 14-2-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "GlucoseMeasureViewController_iphone.h"
#import "GlucoseAnalysisViewController_iphone.h"
#import "EADSessionController.h"
#import "database.h"
#import "MySingleton.h"
#import "EoceneServerConnect.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface GlucoseMeasureViewController_iphone ()

@end

@implementation GlucoseMeasureViewController_iphone

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
    //加载界面元素
    
    [self initMyView];
    
    [super viewDidLoad];
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
    glucoseLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_GLUCOSE", nil)];
    glucoseUnitLabel.text = [NSString stringWithFormat:@"(%@)",NSLocalizedString(@"GLUCOSE_UNIT_MGDL", nil)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backbtnPressed:(id)sender
{
    //返回上一视图
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)analysisBtnPressed:(id)sender
{
    //适配4Inch屏幕
    NSString *nibName = @"GlucoseAnalysisViewController_iphone";
    if(iPhone5)
    {
        nibName = @"GlucoseAnalysisViewController_iphone_4Inch";
    }
    GlucoseAnalysisViewController_iphone *glucoseAnalysisViewController_iphone = [[GlucoseAnalysisViewController_iphone alloc]initWithNibName:nibName bundle:nil];
    [self presentViewController:glucoseAnalysisViewController_iphone animated:NO completion:^{
        NSLog(@"跳转图表页面");
    }];
}

#pragma mark Internal

- (void)_accessoryDidConnect:(NSNotification *)notification
{
    EAAccessory *connectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];
    NSUInteger i = connectedAccessory.connectionID;
    NSLog(@"%d",(int)i);
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
    
    for(int i=0;i<_accessoryList.count;i++)
    {
        if([[[_accessoryList objectAtIndex:i] name] isEqualToString:@"TD_MFI_BT"])
        {
            self.glucoseEADSessionController = [EADSessionController sharedController];
            
            [self.glucoseEADSessionController setupControllerForAccessory:[_accessoryList objectAtIndex:i] withProtocolString:@"com.taidoc.taidocbus"];
            [self setTitle:[self.glucoseEADSessionController protocolString]];
            [self.glucoseEADSessionController openSession];
        }
    }
    
    Byte byte[] = {0x51, 0x26, 0x00, 0x00, 0x00, 0x00, 0xa3, 0x1a};
    NSData *data = [[NSData alloc] initWithBytes:byte length:24];
    [[EADSessionController sharedController] writeData:data];
}

// Data was received from the accessory, real apps should do something with this data but currently:
//    1. bytes counter is incremented
//    2. bytes are read from the session controller and thrown away
- (void)_sessionDataReceived:(NSNotification *)notification
{
    EADSessionController *sessionController = (EADSessionController *)[notification object];
    NSInteger bytesAvailable = 0;
    
    double glucosedata = 0;
    while ((bytesAvailable = [sessionController readBytesAvailable]) > 0) {
        NSData *data = [sessionController readData:bytesAvailable];
        Byte *databyte = (Byte *)[data bytes];
        for(int i = 0;i < data.length;i++)
        {
            NSLog(@"%d",databyte[i]);
        }
        
        glucosedata = databyte[3]*256 + databyte[2];
        NSLog(@"%@",data);
        if (data) {
            _totalBytesRead += bytesAvailable;
        }
    }
    
    glucoseDataLabel.text = [[NSString alloc]initWithFormat:@"%.0f",glucosedata];
    if(glucosedata != 0){
        [self insertData:glucosedata];
    }
    
    [self.glucoseEADSessionController closeSession];
    NSLog(@"Bytes Received from Session: %d",_totalBytesRead);
}

-(void)insertData :(double)glucosedata
{
    NSString *username = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date =[NSDate date];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSString *issendstr = @"N";
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO 'GLUCOSEDATA' ('USERNAME','GLUCOSE', 'TESTTIME', 'ISSEND') VALUES ('%@','%f','%@','%@')", username, glucosedata, strDate, issendstr];
    [database insert:sql];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         [[NSString alloc]initWithFormat:@"%f",glucosedata],@"Glucose",
                         date,@"TESTTIME",
                         nil];
    
    NSThread *thr = [[NSThread alloc]initWithTarget:self selector:@selector(threadUploadData:) object:dic];
    [thr start];
}

-(void)threadUploadData:(id)object
{
    NSDictionary *dic = (NSDictionary *)object;
    int glucose = [[dic valueForKey:@"Glucose"] intValue];
    NSDate *date =[dic valueForKey:@"TESTTIME"];
    
    [EoceneServerConnect uploadGlucoseData:glucose testtime:date];
}

@end
