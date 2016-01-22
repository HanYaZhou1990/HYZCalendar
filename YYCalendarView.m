//
//  YYCalendarView.m
//  HYZCalendar
//
//  Created by 韩亚周 on 16/1/21.
//  Copyright (c) 2016年 韩亚周. All rights reserved.
//

#import "YYCalendarView.h"

@interface YYCalendarView ()

/*!此月份的总天数*/
@property (nonatomic, assign) NSInteger              daysNumber;
@property (nonatomic, strong) YYCollectionView         *calendarCollectionView;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property (nonatomic, strong) NSCalendar               *calendar;

@end

@implementation YYCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        self.calendarCollectionView=[[YYCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_calendarCollectionView registerClass:[YYCalendarCell class] forCellWithReuseIdentifier:@"YYCalendarCell"];
        _calendarCollectionView.delegate=self;
        _calendarCollectionView.dataSource=self;
        _calendarCollectionView.showsHorizontalScrollIndicator=NO;
        _calendarCollectionView.backgroundColor = [UIColor whiteColor];
        _calendarCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_calendarCollectionView];
        
        [self addConstraint:[NSLayoutConstraint
                              constraintWithItem:_calendarCollectionView
                             attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeTop
                             multiplier:1.0
                             constant:0]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_calendarCollectionView
                             attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeLeft
                             multiplier:1.0
                             constant:0]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_calendarCollectionView
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeWidth
                             multiplier:1.0
                             constant:0]];
        _collectionViewHeightConstraint = [NSLayoutConstraint
                                           constraintWithItem:_calendarCollectionView
                                           attribute:NSLayoutAttributeHeight
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                           attribute:NSLayoutAttributeHeight
                                           multiplier:1.0
                                           constant:0];
        [self addConstraint:_collectionViewHeightConstraint];
        self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        
        self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        
        [_calendarCollectionView addGestureRecognizer:self.leftSwipeGestureRecognizer];
        [_calendarCollectionView addGestureRecognizer:self.rightSwipeGestureRecognizer];
        /*!初始化NSCalendar*/
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return self;
}
- (void)setDaysNumber:(NSInteger)daysNumber{
    _daysNumber = daysNumber;
    _collectionViewHeightConstraint.constant = [_calendarCollectionView collectionViewUpdataHeightWithItemContent:(_daysNumber+[self firstWeekdayInThisMonth:_calendarDate]) ineWidth:1.0f andItemHeight:(CGRectGetWidth(MAINWIDTH)-8)/7];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog( @"尼玛的, 你在往左边跑啊....");
        _leftSwipeHandle(self,_calendarCollectionView,NO);
    }if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog( @"尼玛的, 你在往右边跑啊....");
        _rightSwipeHandle(self,_calendarCollectionView,YES);
    }
}

-(void)updateDate:(NSDate*)date{
    self.calendarDate = date;
    [self allMonthDaysCount];
}
/*取到本月的总天数*/
- (void)allMonthDaysCount{
    NSRange totaldaysInMonth = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_calendarDate];
    [self setDaysNumber:totaldaysInMonth.length];
}
/*本月第一天是周几*/
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

/*上个月*/
- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

#pragma mark -
#pragma mark UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger endDays = 7-(_daysNumber + [self firstWeekdayInThisMonth:_calendarDate])%7;
    /*
     _daysNumber本月的天数
     [self firstWeekdayInThisMonth:_calendarDate]本月前边需要补全的天数
     endDays本月结尾的天数
     */
    return _daysNumber + [self firstWeekdayInThisMonth:_calendarDate]+endDays;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YYCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYCalendarCell" forIndexPath:indexPath];
    NSInteger lastMonthDays = [self firstWeekdayInThisMonth:_calendarDate];
    /*1.当indexPath.row小于前边需要补全的天数时
      2.当日历正文结束以后，后边需要拿下个月的数据进行补全
      3.日历的正文
     */
    if (indexPath.row < lastMonthDays) {
        /*取到上个月的date*/
        NSDate *lastDate = [self lastMonth:_calendarDate];
        /*根据date计算出上个月一共有多少天*/
        NSRange totaldaysInMonth = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:lastDate];
        NSInteger lastDateDays = totaldaysInMonth.length;
        cell.titleLable.text = [NSString stringWithFormat:@"%ld",(long)(lastDateDays-lastMonthDays)+indexPath.row+1];
        cell.calendarCellType = YYCalendarCellLast;
    }else if (indexPath.row >= lastMonthDays+_daysNumber){
        cell.titleLable.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row-(lastMonthDays+_daysNumber)+1];
        cell.calendarCellType = YYCalendarCellNext;
    }else{
        cell.titleLable.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row-lastMonthDays+1];
        cell.calendarCellType = YYCalendarCellNow;
    }
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegate -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    /*某一天被点击*/
    NSLog(@"------->%ld",(long)indexPath.row);
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout -
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((CGRectGetWidth(MAINWIDTH)-8)/7, (CGRectGetWidth(MAINWIDTH)-8)/7);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 1, 0, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}

@end
