//
//  DayCourseController.h
//  Good_student
//
//  Created by cg on 2017/6/15.
//  Copyright © 2017年 105598061. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DayCourseController;

//@protocol DayCourseControllerDelegate <NSObject>
//- (void)addItemViewController:(DayCourseController *)controller didFinishEnteringItem:(NSMutableArray *)item;
//@end

@interface DayCourseController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
@property NSInteger day;
@property NSString *day_s;

//@property (nonatomic, weak) id <DayCourseControllerDelegate> delegate;

@end
