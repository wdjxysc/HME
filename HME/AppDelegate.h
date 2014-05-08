//
//  AppDelegate.h
//  HME
//
//  Created by 夏 伟 on 13-12-18.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "LoginViewController.h"
#import "ChooseItemViewController_iphone.h"
#import "BodyFatMeasureViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)ViewController  *viewController;
@property (strong,nonatomic)LoginViewController *loginViewController;
@property (strong,nonatomic)ChooseItemViewController_iphone *chooseItemViewController_iphone;
@property (strong,nonatomic)BodyFatMeasureViewController *bodyFatMeasureViewController;
@end
