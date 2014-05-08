//
//  GlucoseDataCell.m
//  HME
//
//  Created by 夏 伟 on 14-1-7.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "GlucoseDataCell.h"

@implementation GlucoseDataCell
@synthesize testTimeLabel;
@synthesize glucoseButton;
@synthesize glucoseDataLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [glucoseButton setTitle:NSLocalizedString(@"USER_GLUCOSE", nil) forState:UIControlStateNormal];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
