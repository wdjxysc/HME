//
//  BloodPressDataCell.h
//  HME
//
//  Created by 夏 伟 on 13-12-26.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BloodPressDataCell : UITableViewCell
{
    IBOutlet UILabel *testTimeLabel;
    
    IBOutlet UILabel *sysDataLabel;
    IBOutlet UILabel *diaDataLabel;
    IBOutlet UILabel *pulseDataLabel;
    
    IBOutlet UIButton *sysButton;
    IBOutlet UIButton *diaButton;
    IBOutlet UIButton *pulseButton;
}
@property(nonatomic,retain)UILabel  *testTimeLabel;

@property(nonatomic,retain)UILabel  *sysDataLabel;
@property(nonatomic,retain)UILabel  *diaDataLabel;
@property(nonatomic,retain)UILabel  *pulseDataLabel;

@property(nonatomic,retain)UIButton *sysButton;
@property(nonatomic,retain)UIButton *diaButton;
@property(nonatomic,retain)UIButton *pulseButton;

@end
