//
//  MeasureViewController.h
//  HME
//
//  Created by 夏 伟 on 13-12-19.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "EADSessionController.h"

@interface MeasureViewController : UIViewController<EAAccessoryDelegate>
{
    NSMutableArray *_accessoryList;
    
    EAAccessory *_selectedAccessory;
    EADSessionController *_eaSessionController;
    
    EAAccessory *_accessory;
    
    uint32_t _totalBytesRead;
    
    IBOutlet UIButton *backBtn;
    
    IBOutlet UIView *bloodpressureView;
    
    IBOutlet UILabel *testtimeLabel;
    IBOutlet UILabel *testtimeDataLabel;
    IBOutlet UIButton *getdataBtn;
    IBOutlet UIButton *adviceBtn;
    IBOutlet UIButton *analysisBtn;
    
    
    IBOutlet UILabel *sysLabel;
    IBOutlet UILabel *diaLabel;
    IBOutlet UILabel *pulseLabel;
    IBOutlet UILabel *sysDataLabel;
    IBOutlet UILabel *diaDataLabel;
    IBOutlet UILabel *pulseDataLabel;
    IBOutlet UILabel *sysUnitLabel;
    IBOutlet UILabel *diaUnitLabel;
    IBOutlet UILabel *pulseUnitLabel;
}

-(IBAction)backbtnPressed:(id)sender;
-(IBAction)analysisBtnPressed:(id)sender;

@property(nonatomic,retain)EADSessionController *bloodpressEADSessionController;

@end
