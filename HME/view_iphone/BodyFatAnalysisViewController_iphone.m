//
//  BodyFatAnalysisViewController_iphone.m
//  HME
//
//  Created by 夏 伟 on 14-2-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "BodyFatAnalysisViewController_iphone.h"
#import "BodyfatDataCell_iphone.h"
#import "GlucoseDataCell.h"
#import "database.h"
#import "MySingleton.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface BodyFatAnalysisViewController_iphone ()

@end

@implementation BodyFatAnalysisViewController_iphone
@synthesize bodyfatdatas;
@synthesize nowDataType;

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
    [self initmyview];
    [self showWeightDataChart];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initmyview
{
    [backButton setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"BACK", nil)] forState:UIControlStateNormal];
    
    [segmentedControl setTitle:NSLocalizedString(@"USER_WEIGHT", nil) forSegmentAtIndex:0];
    [segmentedControl setTitle:NSLocalizedString(@"USER_FAT", nil) forSegmentAtIndex:1];
    [segmentedControl setTitle:NSLocalizedString(@"USER_MUSCLE", nil) forSegmentAtIndex:2];
    [segmentedControl setTitle:NSLocalizedString(@"USER_WATER", nil) forSegmentAtIndex:3];
    [segmentedControl setTitle:NSLocalizedString(@"USER_BONE", nil) forSegmentAtIndex:4];
    [segmentedControl setTitle:NSLocalizedString(@"USER_BMI", nil) forSegmentAtIndex:5];
//    [segmentedControl setTitle:NSLocalizedString(@"USER_BMR", nil) forSegmentAtIndex:6];
}

-(IBAction)segmentedValueChanged:(id)sender
{
    NSInteger index = segmentedControl.selectedSegmentIndex;
    switch (index) {
        case 0:
            NSLog(@"0 clicked.");
            [self showWeightDataChart];
            break;
        case 1:
            NSLog(@"1 clicked.");
            [self showFatDataChart];
            break;
        case 2:
            NSLog(@"2 clicked.");
            [self showMuscleDataChart];
            break;
        case 3:
            NSLog(@"3 clicked.");
            [self showWaterDataChart];
            break;
        case 4:
            NSLog(@"4 clicked.");
            [self showBoneDataChart];
            break;
        case 5:
            NSLog(@"4 clicked.");
            [self showBMIDataChart];
            break;
        case 6:
            NSLog(@"4 clicked.");
            [self showBMRDataChart];
            break;
        default:
            break;
    }
}

-(IBAction)backBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSDate *date1 = [[NSDate date] dateByAddingDays:(-366)];
    NSDate *date2 = [[NSDate date] dateByAddingDays:2];
    bodyfatdatas = [database getBodyFatDataByUserName:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] begintime:date1 endtime:date2];
    nowDataType = @"bodyfat";
    [myTableView reloadData];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int i = 0;
    if([nowDataType isEqualToString:@"bodyfat"])
    {
        i = (unsigned long)[self.bodyfatdatas count];
    }
    return i;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    UITableViewCell *returncell = [[UITableViewCell alloc]init];
    if([nowDataType isEqualToString:@"weight"])
    {
        //        WeightDataCell *cell = (WeightDataCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        //
        //        if(cell == nil)
        //        {
        //            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WeightDataCell" owner:self options:nil];
        //            cell = [nib objectAtIndex:0];
        //        }
        //
        //        NSUInteger row = [indexPath row];
        //        NSDictionary *rowData = [self.weightDatas objectAtIndex:row];
        //        //@synthesize testTimeLabel,weightLabel,fatLabel,muscleLabel,waterLabel,boneLabel,visceralFatLabel,kcalLabel,bmiLabel;
        //        //cell.testTimeLabel.text = [rowData objectForKey:@""]
        //        //cell.colorLabel.text = [rowData objectForKey:@"Color"];
        //        //cell.nameLabel.text = [rowData objectForKey:@"Name"];
        //        cell.testTimeLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"TestTime"]];
        //        cell.weightDataLabel.text = [[NSString alloc] initWithFormat:@"%@ (kg)",[rowData objectForKey:@"Weight"]];
        //        [cell.weightButton setTitle:NSLocalizedString(@"USER_WEIGHT", nil) forState:UIControlStateNormal];
        //        //UIImage *image = [UIImage imageNamed:@"bluetooth.png"];
        //        //cell.imageView.image = image;
        //        returncell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        returncell = cell;
    }
    else if([nowDataType isEqualToString:@"bodyfat"])
    {
        BodyfatDataCell_iphone *cell = (BodyfatDataCell_iphone *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BodyfatDataCell_iphone" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSUInteger row = [indexPath row];
        NSDictionary *rowData = [self.bodyfatdatas objectAtIndex:row];
        cell.testTimeLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"TestTime"]];
        cell.weightDataLabel.text = [[NSString alloc]initWithFormat:@"%@ kg",[rowData objectForKey:@"Weight"]];
        cell.fatDataLabel.text = [[NSString alloc] initWithFormat:@"%@ %%",[rowData objectForKey:@"Fat"]];
        cell.muscleDataLabel.text = [[NSString alloc] initWithFormat:@"%@ %%",[rowData objectForKey:@"Muscle"]];
        cell.waterDataLabel.text = [[NSString alloc] initWithFormat:@"%@ %%",[rowData objectForKey:@"Water"]];
        cell.boneDataLabel.text = [[NSString alloc] initWithFormat:@"%@ %%",[rowData objectForKey:@"Bone"]];
        cell.visceralFatDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"VisceralFat"]];
        cell.bmrDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"BMR"]];
        cell.bmiDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"BMI"]];
        
        [cell.weightButton setTitle:NSLocalizedString(@"USER_WEIGHT", nil) forState:UIControlStateNormal];
        [cell.fatButton setTitle:NSLocalizedString(@"USER_FAT", nil) forState:UIControlStateNormal];
        [cell.muscleButton setTitle:NSLocalizedString(@"USER_MUSCLE", nil) forState:UIControlStateNormal];
        [cell.waterButton setTitle:NSLocalizedString(@"USER_WATER", nil) forState:UIControlStateNormal];
        [cell.boneButton setTitle:NSLocalizedString(@"USER_BONE", nil) forState:UIControlStateNormal];
        [cell.visceralFatButton setTitle:NSLocalizedString(@"USER_VISFAT", nil) forState:UIControlStateNormal];
        [cell.bmrButton setTitle:NSLocalizedString(@"USER_BMR", nil) forState:UIControlStateNormal];
        [cell.bmiButton setTitle:NSLocalizedString(@"USER_BMI", nil) forState:UIControlStateNormal];
        returncell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.visceralFatButton.hidden = true;
        cell.visceralFatDataLabel.hidden = true;
        
        
        returncell = cell;
    }
    else if ([nowDataType isEqualToString:@"glucose"])
    {
        GlucoseDataCell *cell = (GlucoseDataCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GlucoseDataCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSUInteger row = [indexPath row];
        NSDictionary *rowData = [self.bodyfatdatas objectAtIndex:row];
        cell.testTimeLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"TestTime"]];
        
        cell.glucoseDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"Glucose"]];
        
        
        [cell.glucoseButton setTitle:NSLocalizedString(@"USER_GLUCOSE", nil) forState:UIControlStateNormal];
        returncell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        returncell = cell;
    }
    
    return returncell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat result = 50.0f;
    if([nowDataType isEqualToString:@"weight"])
    {
        result = 70.0f;
    }
    else if([nowDataType isEqualToString:@"bodyfat"])
    {
        result = 120.0f;
    }
    else if([nowDataType isEqualToString:@"bloodpress"])
    {
        result = 100.0f;
    }
    else if ([nowDataType isEqualToString:@"glucose"])
    {
        result = 56.0f;
    }
    return result;
    //    return roundf(50);
}



///chart

-(LineChartData *)getLine:(NSString *)dataname title:(NSString *)title linecolor:(UIColor *)linecolor
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    LineChartData *data = [LineChartData new];
    {
        LineChartData *d1 = data;
        NSDate *date1 = [[NSDate date] dateByAddingDays:(-6)];
        NSDate *date2 = [[NSDate date] dateByAddingDays:1];
        
        NSMutableArray *dataarray = [database getBodyFatDataByUserName:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] begintime:date1 endtime:date2];
        
        bodyfatdatas = dataarray;
        [myTableView reloadData];
        
        
        d1.xMin = [date1 timeIntervalSinceReferenceDate];
        d1.xMax = [date2 timeIntervalSinceReferenceDate];
        d1.title = title;
        d1.color = linecolor;
        d1.itemCount = [dataarray count];
        NSMutableArray *arr = [NSMutableArray array];
        
        for(NSUInteger i = 0; i < d1.itemCount; ++i) {
            NSDate *testtime = [formatter dateFromString:[dataarray[i] valueForKey:@"TestTime"]];
            long item = [testtime timeIntervalSinceReferenceDate];
            [arr addObject:@(item)];
            //            [arr addObject:@(d1.xMin + (rand() / (float)RAND_MAX) * (d1.xMax - d1.xMin))];
        }
        //        [arr addObject:@(d1.xMin)];
        //        [arr addObject:@(d1.xMax)];
        //        [arr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //            return [obj1 compare:obj2];
        //        }];
        
        NSMutableArray *arr2 = [NSMutableArray array];
        for(NSUInteger i = 0; i < d1.itemCount; ++i) {
            float y = [[dataarray[i] valueForKey:dataname] floatValue];
            [arr2 addObject:@(y)];
            //            [arr2 addObject:@((rand() / (float)RAND_MAX) * 6)];
        }
        d1.getData = ^(NSUInteger item) {
            float x = [arr[item] floatValue];
            float y = [arr2[item] floatValue];
            
            NSString *label1 = [formatter stringFromDate:[formatter dateFromString:[dataarray[item] valueForKey:@"TestTime"]]];
            NSString *label2 = [NSString stringWithFormat:@"%.0f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
        };
        
    }
    
    return data;
}

-(void)showWeightDataChart
{
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    
    LineChartData *weightline = [self getLine:@"Weight" title:NSLocalizedString(@"USER_WEIGHT", nil) linecolor:[UIColor redColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 300;
    chartView.ySteps = @[@"0",@"50",@"100",@"150",@"200",@"250",@"300(kg)"];
    chartView.data = @[weightline];
    
    [self.view addSubview:chartView];
}

-(void)showFatDataChart
{
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    
    LineChartData *weightline = [self getLine:@"Fat" title:NSLocalizedString(@"USER_FAT", nil) linecolor:[UIColor redColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 100;
    chartView.ySteps = @[@"0",@"20",@"40",@"60",@"80",@"100(%)"];
    chartView.data = @[weightline];
    
    [self.view addSubview:chartView];
}

-(void)showMuscleDataChart
{
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    
    LineChartData *weightline = [self getLine:@"Muscle" title:NSLocalizedString(@"USER_MUSCLE", nil) linecolor:[UIColor redColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 100;
    chartView.ySteps = @[@"0",@"20",@"40",@"60",@"80",@"100(%)"];
    chartView.data = @[weightline];
    
    [self.view addSubview:chartView];
}

-(void)showWaterDataChart
{
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    
    LineChartData *weightline = [self getLine:@"Water" title:NSLocalizedString(@"USER_WATER", nil) linecolor:[UIColor redColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 100;
    chartView.ySteps = @[@"0",@"20",@"40",@"60",@"80",@"100(%)"];
    chartView.data = @[weightline];
    
    [self.view addSubview:chartView];
}

-(void)showBoneDataChart
{
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    
    LineChartData *weightline = [self getLine:@"Bone" title:NSLocalizedString(@"USER_BONE", nil) linecolor:[UIColor redColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 100;
    chartView.ySteps = @[@"0",@"20",@"40",@"60",@"80",@"100(%)"];
    chartView.data = @[weightline];
    
    [self.view addSubview:chartView];
}

-(void)showBMIDataChart
{
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    
    LineChartData *weightline = [self getLine:@"BMI" title:NSLocalizedString(@"USER_BMI", nil) linecolor:[UIColor redColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 50;
    chartView.ySteps = @[@"0",@"10",@"20",@"30",@"40",@"50"];
    chartView.data = @[weightline];
    
    [self.view addSubview:chartView];
}

-(void)showBMRDataChart
{
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    
    LineChartData *weightline = [self getLine:@"BMR" title:NSLocalizedString(@"USER_FAT", nil) linecolor:[UIColor redColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 2000;
    chartView.ySteps = @[@"0",@"500",@"1000",@"1500",@"2000"];
    chartView.data = @[weightline];
    
    [self.view addSubview:chartView];
}


@end
