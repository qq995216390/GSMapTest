//
//  AViewController.m
//  GSMAMapDemo
//
//  Created by goldenSir on 2018/6/15.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import "AViewController.h"
#import "CustomAnnotationView.h"

@interface AViewController ()<MAMapViewDelegate>{
    NSMutableArray *testArray;
}

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.zoomLevel = 11;
    self.mapView.delegate = self;
    testArray = [NSMutableArray array];

    [self addAction];

}
//添加自定义标注点
- (void)addAction
{
    CLLocationCoordinate2D randomCoordinate = [self.mapView convertPoint:[self randomPoint] toCoordinateFromView:self.view];

    [self addAnnotationWithCooordinate:randomCoordinate];

}
-(void)addAnnotationWithCooordinate:(CLLocationCoordinate2D)coordinate
{
    testArray = [NSMutableArray array];
    CLLocationCoordinate2D coordinates[3] = {
        {31.215134, 121.489769},
        {31.104906, 121.420967},
        {31.234747, 121.394028},
    };
    for (int i = 0; i < 3; i++) {
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = coordinates[i];
        CLLocationCoordinate2D coorinate = [annotation coordinate];
        NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
        annotation.title    = [NSString stringWithFormat:@"涧西\na-%d",i];
        annotation.subtitle = [NSString stringWithFormat:@"姬姬a-%d",i];
        [testArray addObject:annotation];
    }

    [self.mapView addAnnotations:testArray];
}


#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";

        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];

        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }

        annotationView.portrait = [UIImage imageNamed:@"jiangxiaoyu"];
        annotationView.name = annotation.subtitle;

        return annotationView;
    }

    return nil;
}


//地图区域发生改变
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CLLocationCoordinate2D centerCoordinate = mapView.centerCoordinate;
    self.nowLat = centerCoordinate.latitude;
    self.nowLng = centerCoordinate.longitude;
    self.nowZoomLevel = mapView.zoomLevel;
    NSLog(@"地图区域发生改变 nowLat:%f----nowLng:%f----nowZoomLevel:%f",self.nowLat,self.nowLng,self.nowZoomLevel);
}
//地图缩放结束后调用。
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction{
    CLLocationCoordinate2D centerCoordinate = mapView.centerCoordinate;
    self.nowLat = centerCoordinate.latitude;
    self.nowLng = centerCoordinate.longitude;
    self.nowZoomLevel = mapView.zoomLevel;
    NSLog(@"地图缩放结束后调用 nowLat:%f----nowLng:%f----nowZoomLevel:%f",self.nowLat,self.nowLng,self.nowZoomLevel);
}

@end
