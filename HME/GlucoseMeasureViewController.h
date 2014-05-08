//
//  GlucoseMeasureViewController.h
//  HME
//
//  Created by 夏 伟 on 14-1-7.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "EADSessionController.h"

@interface GlucoseMeasureViewController : UIViewController<EAAccessoryDelegate>
{
    NSMutableArray *_accessoryList;
    
    EAAccessory *_selectedAccessory;
    EADSessionController *_eaSessionController;
    
    EAAccessory *_accessory;
    
    uint32_t _totalBytesRead;
    
    IBOutlet UIButton *backBtn;
    
    IBOutlet UILabel *testtimeLabel;
    IBOutlet UILabel *testtimeDataLabel;
    IBOutlet UIButton *getdataBtn;
    IBOutlet UIButton *adviceBtn;
    IBOutlet UIButton *analysisBtn;
    
    
    IBOutlet UILabel *glucoseLabel;
    IBOutlet UILabel *glucoseDataLabel;
    IBOutlet UILabel *glucoseUnitLabel;
}

-(IBAction)backbtnPressed:(id)sender;
-(IBAction)analysisBtnPressed:(id)sender;

@property(nonatomic,retain)EADSessionController *glucoseEADSessionController;
@end
