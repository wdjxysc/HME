//
//  BloodPressDataCell_iphone.m
//  HME
//
//  Created by 夏 伟 on 14-2-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "BloodPressDataCell_iphone.h"

@implementation BloodPressDataCell_iphone
@synthesize testTimeLabel;
@synthesize sysDataLabel;
@synthesize diaDataLabel;
@synthesize pulseDataLabel;

@synthesize sysButton;
@synthesize diaButton;
@synthesize pulseButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [sysButton setTitle:NSLocalizedString(@"USER_SYS", nil) forState:UIControlStateNormal];
        [diaButton setTitle:NSLocalizedString(@"USER_DIA", nil) forState:UIControlStateNormal];
        [pulseButton setTitle:NSLocalizedString(@"USER_PULSE", nil) forState:UIControlStateNormal];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
