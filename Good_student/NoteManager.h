//
//  NoteManager.h
//  Good_student
//
//  Created by cg on 2017/6/16.
//  Copyright © 2017年 105598061. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteManager : NSObject
@property(nonatomic, strong) NSMutableArray* CourseList;
@property(nonatomic, strong) NSMutableArray* ToDoList;
+ (instancetype)sharedInstance;
@end
