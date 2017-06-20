//
//  CourseManageController.h
//  Good_student
//
//  Created by cg on 2017/6/15.
//  Copyright © 2017年 105598061. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DayCourseController.h"

@interface CourseManageController : UIViewController<UITableViewDelegate, UITableViewDataSource>//, DayCourseControllerDelegate>
//@property NSMutableArray *courseList;
@property NSArray *week;
@end
