//
//  YYCalendarCell.m
//  HYZCalendar
//
//  Created by 韩亚周 on 16/1/22.
//  Copyright (c) 2016年 韩亚周. All rights reserved.
//

#import "YYCalendarCell.h"

@implementation YYCalendarCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLable.translatesAutoresizingMaskIntoConstraints =NO;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLable];
        [self.contentView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:@"H:|[_titleLable]|"
                                         options:1.0
                                         metrics:nil
                                         views:NSDictionaryOfVariableBindings(_titleLable)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:@"V:|[_titleLable]|"
                                         options:1.0
                                         metrics:nil
                                         views:NSDictionaryOfVariableBindings(_titleLable)]];
    }
    return self;
}

- (void)setCalendarCellType:(YYCalendarCellType)calendarCellType{
    _calendarCellType = calendarCellType;
    if (_calendarCellType == YYCalendarCellNow) {
        self.contentView.backgroundColor = [UIColor cyanColor];
    }else if (_calendarCellType == YYCalendarCellLast){
        self.contentView.backgroundColor = [UIColor orangeColor];
    }else{
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
}

@end
