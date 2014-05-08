//
//  AnalysisViewController.h
//  HME
//
//  Created by 夏 伟 on 13-12-26.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnalysisViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
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
