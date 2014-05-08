//
//  GlucoseAnalysisViewController.h
//  HME
//
//  Created by 夏 伟 on 14-1-7.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlucoseAnalysisViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    IBOutlet UITableView *myTableView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *backButton;
}

@property(nonatomic,retain)NSMutableArray *glucoseDatas;
@property(nonatomic,retain)NSString *nowDataType;
-(IBAction)backBtnPressed:(id)sender;

@end
