//
//  BaseViewController.m
//  GSMAMapDemo
//
//  Created by goldenSir on 2018/6/15.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self creatMapBgView];
}
- (void)creatMapBgView{


    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.rotateEnabled = NO;
    self.mapView.showsScale = NO; // 比例尺
    self.mapView.showsCompass= NO; // 指南针
    self.mapView.rotateEnabled = NO;//地图旋转
    self.mapView.zoomLevel = 9;//初始缩放级别
    [self.view addSubview:self.mapView];
    //设置初始位置。可以通过定位获取
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(31.233212,121.478239);
    //    121.478239,31.233212   上海
    //    120.597011,31.304304   苏州
    //    120.210338,30.251336   杭州
}
- (void)createNav{
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"初始化地图";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGPoint)randomPoint
{
    CGPoint randomPoint = CGPointZero;

    randomPoint.x = arc4random() % (int)(CGRectGetWidth(self.view.bounds));
    randomPoint.y = arc4random() % (int)(CGRectGetHeight(self.view.bounds));

    return randomPoint;
}

@end
