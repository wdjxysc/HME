//
//  LoginViewController.h
//  HME
//
//  Created by 夏 伟 on 13-12-18.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
//Ilv327814

@interface ViewController : UIViewController
{
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UILabel *usernameLabel;
    IBOutlet UILabel *passwordLabel;
    IBOutlet UILabel *remenberLabel;
    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *registBtn;
}

-(IBAction)loginBtnPressed:(id)sender;

@end
