//
//  LoginViewController.h
//  HME
//
//  Created by 夏 伟 on 13-12-18.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
}

-(IBAction)loginBtnPressed:(id)sender;

@end
