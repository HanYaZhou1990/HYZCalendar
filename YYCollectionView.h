//
//  YYCollectionView.h
//  HYZCalendar
//
//  Created by 韩亚周 on 16/1/22.
//  Copyright (c) 2016年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCollectionView : UICollectionView

- (CGFloat)collectionViewUpdataHeightWithItemContent:(NSInteger)itemContent
                                           ineWidth:(CGFloat)width
                                      andItemHeight:(CGFloat)height;

@end
