//
//  BloodPressAnalysisViewController.h
//  HME
//
//  Created by 夏 伟 on 14-2-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BloodPressAnalysisViewController_iphone : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    IBOutlet UITableView *myTableView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *pulseButton;
    IBOutlet UIButton *bloodpressButton;
}

@property(nonatomic,retain)NSMutableArray *weightDatas;
@property(nonatomic,retain)NSMutableArray *bodyFatDatas;
@property(nonatomic,retain)NSMutableArray *bloodPressDatas;
@property(nonatomic,retain)NSString *nowDataType;
-(IBAction)pulseBtnPressed:(id)sender;
-(IBAction)bloodpressBtnPressed:(id)sender;
-(IBAction)backBtnPressed:(id)sender;

@end
