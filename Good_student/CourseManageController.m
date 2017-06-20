//
//  CourseManageController.m
//  Good_student
//
//  Created by cg on 2017/6/15.
//  Copyright © 2017年 105598061. All rights reserved.
//

#import "CourseManageController.h"
#import "DayCourseController.h"
#import "RootViewController.h"

@interface CourseManageController ()
@property (weak, nonatomic) IBOutlet UITableView *courseListTable;
@end

@implementation CourseManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.courseListTable.delegate = self;
    self.courseListTable.dataSource = self;
    self.week = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self performSegueWithIdentifier:@"ShowDayCourse" sender:_courseListTable];
    DayCourseController *DCC = [[DayCourseController alloc] initWithNibName:@"DayCourseController" bundle:nil];
    NSInteger selectedIndex = [self.courseListTable indexPathForSelectedRow].row;
    DCC.day = selectedIndex;
    //DCC.delegate = self;
    DCC.day_s = self.week[selectedIndex];
    
    [self.navigationController pushViewController:DCC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
    }
    cell.textLabel.text = self.week[indexPath.row];
    //todo -- title
    return cell;
}

/*- (void)addItemViewController:(DayCourseController *)controller didFinishEnteringItem:(NSMutableArray *)item
{
    self.courseList = item;
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
