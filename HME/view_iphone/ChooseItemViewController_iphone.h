//
//  ChooseItemViewController_iphone.h
//  HME
//
//  Created by 夏 伟 on 14-2-10.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseItemViewController_iphone : UIViewController
{
    IBOutlet UIButton *weightBtn;
    IBOutlet UIButton *fatBtn;
    IBOutlet UIButton *bloodpressureBtn;
    IBOutlet UIButton *glucoseBtn;
    IBOutlet UIButton *oxygenBtn;
    IBOutlet UIButton *confirmBtn;
    
    IBOutlet UISwitch *weightSwitch;
    IBOutlet UISwitch *fatSwitch;
    IBOutlet UISwitch *bloodpressureSwitch;
    IBOutlet UISwitch *glucoseSwitch;
    IBOutlet UISwitch *oxygenSwitch;
    
    IBOutlet UILabel *weightLabel;
    IBOutlet UILabel *fatLabel;
    IBOutlet UILabel *bloodpressureLabel;
    IBOutlet UILabel *glucoseLabel;
    IBOutlet UILabel *oxygenLabel;
}

-(IBAction)weightBtnPressed:(id)sender;
-(IBAction)fatBtnPressed:(id)sender;
-(IBAction)bloodpressureBtnPressed:(id)sender;
-(IBAction)glucoseBtnPressed:(id)sender;
-(IBAction)oxygenBtnPressed:(id)sender;

-(IBAction)weightSwitchPressed:(id)sender;
-(IBAction)fatSwitchPressed:(id)sender;
-(IBAction)bloodpressureSwitchPressed:(id)sender;
-(IBAction)glucoseSwitchPressed:(id)sender;
-(IBAction)oxygenSwitchPressed:(id)sender;

-(IBAction)sureBtnPressed:(id)sender;

-(IBAction)showGlucoseView:(id)sender;

-(IBAction)showBodyfatView:(id)sender;

-(IBAction)showBloodPressView:(id)sender;

@end
