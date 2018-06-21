//
//  BViewController.m
//  GSMAMapDemo
//
//  Created by goldenSir on 2018/6/15.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import "BViewController.h"
#import "GSCustomRoundView.h"
#import "GSMAPointAnnotation.h"
#import "GSCustomRectangleView.h"
@interface BViewController ()<MAMapViewDelegate>{
    NSMutableArray *mapDataArray;//获取的地图数据
    BOOL showRound;
}

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.mapView.zoomLevel = Section_11;
    [self getAreaMainData];
    showRound = YES;
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{

    if ([annotation isKindOfClass:[GSMAPointAnnotation class]]){
        if (showRound) {//显示圆形标注点
            static NSString *customReuseIndetifier = @"GSCustomRoundView";
            GSCustomRoundView *annotationView = (GSCustomRoundView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
            if (annotationView == nil){
                annotationView = [[GSCustomRoundView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
                annotationView.canShowCallout = NO;
                annotationView.draggable = YES;
                annotationView.name = annotation.title;
            }else{
                annotationView.name = annotation.title;
            }
            return annotationView;
        }else{
            static NSString *customRectangleView = @"customRectangleView";
            GSCustomRectangleView *rectangleView = (GSCustomRectangleView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customRectangleView];
            NSString *title = annotation.title;
            NSArray *array = [title componentsSeparatedByString:@"\n"];
            if (rectangleView == nil){
                rectangleView = [[GSCustomRectangleView alloc] initWithAnnotation:annotation reuseIdentifier:customRectangleView];
                rectangleView.canShowCallout = NO;
                rectangleView.draggable = YES;

                rectangleView.name = [NSString stringWithFormat:@"%@(%@)",array[0],array[1]];
            }else{
                rectangleView.name = [NSString stringWithFormat:@"%@(%@)",array[0],array[1]];
            }
            rectangleView.portrait = [UIImage imageNamed:@"loc_green"];


            return rectangleView;
        }
    }
    return nil;

}
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{

    showRound = !showRound;//更改判断条件
    [self getAreaMainData];
}
- (void)getAreaMainData{
    NSLog(@"开始获取 主数据，并清除已有标注点");
    [self.mapView removeAnnotations:mapDataArray];//清除已有标注点

    NSArray *dataArray = [NSArray array];
    dataArray = @[@{@"id":@(15),@"name":@"闵行",@"count":@(0),@"avg":@(71569),@"lng":@(121.401628),@"lat":@(31.08534)},
                  @{@"id":@(31),@"name":@"徐汇",@"count":@(9),@"avg":@(244),@"lng":@(121.438727),@"lat":@(31.16874)},
                  @{@"id":@(17),@"name":@"青浦",@"count":@(0),@"avg":@(0),@"lng":@(121.210485),@"lat":@(31.190584)},
                  @{@"id":@(321),@"name":@"虹口",@"count":@(0),@"avg":@(77489),@"lng":@(121.482966),@"lat":@(31.277579)},
                  @{@"id":@(9),@"name":@"浦东",@"count":@(0),@"avg":@(222),@"lng":@(121.59998),@"lat":@(31.202184)},
                  @{@"id":@(321),@"name":@"宝山",@"count":@(0),@"avg":@(222),@"lng":@(121.422375),@"lat":@(31.363255)},
                  @{@"id":@(321),@"name":@"嘉定",@"count":@(0),@"avg":@(22984),@"lng":@(121.278511),@"lat":@(31.312348)},
                  @{@"id":@(321),@"name":@"松江",@"count":@(0),@"avg":@(52139),@"lng":@(121.258576),@"lat":@(31.040069)},
                  @{@"id":@(321),@"name":@"奉贤",@"count":@(0),@"avg":@(222),@"lng":@(121.562037),@"lat":@(30.88552)},
                  ];

    CLLocationCoordinate2D coordinates[dataArray.count];//经纬度结构体
    for (int i = 0; i < dataArray.count; i ++) {

        CLLocationCoordinate2D coor = {[dataArray[i][@"lat"] floatValue],[dataArray[i][@"lng"] floatValue]};
        coordinates[i] = coor;
    }
    //        此处两个遍历可以合并。展示的目的是为了更直白的显示赋值过程。可简化为：annotation.coordinate = coor;
    self->mapDataArray = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i++){

        GSMAPointAnnotation *annotation = [[GSMAPointAnnotation alloc] init];
        annotation.coordinate = coordinates[i];
        annotation.title    = [NSString stringWithFormat:@"%@\n%ld", dataArray[i][@"name"],[dataArray[i][@"count"] integerValue]];
        annotation.subtitle = [NSString stringWithFormat:@"%ld", [dataArray[i][@"id"] integerValue]];

        annotation.areaID = [NSString stringWithFormat:@"%ld", [dataArray[i][@"id"] integerValue]];
        annotation.areaName = [NSString stringWithFormat:@"%@", dataArray[i][@"name"]];
        NSLog(@"%@",[NSString stringWithFormat:@"%ld", [dataArray[i][@"avg"] integerValue]]);
        annotation.areaAvgPic = [NSString stringWithFormat:@"%ld", [dataArray[i][@"avg"] integerValue]];
        annotation.areaCount = [NSString stringWithFormat:@"%ld", [dataArray[i][@"count"] integerValue]];

        [self->mapDataArray addObject:annotation];
    }
    [self.mapView addAnnotations:self->mapDataArray];
}



@end
