//
//  YYCalendarView.h
//  HYZCalendar
//
//  Created by 韩亚周 on 16/1/21.
//  Copyright (c) 2016年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYCollectionView.h"
#import "YYCalendarCell.h"

@class YYCalendarView;

#define MAINWIDTH     [[UIScreen mainScreen] bounds]

/*!direction   
 0 左
 1 右
 */
typedef void (^LeftSwipes) (YYCalendarView *myView, UICollectionView *myCollectionView,BOOL direction);
typedef void (^RightSwipes) (YYCalendarView *myView, UICollectionView *myCollectionView,BOOL direction);

@interface YYCalendarView : UIView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

/*!左滑的回调*/
@property (nonatomic, copy) LeftSwipes               leftSwipeHandle;
/*!右滑的回调*/
@property (nonatomic, copy) LeftSwipes               rightSwipeHandle;
/*!collectionView高度*/
@property (nonatomic, strong) NSLayoutConstraint     *collectionViewHeightConstraint;
/*!用户日历初始化和改变的时候的数据源*/
@property (nonatomic, strong) NSDate                 *calendarDate;

/*!日期数据更新*/
-(void)updateDate:(NSDate*)date;

@end
