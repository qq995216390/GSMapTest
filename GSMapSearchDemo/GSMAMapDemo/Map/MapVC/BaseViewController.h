//
//  BaseViewController.h
//  GSMAMapDemo
//
//  Created by goldenSir on 2018/6/15.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, assign) float nowLat;//当前经纬度(屏幕中心点);
@property (nonatomic, assign) float nowLng;//当前经纬度(屏幕中心点);
@property (nonatomic, assign) float nowZoomLevel;//当前缩放级别;

- (CGPoint)randomPoint;


@end
