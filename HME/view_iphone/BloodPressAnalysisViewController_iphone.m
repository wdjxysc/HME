//
//  BloodPressAnalysisViewController.m
//  HME
//
//  Created by 夏 伟 on 14-2-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "BloodPressAnalysisViewController_iphone.h"
#import "BloodPressDataCell_iphone.h"
#import "database.h"
#import "MySingleton.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface BloodPressAnalysisViewController_iphone ()

@end

@implementation BloodPressAnalysisViewController_iphone

@synthesize weightDatas;
@synthesize bloodPressDatas;
@synthesize bodyFatDatas;
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
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initmyview];
    [self showChart];
    [self scrollViewTest];
    
    LineChartData *sysline = [self getLine:@"SYS" title:NSLocalizedString(@"USER_SYS", nil) linecolor:[UIColor redColor]];
    LineChartData *dialine = [self getLine:@"DIA" title:NSLocalizedString(@"USER_DIA", nil) linecolor:[UIColor blueColor]];
    
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 300;
    chartView.ySteps = @[@"0",@"50",@"100",@"150",@"200",@"250",@"300(mmHg)"];
    chartView.data = @[sysline,dialine];
    
    [self.view addSubview:chartView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initmyview
{
    [backButton setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"BACK", nil)] forState:UIControlStateNormal];
    [bloodpressButton setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"MEASURE_TYPE_BLOODPRESSURE", nil)] forState:UIControlStateNormal];
    [pulseButton setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"USER_PULSE", nil)] forState:UIControlStateNormal];
}
-(IBAction)backBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSDate *date1 = [[NSDate date] dateByAddingDays:(-366)];
    NSDate *date2 = [[NSDate date] dateByAddingDays:2];
    bloodPressDatas = [database getBloodPressDataByUserName:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] begintime:date1 endtime:date2];
    nowDataType = @"bloodpress";
    [myTableView reloadData];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger i = 0;
    if([nowDataType isEqualToString:@"weight"])
    {
        i = [self.weightDatas count];
    }
    else if([nowDataType isEqualToString:@"bodyfat"])
    {
        i = [self.bodyFatDatas count];
    }
    else if([nowDataType isEqualToString:@"bloodpress"])
    {
        i = [self.bloodPressDatas count];
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
    else if ([nowDataType isEqualToString:@"bloodpress"])
    {
        BloodPressDataCell_iphone *cell = (BloodPressDataCell_iphone *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BloodPressDataCell_iphone" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSUInteger row = [indexPath row];
        NSDictionary *rowData = [self.bloodPressDatas objectAtIndex:row];
        cell.testTimeLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"TestTime"]];
        
        cell.sysDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"SYS"]];
        cell.diaDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"DIA"]];
        cell.pulseDataLabel.text = [[NSString alloc] initWithFormat:@"%@",[rowData objectForKey:@"Pulse"]];
        
        
        [cell.sysButton setTitle:NSLocalizedString(@"USER_SYS", nil) forState:UIControlStateNormal];
        [cell.diaButton setTitle:NSLocalizedString(@"USER_DIA", nil) forState:UIControlStateNormal];
        [cell.pulseButton setTitle:NSLocalizedString(@"USER_PULSE", nil) forState:UIControlStateNormal];
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
    return result;
    //    return roundf(50);
}



///chart

-(void)showChart
{
    LineChartData *d1x = [LineChartData new];
    {
        LineChartData *d1 = d1x;
        NSDate *date1 = [[NSDate date] dateByAddingDays:(-3)];
        NSDate *date2 = [[NSDate date] dateByAddingDays:2];
        d1.xMin = [date1 timeIntervalSinceReferenceDate];
        d1.xMax = [date2 timeIntervalSinceReferenceDate];
        d1.title = @"Foobarbang";
        d1.color = [UIColor redColor];
        d1.itemCount = 6;
        NSMutableArray *arr = [NSMutableArray array];
        //        int y = rand();
        for(NSUInteger i = 0; i < 4; ++i) {
            [arr addObject:@(d1.xMin + (rand() / (float)RAND_MAX) * (d1.xMax - d1.xMin))];
        }
        [arr addObject:@(d1.xMin)];
        [arr addObject:@(d1.xMax)];
        [arr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        NSMutableArray *arr2 = [NSMutableArray array];
        for(NSUInteger i = 0; i < 6; ++i) {
            [arr2 addObject:@((rand() / (float)RAND_MAX) * 6)];
        }
        d1.getData = ^(NSUInteger item) {
            float x = [arr[item] floatValue];
            float y = [arr2[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[date1 dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
        };
    }
    
    LineChartData *d2x = [LineChartData new];
    {
        LineChartData *d1 = d2x;
        NSDate *date1 = [[NSDate date] dateByAddingDays:(-3)];
        NSDate *date2 = [[NSDate date] dateByAddingDays:2];
        d1.xMin = [date1 timeIntervalSinceReferenceDate];
        d1.xMax = [date2 timeIntervalSinceReferenceDate];
        d1.title = @"Bar";
        d1.color = [UIColor blueColor];
        d1.itemCount = 20;
        NSMutableArray *arr = [NSMutableArray array];
        //        int y = rand();
        for(NSUInteger i = 0; i < d1.itemCount - 2; ++i) {
            [arr addObject:@(d1.xMin + (rand() / (float)RAND_MAX) * (d1.xMax - d1.xMin))];
        }
        [arr addObject:@(d1.xMin)];
        [arr addObject:@(d1.xMax)];
        [arr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        NSMutableArray *arr2 = [NSMutableArray array];
        for(NSUInteger i = 0; i < d1.itemCount; ++i) {
            [arr2 addObject:@((rand() / (float)RAND_MAX) * 6)];
        }
        d1.getData = ^(NSUInteger item) {
            float x = [arr[item] floatValue];
            float y = [arr2[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[date1 dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
        };
    }
    
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:CGRectMake(192, 47, 278, 237)];
    chartView.yMin = 0;
    chartView.yMax = 300;
    chartView.ySteps = @[@"50",@"100",@"150",@"200",@"250",@"300(mmHg)"];
    chartView.data = @[d1x,d2x];
    
    [self.view addSubview:chartView];
}

-(LineChartData *)getLine:(NSString *)dataname title:(NSString *)title linecolor:(UIColor *)linecolor
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    LineChartData *data = [LineChartData new];
    {
        LineChartData *d1 = data;
        NSDate *date1 = [[NSDate date] dateByAddingDays:(-6)];
        NSDate *date2 = [[NSDate date] dateByAddingDays:1];
        
        NSMutableArray *dataarray = [database getBloodPressDataByUserName:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] begintime:date1 endtime:date2];
        
        bloodPressDatas = dataarray;
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

-(IBAction)bloodpressBtnPressed:(id)sender
{
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    LineChartData *sysline = [self getLine:@"SYS" title:NSLocalizedString(@"USER_SYS", nil) linecolor:[UIColor redColor]];
    LineChartData *dialine = [self getLine:@"DIA" title:NSLocalizedString(@"USER_DIA", nil) linecolor:[UIColor blueColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 300;
    chartView.ySteps = @[@"0",@"50",@"100",@"150",@"200",@"250",@"300(mmHg)"];
    chartView.data = @[sysline,dialine];
    
    [self.view addSubview:chartView];
}

-(IBAction)pulseBtnPressed:(id)sender
{
    CGRect myframe = CGRectMake(192, 47, 278, 237);
    if(iPhone5)
    {
        myframe = CGRectMake(192, 47, 370, 237);
    }
    LineChartData *pulseline = [self getLine:@"Pulse" title:NSLocalizedString(@"USER_PULSE", nil) linecolor:[UIColor redColor]];
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:myframe];
    chartView.yMin = 0;
    chartView.yMax = 200;
    chartView.ySteps = @[@"0",@"50",@"100",@"150",@"200(Beats/min)"];
    chartView.data = @[pulseline];
    
    [self.view addSubview:chartView];
}


-(void)scrollViewTest
{
    UIScrollView *myscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(430, 420, 50, 50)];
    myscrollview.directionalLockEnabled = YES; //只能一个方向滑动
    myscrollview.pagingEnabled = NO; //是否翻页
    myscrollview.backgroundColor = [UIColor blackColor];
    myscrollview.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
    myscrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    myscrollview.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    myscrollview.delegate = self;
    UIImageView *myimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_top_logo.png"]];
    [myscrollview addSubview:myimage];
    
    [self.view addSubview:myscrollview];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(430, 490, 50, 50)];
    [self.view addSubview:btn];
    
    [scrollView addSubview:myimage];
}

@end
