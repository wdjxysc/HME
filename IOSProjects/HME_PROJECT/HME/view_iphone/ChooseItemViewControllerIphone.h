//
//  ChooseItemViewControllerIphone.h
//  HME
//
//  Created by 夏 伟 on 13-12-20.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "EADSessionController.h"

@interface ChooseItemViewControllerIphone : UIViewController<EAAccessoryDelegate>
{
    NSMutableArray *_accessoryList;
    
    EAAccessory *_selectedAccessory;
    EADSessionController *_eaSessionController;
    
    EAAccessory *_accessory;
    
    uint32_t _totalBytesRead;
    
    IBOutlet UITextField *_hexToSendTextField;
    IBOutlet UIButton *button;
}

-(IBAction)getdataBtnPressed:(id)sender;
@end
