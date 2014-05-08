//
//  GlucoseDataCell_iphone.h
//  HME
//
//  Created by 夏 伟 on 14-2-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlucoseDataCell_iphone : UITableViewCell
{
    IBOutlet UILabel *testTimeLabel;
    
    IBOutlet UILabel *glucoseDataLabel;
    
    IBOutlet UIButton *glucoseButton;
}
@property(nonatomic,retain)UILabel  *testTimeLabel;

@property(nonatomic,retain)UILabel  *glucoseDataLabel;

@property(nonatomic,retain)UIButton *glucoseButton;

@end
