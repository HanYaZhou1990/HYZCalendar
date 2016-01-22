//
//  YYCalendarCell.h
//  HYZCalendar
//
//  Created by 韩亚周 on 16/1/22.
//  Copyright (c) 2016年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YYCalendarCellNow,
    YYCalendarCellLast,
    YYCalendarCellNext
}YYCalendarCellType;

/*!日历中的cell，每个cell就代表一天*/
@interface YYCalendarCell : UICollectionViewCell

/*!区分是日历开始的几天（上个月后几天）
 结束的几天（下个月的前几天）
 这个月的正文
 now 正文
 last 上个月的后几天
 next下个月的前几天
 */
@property (nonatomic, assign) YYCalendarCellType        calendarCellType;
/*!日历的标题*/
@property (nonatomic,strong) UILabel                    *titleLable;

@end
