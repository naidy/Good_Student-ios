//
//  NoteManager.m
//  Good_student
//
//  Created by cg on 2017/6/16.
//  Copyright © 2017年 105598061. All rights reserved.
//

#import "NoteManager.h"

@implementation NoteManager

+ (instancetype)sharedInstance {
    static NoteManager *manager = nil;
    if (!manager) {
        manager = [[NoteManager alloc] init];
    }
    return manager;
}

- (instancetype)init {
    if([super init]){
        [self initCourseList];
        _ToDoList = [NSMutableArray new];
    }
    
    return self;
}

- (void)initCourseList {
    self.CourseList = [[NSMutableArray alloc] init];
    int hour = 6;
    for (int i = 0; i < 5; i++){
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (int j = 0; j < 36; j+=2){
            [data setObject:[NSString stringWithFormat:@"%i:00", hour++] atIndexedSubscript:j];
            [data setObject:@"" atIndexedSubscript:j+1];
        }
        [self.CourseList setObject:data atIndexedSubscript:i];
        hour = 6;
    }
}

@end
