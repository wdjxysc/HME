//
//  ChooseItemViewControllerIphone.m
//  HME
//
//  Created by 夏 伟 on 13-12-20.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "ChooseItemViewControllerIphone.h"
#import "EADSessionController.h"

@interface ChooseItemViewControllerIphone ()

@end

@implementation ChooseItemViewControllerIphone

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_accessoryDidConnect:) name:EAAccessoryDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_accessoryDidDisconnect:) name:EAAccessoryDidDisconnectNotification object:nil];
    [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
    // watch for received data from the accessory
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_sessionDataReceived:) name:EADSessionDataReceivedNotification object:nil];
    
    _eaSessionController = [EADSessionController sharedController];
    _accessoryList = [[NSMutableArray alloc] initWithArray:[[EAAccessoryManager sharedAccessoryManager] connectedAccessories]];
    
    NSLog(@"caonima");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    const char *buf = [[_hexToSendTextField text] UTF8String];
    NSMutableData *data = [NSMutableData data];
    if (buf)
    {
        NSInteger len = strlen(buf);
        
        char singleNumberString[3] = {'\0', '\0', '\0'};
        uint32_t singleNumber = 0;
        for(uint32_t i = 0 ; i < len; i+=2)
        {
            if ( ((i+1) < len) && isxdigit(buf[i]) && (isxdigit(buf[i+1])) )
            {
                singleNumberString[0] = buf[i];
                singleNumberString[1] = buf[i + 1];
                sscanf(singleNumberString, "%x", &singleNumber);
                uint8_t tmp = (uint8_t)(singleNumber & 0x000000FF);
                [data appendBytes:(void *)(&tmp) length:1];
            }
            else
            {
                break;
            }
        }
        
        [[EADSessionController sharedController] writeData:data];
    }
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
