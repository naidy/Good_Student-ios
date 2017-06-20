//
//  AddQuestController.m
//  Good_student
//
//  Created by cg on 2017/6/15.
//  Copyright © 2017年 105598061. All rights reserved.
//

#import "AddQuestController.h"
#import "RootViewController.h"
#import "NoteManager.h"

@interface AddQuestController ()
@property NSArray *questType;
@property NSArray *etaFinish;
@property (weak, nonatomic) IBOutlet UIButton *setTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *etaTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UITextView *DesTextView;
@property UIButton *closeETABtn;
@property UIButton *closeTypeBtn;
@property UIPickerView *pickerETA;
@property UIPickerView *pickerType;
@property NSInteger pickerState;
@property NoteManager *shareInstance;
@property NSString* qt;
@property NSString* et;
@property NSString* dd;
@end

@implementation AddQuestController

- (void)viewDidLoad {
    [super viewDidLoad];
    _questType = [[NSArray alloc] initWithObjects:@"專題",@"報告",@"考試",@"研究",@"比賽",@"研討會",@"專案",@"產學", nil];
    _etaFinish = [[NSArray alloc] initWithObjects:@"not sure",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60", nil];
    self.qt = @"";
    self.et = @"";
    self.dd = @"";
    _shareInstance = [NoteManager sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setDeadline:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIView *viewDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,200)];
    [viewDatePicker setBackgroundColor:[UIColor clearColor]];
    
    CGRect pickerFrame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [picker setDatePickerMode:UIDatePickerModeDateAndTime];
    
    [viewDatePicker addSubview:picker];
    
    [alertController.view addSubview:viewDatePicker];
    
    NSDateFormatter *formate=[[NSDateFormatter alloc]init];
    [formate setDateFormat:@"YYYY/MM/dd HH:mm"];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        // sinceDateString = [formate stringFromDate:picker.date];
        // [sinceDateButton setTitle:sinceDateString forState:UIControlStateNormal];
        //_setTimeBtn.titleLabel.text = [formate stringFromDate:picker.date];
        [self.setTimeBtn setTitle:[formate stringFromDate:picker.date] forState:UIControlStateNormal];
        self.dd = [formate stringFromDate:picker.date];
    }];
    
    [alertController addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)setQuestType:(id)sender {
    _pickerState = 0;
    _pickerType = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*2/3-40, self.view.frame.size.width, self.view.frame.size.height/3)];
    [_pickerType setBackgroundColor:[UIColor whiteColor]];
    _pickerType.dataSource = self;
    _pickerType.delegate = self;
    [self.typeBtn setTitle:self.questType[0] forState:UIControlStateNormal];
    self.qt = self.questType[0];
    [self.view addSubview:_pickerType];
    
    _closeTypeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _closeTypeBtn.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 50 - 10);
    [_closeTypeBtn setBackgroundColor:[UIColor whiteColor]];
    [_closeTypeBtn setTitle:@"OK" forState:UIControlStateNormal];
    [_closeTypeBtn addTarget:self action:@selector(closeTypeTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeTypeBtn];
}

- (IBAction)setETA:(id)sender {
    _pickerState = 1;
    _pickerETA = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*2/3-40, self.view.frame.size.width, self.view.frame.size.height/3)];
    [_pickerETA setBackgroundColor:[UIColor whiteColor]];
    _pickerETA.dataSource = self;
    _pickerETA.delegate = self;
    [self.etaTimeBtn setTitle:[_etaFinish objectAtIndex:0] forState:UIControlStateNormal];
    self.et = [self.etaFinish objectAtIndex:0];
    [self.view addSubview:_pickerETA];
    
    _closeETABtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _closeETABtn.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 50 - 10);
    [_closeETABtn setBackgroundColor:[UIColor whiteColor]];
    [_closeETABtn setTitle:@"OK" forState:UIControlStateNormal];
    [_closeETABtn addTarget:self action:@selector(closeETATapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeETABtn];
}

-(void)closeETATapped:(id)sender {
    [_pickerETA removeFromSuperview];
    [_closeETABtn removeFromSuperview];
}

-(void)closeTypeTapped:(id)sender {
    [_pickerType removeFromSuperview];
    [_closeTypeBtn removeFromSuperview];
}

-(void) AddToDoList:(NSString*) qt et:(NSString*) et dd:(NSString*) dd des:(NSString*) des {
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [data setArray:@[qt, et, dd, des]];
    [self.shareInstance.ToDoList addObject:data];
    [self sortToDoList];
}

- (void)sortToDoList {
    NSArray *sortedArray = [_shareInstance.ToDoList sortedArrayUsingComparator: ^(NSMutableArray *d1, NSMutableArray *d2) {
        return [[self stringToDate:d1[2]] compare:[self stringToDate:d2[2]]];
    }];
    _shareInstance.ToDoList = [sortedArray mutableCopy];
}

- (NSDate*)stringToDate:(NSString*)str {
    NSString *dateString = [NSString stringWithFormat:@"%@", str];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

- (IBAction)OKButtonClicked:(id)sender {
    [self AddToDoList:self.qt et:self.et dd:self.dd des:self.DesTextView.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(_pickerState == 1)
        return _etaFinish.count;
    else return _questType.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(_pickerState == 1){
        NSString *title = [_etaFinish objectAtIndex:row];
        return title;
    }
    else{
        NSString *title = self.questType[row];
        return title;
    }
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(_pickerState == 1){
        [self.etaTimeBtn setTitle:[_etaFinish objectAtIndex:row] forState:UIControlStateNormal];
        self.et = [self.etaFinish objectAtIndex:row];
    }
    else{
        [self.typeBtn setTitle:self.questType[row] forState:UIControlStateNormal];
        self.qt = self.questType[row];
    }
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
