//
//  GSMAPointAnnotation.h
//  Xinyi
//
//  Created by goldenSir on 2018/4/16.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface GSMAPointAnnotation : MAPointAnnotation

@property (nonatomic, copy) NSString *areaID;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *areaAvgPic;
@property (nonatomic, copy) NSString *areaCount;

@end
