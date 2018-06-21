//
//  GSCustomRectangleView.h
//  GSMAMapDemo
//
//  Created by goldenSir on 2018/6/15.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface GSCustomRectangleView : MAAnnotationView

@property (nonatomic, strong) UIImageView *portraitImageView;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, assign) BOOL canNotSelect;// == yes 则不允许选中，默认允许选中

@end
