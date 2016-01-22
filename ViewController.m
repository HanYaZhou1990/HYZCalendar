//
//  ViewController.m
//  HYZCalendar
//
//  Created by 韩亚周 on 16/1/21.
//  Copyright (c) 2016年 韩亚周. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSLayoutConstraint     *calendarViewHeightConstraint;
@property (nonatomic, strong) NSDate                 *currentDate;
@end

@implementation ViewController

/*下个月*/
- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *nextDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return nextDate;
}
/*上个月*/
- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
/*将date转成时间，需要在导航条上展示*/
- (NSString *)dateToString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    _currentDate = [NSDate date];
    
    self.title = [self dateToString:_currentDate];
    
    YYCalendarView *calendarView = [[YYCalendarView alloc]initWithFrame:CGRectZero];
    calendarView.translatesAutoresizingMaskIntoConstraints = NO;
    [calendarView updateDate:_currentDate];
    calendarView.leftSwipeHandle = ^(YYCalendarView *myView, UICollectionView *myCollectionView,BOOL direction){
        [myView updateDate:[self nextMonth:_currentDate]];
        _currentDate = [self nextMonth:_currentDate];
        _calendarViewHeightConstraint.constant = myView.collectionViewHeightConstraint.constant;
        self.title = [self dateToString:_currentDate];
    };
    calendarView.rightSwipeHandle = ^(YYCalendarView *myView, UICollectionView *myCollectionView,BOOL direction){
        [myView updateDate:[self lastMonth:_currentDate]];
        _currentDate = [self lastMonth:_currentDate];
        _calendarViewHeightConstraint.constant = myView.collectionViewHeightConstraint.constant;
        self.title = [self dateToString:_currentDate];
    };
    calendarView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:calendarView];
    [self.view addConstraint:[NSLayoutConstraint
                         constraintWithItem:calendarView
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.view
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0
                         constant:0]];
    [self.view addConstraint:[NSLayoutConstraint
                         constraintWithItem:calendarView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.view
                         attribute:NSLayoutAttributeLeft
                         multiplier:1.0
                         constant:0]];
    [self.view addConstraint:[NSLayoutConstraint
                         constraintWithItem:calendarView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.view
                         attribute:NSLayoutAttributeWidth
                         multiplier:1.0
                         constant:0]];
    _calendarViewHeightConstraint = [NSLayoutConstraint
                                     constraintWithItem:calendarView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:1.0
                                    constant:calendarView.collectionViewHeightConstraint.constant];
    [self.view addConstraint:_calendarViewHeightConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
