//
//  BodyFatAnalysisViewController_iphone.h
//  HME
//
//  Created by 夏 伟 on 14-2-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BodyFatAnalysisViewController_iphone : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    IBOutlet UITableView *myTableView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *backButton;
    IBOutlet UISegmentedControl *segmentedControl;
}

@property(nonatomic,retain)NSMutableArray *bodyfatdatas;
@property(nonatomic,retain)NSString *nowDataType;
-(IBAction)backBtnPressed:(id)sender;
-(IBAction)segmentedValueChanged:(id)sender;

@end
