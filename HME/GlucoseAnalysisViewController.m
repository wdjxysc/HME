//
//  GlucoseAnalysisViewController.m
//  HME
//
//  Created by 夏 伟 on 14-1-7.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "GlucoseAnalysisViewController.h"
#import "GlucoseDataCell.h"
#import "database.h"
#import "MySingleton.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"

@interface GlucoseAnalysisViewController ()

@end

@implementation GlucoseAnalysisViewController
@synthesize glucoseDatas;
@synthesize nowDataType;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
        [self showGlucoseDataChart];
    }
    return self;
}

- (void)viewDidLoad
{
    [self initmyview];
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
}
-(IBAction)backBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSDate *date1 = [[NSDate date] dateByAddingDays:(-366)];
    NSDate *date2 = [[NSDate date] dateByAddingDays:2];
    glucoseDatas = [database getGlucoseDataByUserName:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] begintime:date1 endtime:date2];
    nowDataType = @"glucose";
    [myTableView reloadData];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger i = 0;
    if([nowDataType isEqualToString:@"glucose"])
    {
        i = [self.glucoseDatas count];
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
        //        BodyfatDataCell *cell = (BodyfatDataCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        //
        //        if(cell == nil)
        //        {
        //            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BodyfatDataCell" owner:self options:nil];
        //            cell = [nib objectAtIndex:0];
        //        }
        //        NSUInteger row = [indexPath row];
        //        NSDictionary *rowData = [self.bodyFatDatas objectAtIndex:row];
        //        cell.testTimeLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"TestTime"]];
        //        cell.weightDataLabel.text = [[NSString alloc]initWithFormat:@"%@ kg",[rowData objectForKey:@"Weight"]];
        //        cell.fatDataLabel.text = [[NSString alloc] initWithFormat:@"%@ %%",[rowData objectForKey:@"Fat"]];
        //        cell.muscleDataLabel.text = [[NSString alloc] initWithFormat:@"%@ %%",[rowData objectForKey:@"Muscle"]];
        //        cell.waterDataLabel.text = [[NSString alloc] initWithFormat:@"%@ %%",[rowData objectForKey:@"Water"]];
        //        cell.boneDataLabel.text = [[NSString alloc] initWithFormat:@"%@ kg",[rowData objectForKey:@"Bone"]];
        //        cell.visceralFatDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"VisceralFat"]];
        //        cell.bmrDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"BMR"]];
        //        cell.bmiDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"BMI"]];
        //
        //        [cell.weightButton setTitle:NSLocalizedString(@"USER_WEIGHT", nil) forState:UIControlStateNormal];
        //        [cell.fatButton setTitle:NSLocalizedString(@"USER_FAT", nil) forState:UIControlStateNormal];
        //        [cell.muscleButton setTitle:NSLocalizedString(@"USER_MUSCLE", nil) forState:UIControlStateNormal];
        //        [cell.waterButton setTitle:NSLocalizedString(@"USER_WATER", nil) forState:UIControlStateNormal];
        //        [cell.boneButton setTitle:NSLocalizedString(@"USER_BONE", nil) forState:UIControlStateNormal];
        //        [cell.visceralFatButton setTitle:NSLocalizedString(@"USER_VISFAT", nil) forState:UIControlStateNormal];
        //        [cell.bmrButton setTitle:NSLocalizedString(@"USER_BMR", nil) forState:UIControlStateNormal];
        //        [cell.bmiButton setTitle:NSLocalizedString(@"USER_BMI", nil) forState:UIControlStateNormal];
        //        returncell.selectionStyle = UITableViewCellSelectionStyleNone;
        //
        //
        //        returncell = cell;
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
        NSDictionary *rowData = [self.glucoseDatas objectAtIndex:row];
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
        result = 126.0f;
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
        
        NSMutableArray *dataarray = [database getGlucoseDataByUserName:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] begintime:date1 endtime:date2];
        
        glucoseDatas = dataarray;
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

-(void)showGlucoseDataChart
{
    LineChartData *glucoseline = [self getLine:@"Glucose" title:NSLocalizedString(@"USER_GLUCOSE", nil) linecolor:[UIColor redColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:CGRectMake(427, 83, 591, 625)];
    chartView.yMin = 0;
    chartView.yMax = 300;
    chartView.ySteps = @[@"0",@"50",@"100",@"150",@"200",@"250",@"300(mg/dL)"];
    chartView.data = @[glucoseline];
    
    [self.view addSubview:chartView];
}

@end
