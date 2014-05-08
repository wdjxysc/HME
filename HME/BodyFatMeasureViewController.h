//
//  BodyFatMeasureViewController.h
//  HME
//
//  Created by 夏 伟 on 14-1-7.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "EADSessionController.h"

@interface BodyFatMeasureViewController : UIViewController<EAAccessoryDelegate>
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
    
    
    IBOutlet UILabel *weightLabel;
    IBOutlet UILabel *fatLabel;
    IBOutlet UILabel *waterLabel;
    IBOutlet UILabel *muscleLabel;
    IBOutlet UILabel *boneLabel;
    IBOutlet UILabel *bmiLabel;
    IBOutlet UILabel *bmrLabel;
    
    IBOutlet UILabel *weightDataLabel;
    IBOutlet UILabel *fatDataLabel;
    IBOutlet UILabel *waterDataLabel;
    IBOutlet UILabel *muscleDataLabel;
    IBOutlet UILabel *boneDataLabel;
    IBOutlet UILabel *bmiDataLabel;
    IBOutlet UILabel *bmrDataLabel;
    
    IBOutlet UILabel *weightUnitLabel;
    IBOutlet UILabel *fatUnitLabel;
    IBOutlet UILabel *waterUnitLabel;
    IBOutlet UILabel *muscleUnitLabel;
    IBOutlet UILabel *boneUnitLabel;
    IBOutlet UILabel *bmiUnitLabel;
    IBOutlet UILabel *bmrUnitLabel;
}

-(IBAction)backbtnPressed:(id)sender;
-(IBAction)analysisBtnPressed:(id)sender;

@property(nonatomic,retain)EADSessionController *bodyfatEADSessionController;
@end
