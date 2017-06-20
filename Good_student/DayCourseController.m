//
//  DayCourseController.m
//  Good_student
//
//  Created by cg on 2017/6/15.
//  Copyright © 2017年 105598061. All rights reserved.
//

#import "DayCourseController.h"
#import "CourseManageController.h"
#import "RootViewController.h"
#import "NoteManager.h"

@interface DayCourseController ()
@property (weak, nonatomic) IBOutlet UITableView *CourseListTable;
@property (weak, nonatomic) IBOutlet UILabel *DayLabel;
@property NSArray *time;
@property UIPickerView *picker;
@property NSInteger picker_value;
@property NoteManager *shareInstance;
@end

@implementation DayCourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.CourseListTable.delegate = self;
    self.CourseListTable.dataSource = self;
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(15, 44, 240, 50)];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.DayLabel.text = self.day_s;
    self.time = @[@"6:00", @"7:00", @"8:00", @"9:00", @"10:00", @"11:00", @"12:00", @"13:00", @"14:00", @"15:00", @"16:00", @"17:00", @"18:00", @"19:00", @"20:00", @"21:00", @"22:00", @"23:00"];
    self.picker_value = 0;
    _shareInstance = [NoteManager sharedInstance];
    
    //[self.delegate addItemViewController:self didFinishEnteringItem:self.CourseList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_shareInstance.CourseList[self.day] count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
    }
    cell.textLabel.text = [[_shareInstance.CourseList objectAtIndex:self.day] objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.time.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.time[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.picker_value = row;
}

- (IBAction)NewButtonClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New Work" message:@"\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert.view addSubview:self.picker];
    UITextField * text = [[UITextField alloc] initWithFrame:CGRectMake(15, 94, 240, 30)];
    text.borderStyle = UITextBorderStyleRoundedRect;
    [alert.view addSubview:text];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [[_shareInstance.CourseList objectAtIndex:self.day] setObject:text.text atIndexedSubscript:(self.picker_value * 2 + 1)];
        [self.CourseListTable reloadData];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    }];
    [alert addAction: cancel];
    [alert addAction: ok];
    [self presentViewController:alert animated:YES completion:^{ }];
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
