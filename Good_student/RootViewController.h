//
//  RootViewController.h
//  Good_student
//
//  Created by cg on 2017/6/15.
//  Copyright © 2017年 105598061. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property NSString *curQuest;
@property NSArray *hours;
@property NSMutableArray *routineDesc;
@property NSString *date;
@property NSInteger curHour;
@property NSInteger curYear;
@property NSInteger curMonth;
@property NSInteger curDay;
@property NSInteger curWeekDay;
@property NSInteger curMinute;
@property UIColor *cellColor;

@end
