//
//  YYCollectionView.m
//  HYZCalendar
//
//  Created by 韩亚周 on 16/1/22.
//  Copyright (c) 2016年 韩亚周. All rights reserved.
//

#import "YYCollectionView.h"

@implementation YYCollectionView

- (CGFloat)collectionViewUpdataHeightWithItemContent:(NSInteger)itemContent
                                           ineWidth:(CGFloat)width
                                      andItemHeight:(CGFloat)height{
    [super reloadData];
    NSInteger rows = (itemContent%7)==0?(itemContent/7):((itemContent/7)+1);
    return  (rows -1 )*width + rows*height;
}

@end
