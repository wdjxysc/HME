//
//  LoginViewController.m
//  HME
//
//  Created by 夏 伟 on 13-12-18.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "LoginViewController.h"
#import "ChooseItemViewController.h"
#import "database.h"
#import "MySingleton.h"
#import "ServerConnect.h"
#import "EoceneServerConnect.h"
#import "SVProgressHUD.h"
#import "XmlTool.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //建表
    [database initDataBase];
    
    //创建单例变量
    [self initApp];
    
    [self initMyView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginBtnPressed:(id)sender
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"PLEASEWAITTING", nil)];
    loginBtn.enabled = false;
    
    NSThread* myThread1 = [[NSThread alloc] initWithTarget:self selector:@selector(login)object:nil];
    [myThread1 start];
}

-(void)login
{
    bool b = false;
    
    NSString *username = usernameTextField.text;
    NSString *password = passwordTextField.text;
    
    NSDictionary *regResultDic = [[NSDictionary alloc]init];
    if([username isEqualToString:@""]||[password isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@""];
        loginBtn.enabled = true;
        return;
    }
    else
    {
        NSString *regxml = [EoceneServerConnect getRegXml:username password:password];
        NSString *regurl = [[NSString alloc]initWithFormat:@"https://ws.eocenesystems.com/cnsappreg.cfc"];
        NSString *revstr = [EoceneServerConnect callXMLWebService:regxml urlString:regurl];
        
        XmlTool *myxmltool = [[XmlTool alloc]init];
        [myxmltool testXMLParse:revstr];
        regResultDic = myxmltool.myDataMutableDictionary;
        
        if([[regResultDic valueForKey:@"Success"] isEqualToString:@"true"])
        {
            b = true;
            [[MySingleton sharedSingleton].nowuserinfo setValue:[regResultDic valueForKey:@"AccountID"] forKey:@"AccountID"];
            [[MySingleton sharedSingleton].nowuserinfo setValue:[regResultDic valueForKey:@"AccountName"] forKey:@"AccountName"];
            [[MySingleton sharedSingleton].nowuserinfo setValue:[regResultDic valueForKey:@"RegID"] forKey:@"RegID"];
        }
        
//        bool b = [EoceneServerConnect uploadBloodPressData:123 dia:87 pulse:65 testtime:[NSDate date]];
//        b = [EoceneServerConnect uploadGlucoseData:34 testtime:[NSDate date]];
//        b = [EoceneServerConnect uploadOxygenData:54 pulse:34 testtime:[NSDate date]];
    }
    
    
    if(b == true){ //登陆成功
        
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"LOGIN_SUCCESS", nil)];
        loginBtn.enabled = true;
        
        NSDictionary *dic = [database selectUserByName:username];
        if(dic == nil){
            NSString *sql2 = [NSString stringWithFormat:
                              @"INSERT INTO 'USER' ('USERNAME', 'PASSWORD') VALUES ('%@','%@')", username,password];
            
            [database insert:sql2];
        }
        [[MySingleton sharedSingleton].nowuserinfo setValue:username forKey:@"UserName"];
        [[MySingleton sharedSingleton].nowuserinfo setValue:password forKey:@"PassWord"];
        
        NSString *s = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
        NSLog(@"用户成功登陆：%@",s);
        
        ChooseItemViewController *chooseItemViewController = [[ChooseItemViewController alloc]initWithNibName:@"ChooseItemViewController" bundle:nil];
        [self presentViewController:chooseItemViewController animated:NO completion:^{//备注2
            NSLog(@"show InfoView!");
        }];
        
    }
    else{
        
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"LOGIN_FAILED", nil)];
        loginBtn.enabled = true;
        return;
    }

}

/*  服务网登陆
-(IBAction)LoginBtnPressed:(id)sender
{
    
    
    NSString *username = usernameTextField.text;
    NSString *password = passwordTextField.text;
    NSString *urlLogin = [[NSString alloc]initWithFormat:@"http://www.ebelter.com/service/ehealth_userLogin?username=%@&pwd=%@&dtype=30",username,password];
    
    NSString *res = [ServerConnect Login:urlLogin];
    if([res isEqualToString:@"0"])
    {
        //登陆成功
        
        //获取用户信息
        NSString *urlGetUserInfo = [[NSString alloc]initWithFormat:@"http://www.ebelter.com/service/ehealth_getUserInfo?authkey=%@&time=2013-11-26 15:53:30",[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"]];
        
        NSDictionary *dic = [ServerConnect getUserInfo:urlGetUserInfo];
        NSLog(@"dic = %@",dic);
        
    }
}
*/

-(void)initMyView
{
    usernameLabel.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"LOGINLABEL_USERNAME", nil)];
    passwordLabel.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"LOGINLABEL_PASSWORD", nil)];
    remenberLabel.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"LOGINBUTTON_REMENBER", nil)];
    
    [loginBtn setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"LOGINBUTTON_OK", nil)] forState:UIControlStateNormal];
    [registBtn setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"LOGINBUTTON_REGISTER", nil)] forState:UIControlStateNormal];
    [loginBtn setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"LOGINBUTTON_OK", nil)] forState:UIControlStateSelected];
    [registBtn setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"LOGINBUTTON_REGISTER", nil)] forState:UIControlStateSelected];
    
}


-(void)initApp
{
    [MySingleton sharedSingleton].nowuserinfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                 [[NSString alloc] initWithFormat:@""],@"Userid",
                                                 [[NSString alloc] initWithFormat:@""],@"UserNumber",
                                                 [[NSString alloc] initWithFormat:@""],@"UserName",
                                                 [[NSString alloc] initWithFormat:@""],@"PassWord",
                                                 [[NSString alloc] initWithFormat:@""],@"Weight",
                                                 [[NSString alloc] initWithFormat:@""],@"Birthday",
                                                 [[NSString alloc] initWithFormat:@""],@"Gender",
                                                 [[NSString alloc] initWithFormat:@""],@"Height",
                                                 [[NSString alloc] initWithFormat:@""],@"Profesion",
                                                 [[NSString alloc] initWithFormat:@""],@"AuthKey",
                                                 [[NSString alloc] initWithFormat:@""],@"Age",
                                                 [[NSString alloc] initWithFormat:@""],@"StepSize",
                                                 nil];
    
    NSLog(@"MySingleton AuthKey = %@", [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"]);
}

@end
