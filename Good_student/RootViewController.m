//
//  RootViewController.m
//  Good_student
//
//  Created by cg on 2017/6/15.
//  Copyright © 2017年 105598061. All rights reserved.
//

#import "CourseManageController.h"
#import "RootViewController.h"
#import "AddQuestController.h"
#import "NoteManager.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UILabel *toDoMarquee;
@property (weak, nonatomic) IBOutlet UITableView *routineTable;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property NSArray *weekDay;
@property NoteManager *shareInstance;
@end



@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initHours];
    [self initDate];
    self.routineTable.delegate = self;
    self.routineTable.dataSource = self;
    self.routineTable.allowsMultipleSelectionDuringEditing = NO;
    self.curQuest = @"No Class";
    self.toDoMarquee.text = self.curQuest;
    self.weekDay = @[@"", @"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday"];
    _shareInstance = [NoteManager sharedInstance];
    self.cellColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.routineTable reloadData];
    self.curQuest = [NSString stringWithFormat:@"%@ %li:00 %@", self.weekDay[self.curWeekDay], (long)self.curHour, [self checkCurCourse]];
    self.toDoMarquee.text = self.curQuest;
}

- (NSString*)checkCurCourse {
    if (self.curWeekDay > 6 || self.curWeekDay < 2 || self.curHour > 23 || self.curHour < 6)
        return @"";
    else
        return [[self.shareInstance.CourseList objectAtIndex:self.curWeekDay-2] objectAtIndex:(self.curHour-6)*2+1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_shareInstance.ToDoList count] * 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
    }
    
    if (indexPath.row == 1 || (indexPath.row % 2) == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",[[_shareInstance.ToDoList objectAtIndex:(indexPath.row-1)/2] objectAtIndex:0], [[_shareInstance.ToDoList objectAtIndex:(indexPath.row-1)/2] objectAtIndex:3]];
    }
    else{
        cell.textLabel.text = [[_shareInstance.ToDoList objectAtIndex:indexPath.row/2] objectAtIndex:2];
        NSInteger timeInterval = [self compareDate:[self stringToDate:cell.textLabel.text] withDate:[NSDate date]];
        NSString *etaStr = [[_shareInstance.ToDoList objectAtIndex:indexPath.row/2] objectAtIndex:1];
        NSInteger etaInt;
        if(![etaStr  isEqual: @"not sure"]){
            etaInt = [etaStr intValue];
        }
        else{
            etaInt = 0;
        }
        if(timeInterval < 3){
            if(timeInterval < etaInt && etaInt != 0){
                self.cellColor = [UIColor colorWithRed:241.0/255.0 green:196.0/255.0 blue:15.0/255.0 alpha:1];
            }
            else
                self.cellColor = [UIColor colorWithRed:192.0/255.0 green:57.0/255.0 blue:43.0/255.0 alpha:1];
        }
        else if (timeInterval < 14){
            if(timeInterval < etaInt && etaInt != 0){
                self.cellColor = [UIColor colorWithRed:241.0/255.0 green:196.0/255.0 blue:15.0/255.0 alpha:1];
            }
            else
                self.cellColor = [UIColor colorWithRed:211.0/255.0 green:84.0/255.0 blue:0.0/255.0 alpha:1];
        }
        else{
            if(timeInterval < etaInt && etaInt != 0){
                self.cellColor = [UIColor colorWithRed:241.0/255.0 green:196.0/255.0 blue:15.0/255.0 alpha:1];
            }
            else
                self.cellColor = [UIColor colorWithRed:243.0/255.0 green:156.0/255.0 blue:18.0/255.0 alpha:1];
        }
    }
    [cell setBackgroundColor:self.cellColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (NSDate*)stringToDate:(NSString*)str {
    NSString *dateString = [NSString stringWithFormat:@"%@", str];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

- (NSInteger)compareDate:(NSDate*)date1 withDate:(NSDate*)date2{
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInADay = 86400;
    NSInteger dayBetweenDates = distanceBetweenDates / secondsInADay;
    return dayBetweenDates;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [_shareInstance.ToDoList removeObjectAtIndex:indexPath.row/2];
    }
    [self.routineTable reloadData];
}

- (IBAction)courseDidClicked:(id)sender {
    CourseManageController *ggyy = [[CourseManageController alloc] initWithNibName:@"CourseManageController" bundle:nil];
    [self.navigationController pushViewController:ggyy animated:YES];
}

- (IBAction)addQuest:(id)sender {
    AddQuestController *AQC = [[AddQuestController alloc] initWithNibName:@"AddQuestController" bundle:nil];
    [self.navigationController pushViewController:AQC animated:YES];
}

- (void)initHours{
    _hours = [NSArray arrayWithObjects:@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"0",nil];
}

- (void)initDate{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitWeekday | NSCalendarUnitMinute fromDate:[NSDate date]];
    
    self.curDay = [components day];
    self.curMonth = [components month];
    self.curYear = [components year];
    self.curHour = [components hour];
    self.curWeekDay = [components weekday];
    self.curMinute = [components minute];
    
    _date = [NSString stringWithFormat:@"%ld / %ld / %ld", (long)self.curYear, (long)self.curMonth, (long)self.curDay];
    _dateLabel.text = _date;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
