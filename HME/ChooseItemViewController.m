//
//  ChooseItemViewController.m
//  HME
//
//  Created by 夏 伟 on 13-12-18.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "ChooseItemViewController.h"
#import "MeasureViewController.h"
#import "GlucoseMeasureViewController.h"
#import "BodyFatMeasureViewController.h"

@interface ChooseItemViewController ()

@end

@implementation ChooseItemViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMyView
{
    weightLabel.text = NSLocalizedString(@"MEASURE_TYPE_WEIGHT", nil);
    fatLabel.text = NSLocalizedString(@"MEASURE_TYPE_BODYFAT", nil);
    bloodpressureLabel.text = NSLocalizedString(@"MEASURE_TYPE_BLOODPRESSURE", nil);
    glucoseLabel.text = NSLocalizedString(@"MEASURE_TYPE_GLUCOSE", nil);
    oxygenLabel.text = NSLocalizedString(@"MEASURE_TYPE_OXYGEN", nil);
    
    
    [confirmBtn setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"CONFIRM", nil)] forState:UIControlStateNormal];
}

-(IBAction)weightBtnPressed:(id)sender
{
    if(weightSwitch.isOn){
        [weightSwitch setOn:NO animated:YES];
        [weightBtn setBackgroundImage:[UIImage imageNamed:@"weight"] forState:UIControlStateNormal];
    }
    else{
        [weightSwitch setOn:YES animated:YES];
        [weightBtn setBackgroundImage:[UIImage imageNamed:@"hme01"] forState:UIControlStateNormal];
    }
}

-(IBAction)fatBtnPressed:(id)sender
{
    if(fatSwitch.isOn){
        [fatSwitch setOn:NO animated:YES];
        [fatBtn setBackgroundImage:[UIImage imageNamed:@"body"] forState:UIControlStateNormal];
    }
    else{
        [fatSwitch setOn:YES animated:YES];
        [fatBtn setBackgroundImage:[UIImage imageNamed:@"hme02"] forState:UIControlStateNormal];
    }
}

-(IBAction)bloodpressureBtnPressed:(id)sender
{
    if(bloodpressureSwitch.isOn){
        [bloodpressureSwitch setOn:NO animated:YES];
        [bloodpressureBtn setBackgroundImage:[UIImage imageNamed:@"pressure"] forState:UIControlStateNormal];
    }
    else{
        [bloodpressureSwitch setOn:YES animated:YES];
        [bloodpressureBtn setBackgroundImage:[UIImage imageNamed:@"hme03"] forState:UIControlStateNormal];
    }
}

-(IBAction)glucoseBtnPressed:(id)sender
{
    if(glucoseSwitch.isOn){
        [glucoseSwitch setOn:NO animated:YES];
        [glucoseBtn setBackgroundImage:[UIImage imageNamed:@"sugar"] forState:UIControlStateNormal];
    }
    else{
        [glucoseSwitch setOn:YES animated:YES];
        [glucoseBtn setBackgroundImage:[UIImage imageNamed:@"hme04"] forState:UIControlStateNormal];
    }
}


-(IBAction)oxygenBtnPressed:(id)sender
{
    if(oxygenSwitch.isOn){
        [oxygenSwitch setOn:NO animated:YES];
        [oxygenBtn setBackgroundImage:[UIImage imageNamed:@"oxygen"] forState:UIControlStateNormal];
    }
    else{
        [oxygenSwitch setOn:YES animated:YES];
        [oxygenBtn setBackgroundImage:[UIImage imageNamed:@"hme05"] forState:UIControlStateNormal];
    }
}

-(IBAction)weightSwitchPressed:(id)sender
{
    if(weightSwitch.isOn){
        [weightBtn setBackgroundImage:[UIImage imageNamed:@"hme01"] forState:UIControlStateNormal];
    }
    else{
        [weightBtn setBackgroundImage:[UIImage imageNamed:@"weight"] forState:UIControlStateNormal];
    }
}

-(IBAction)fatSwitchPressed:(id)sender
{
    if(fatSwitch.isOn){
        [fatBtn setBackgroundImage:[UIImage imageNamed:@"hme02"] forState:UIControlStateNormal];
    }
    else{
        [fatBtn setBackgroundImage:[UIImage imageNamed:@"body"] forState:UIControlStateNormal];
    }
}

-(IBAction)bloodpressureSwitchPressed:(id)sender
{
    if(bloodpressureSwitch.isOn){
        [bloodpressureBtn setBackgroundImage:[UIImage imageNamed:@"hme03"] forState:UIControlStateNormal];
    }
    else{
        [bloodpressureBtn setBackgroundImage:[UIImage imageNamed:@"pressure"] forState:UIControlStateNormal];
    }
}

-(IBAction)glucoseSwitchPressed:(id)sender
{
    if(glucoseSwitch.isOn){
        [glucoseBtn setBackgroundImage:[UIImage imageNamed:@"hme04"] forState:UIControlStateNormal];
    }
    else{
        [glucoseBtn setBackgroundImage:[UIImage imageNamed:@"sugar"] forState:UIControlStateNormal];
    }
}

-(IBAction)oxygenSwitchPressed:(id)sender
{
    if(oxygenSwitch.isOn){
        [oxygenBtn setBackgroundImage:[UIImage imageNamed:@"hme05"] forState:UIControlStateNormal];
    }
    else{
        [oxygenBtn setBackgroundImage:[UIImage imageNamed:@"oxygen"] forState:UIControlStateNormal];
    }
}


-(IBAction)sureBtnPressed:(id)sender
{
//    if(weightSwitch.isOn||fatSwitch.isOn||bloodpressureSwitch.isOn||glucoseSwitch.isOn||oxygenSwitch.isOn)
    if(bloodpressureSwitch.isOn)
    {
        
//        MeasureViewController *measureViewController = [[MeasureViewController alloc]initWithNibName:@"MeasureViewController" bundle:nil];
//        
//        [self presentViewController:measureViewController animated:YES completion:^{//备注2
//            NSLog(@"show InfoView!");
//            
//        }];
        
//        GlucoseMeasureViewController *glucosemeasureViewController = [[GlucoseMeasureViewController alloc]initWithNibName:@"GlucoseMeasureViewController" bundle:nil];
//        
//        [self presentViewController:glucosemeasureViewController animated:YES completion:^{//备注2
//            NSLog(@"show InfoView!");
//            
//        }];
        
        BodyFatMeasureViewController *bodyFatMeasureViewController = [[BodyFatMeasureViewController alloc]initWithNibName:@"BodyFatMeasureViewController" bundle:nil];
        
        [self presentViewController:bodyFatMeasureViewController animated:NO completion:^{//备注2
            NSLog(@"show InfoView!");
            
        }];

    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NOTICE", nil)
                                                            message:NSLocalizedString(@"MUST_CHOOSE_ONE_ITEM", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
        [alertView show];
    }
}


-(IBAction)showGlucoseView:(id)sender
{
    GlucoseMeasureViewController *glucosemeasureViewController = [[GlucoseMeasureViewController alloc]initWithNibName:@"GlucoseMeasureViewController" bundle:nil];
    
    [self presentViewController:glucosemeasureViewController animated:NO completion:^{//备注2
        NSLog(@"show InfoView!");
        
    }];

}

-(IBAction)showBodyfatView:(id)sender
{
    BodyFatMeasureViewController *bodyFatMeasureViewController = [[BodyFatMeasureViewController alloc]initWithNibName:@"BodyFatMeasureViewController" bundle:nil];
    
    [self presentViewController:bodyFatMeasureViewController animated:NO completion:^{//备注2
        NSLog(@"show InfoView!");
        
    }];
}


-(IBAction)showBloodPressView:(id)sender
{
    MeasureViewController *measureViewController = [[MeasureViewController alloc]initWithNibName:@"MeasureViewController" bundle:nil];
    
    [self presentViewController:measureViewController animated:NO completion:^{//备注2
        NSLog(@"show InfoView!");
        
    }];

}







@end
