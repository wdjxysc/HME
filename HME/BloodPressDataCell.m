//
//  BloodPressDataCell.m
//  HME
//
//  Created by 夏 伟 on 13-12-26.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "BloodPressDataCell.h"

@implementation BloodPressDataCell
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
