//
//  MeasureViewController.m
//  HME
//
//  Created by 夏 伟 on 13-12-19.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "MeasureViewController.h"
#import "EADSessionController.h"

@interface MeasureViewController ()

@end

@implementation MeasureViewController


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
    bloodpressureView.frame = CGRectMake(0, 148, 0, 0);
    [self.view addSubview:bloodpressureView];
//    UIButton *getdataButton = [[UIButton init]initWithFrame:CGRectMake(140, 403, 180, 46)];
////    UIButton *getdataButton = [[UIButton init]initWithFrame:CGRectMake(140, 403, 180, 46)];
////    UIButton *getdataButton = [[UIButton init]initWithFrame:CGRectMake(140, 403, 180, 46)];
//    [self.view addSubview:getdataButton];
    [self initMyView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_accessoryDidConnect:) name:EAAccessoryDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_accessoryDidDisconnect:) name:EAAccessoryDidDisconnectNotification object:nil];
    [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
    // watch for received data from the accessory
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_sessionDataReceived:) name:EADSessionDataReceivedNotification object:nil];
    
    _eaSessionController = [EADSessionController sharedController];
    _accessoryList = [[NSMutableArray alloc] initWithArray:[[EAAccessoryManager sharedAccessoryManager] connectedAccessories]];
    
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
    sysLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_SYS", nil)];
    diaLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_DIA", nil)];
    pulseLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"USER_PULSE", nil)];
    sysUnitLabel.text = [NSString stringWithFormat:@"(%@)",NSLocalizedString(@"PRESS_UNIT_MMHG", nil)];
    diaUnitLabel.text = [NSString stringWithFormat:@"(%@)",NSLocalizedString(@"PRESS_UNIT_MMHG", nil)];
    pulseUnitLabel.text = [NSString stringWithFormat:@"(%@)",NSLocalizedString(@"PULSE_UNIT_BPM", nil)];
}


#pragma mark Internal

- (void)_accessoryDidConnect:(NSNotification *)notification
{
    EAAccessory *connectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];
    NSUInteger i = connectedAccessory.connectionID;
    NSString *s = connectedAccessory.name;
    NSLog(@"%d",(int)i);
    NSLog(@"%@",s);
    [_accessoryList addObject:connectedAccessory];
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
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:disconnectedAccessoryIndex inSection:0];
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
    NSLog(@"pressed");
    for(int i=0;i<_accessoryList.count;i++)
    {
        if([[[_accessoryList objectAtIndex:i] name] isEqualToString:@"TD_MFI_BT"])
        {
            EADSessionController *sessionController = [EADSessionController sharedController];
            
            [sessionController setupControllerForAccessory:[_accessoryList objectAtIndex:i] withProtocolString:@"com.taidoc.taidocbus.bp"];
            [self setTitle:[sessionController protocolString]];
            [sessionController openSession];
        }
    }
    
    Byte byte[] = {0x51,0x26,0x00,0x00,0x00 ,0x00,0xa3,0x1a};
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
    
    while ((bytesAvailable = [sessionController readBytesAvailable]) > 0) {
        NSData *data = [sessionController readData:bytesAvailable];
        Byte *databyte = (Byte *)[data bytes];
        for(int i = 0;i < data.length;i++)
        {
            NSLog(@"%d",databyte[i]);
        }
        NSLog(@"%@",data);
        if (data) {
            _totalBytesRead += bytesAvailable;
        }
    }
    
    NSLog(@"Bytes Received from Session: %d",_totalBytesRead);
}

@end
