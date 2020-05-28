//
//  CViewController.m
//  GSMAMapDemo
//
//  Created by goldenSir on 2018/6/19.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import "CViewController.h"
#import "MapTabView.h"
#import "GSCustomRoundView.h"
#import "GSMAPointAnnotation.h"
#import "GSCustomRectangleView.h"

@interface CViewController ()<MAMapViewDelegate>{
    NSMutableArray *mapDataArray;//获取的地图数据
    NSInteger neededZoomLevel;

}
@property (nonatomic, strong) MapTabView *botTabView;
@end

@implementation CViewController
/*
 viewForAnnotation 和 didSelectAnnotationView  类似tableView绘制方法和点击方法
 本控制器（C）主要满足点击更改缩放级别并更换对应数据。

 缩放级别说明：
 3-13  --->   11
 13-15 --->   14
 15-19 --->   16

 个人思路为：
    页面初始化展示数据为：整个上海各个区域数据。如：徐汇区，松江区。（11）
    点击徐汇区：地图放大，显示整个徐汇区数据。如：徐汇滨江，上海南站等。（14）
    点击上海南站，展示附近各小区  房源数量。（16）
 D控制器满足：手动缩放更改数据源并展示。并与点击缩放融合。

（3-13--->11：设置当前缩放级别为11，当缩放结束，当前缩放级别发生改变在3-13之间，不处理数据，超过13 则设置缩放级别为14或16，请求并绘制对应数据。注意点：判断当前缩放级别所在区间，请求对应数据。）
 所有缩放级别的设置是类比于链家来设置的，并不准确。可根据自己需求来设置。
有疑问或者建议可以发邮件给我：  995216390@qq.com
 本人小白，自己摸索的地图点标记，大神见谅
 */
-  (MapTabView *) botTabView{
    if ( !_botTabView){
        _botTabView = [MapTabView myMapTabView];
    }
    return _botTabView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    neededZoomLevel = Section_11;//
    self.mapView.zoomLevel = Section_11;
    [self getAreaMainDataWithZoomLevel:Section_11 isDidSelect:NO];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{

    if ([annotation isKindOfClass:[GSMAPointAnnotation class]]){
        if (neededZoomLevel!=Section_16) {//显示圆形标注点(根据缩放级别来设置)
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

    if ([view isKindOfClass:[GSCustomRoundView class]]) {
        GSCustomRoundView *cusView = (GSCustomRoundView *)view;
        CLLocationCoordinate2D coorinate = [cusView.annotation coordinate];
        NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
        [self.mapView setCenterCoordinate:coorinate animated:YES];//设置中心点位置
        if (neededZoomLevel == Section_11) {
            neededZoomLevel = Section_14;
            [self getAreaMainDataWithZoomLevel:neededZoomLevel isDidSelect:YES];
        }else if (neededZoomLevel == Section_14){
            neededZoomLevel = Section_16;
            [self getAreaMainDataWithZoomLevel:neededZoomLevel isDidSelect:self];
        }
    }else{
        GSCustomRectangleView *rectangleView =(GSCustomRectangleView *)view;
        CLLocationCoordinate2D coorinate = [rectangleView.annotation coordinate];
        NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
        self.mapView.frame = CGRectMake(0, statusAndNav_H, SCREEN_WIDTH, SCREEN_HEIGHT-statusAndNav_H-400);
        [self.mapView setCenterCoordinate:coorinate animated:YES];//设置中心点位置
        
        NSArray *array = [rectangleView.annotation.title componentsSeparatedByString:@"\n"];
        NSString *title = [NSString stringWithFormat:@"%@(%@)",array[0],array[1]];
        [self.botTabView reloadDataWithTitle:title withContent:title];
        [self.view addSubview:self.botTabView];
        [self.botTabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(400);
        }];
    }

}
//点击地图空白区域  移除tableView
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    self.mapView.frame = self.view.frame;
    [self.botTabView removeFromSuperview];
    self.botTabView = nil;
}

- (void)getAreaMainDataWithZoomLevel:(NSInteger)zoomLevel isDidSelect:(BOOL)isDidSelect{
    NSLog(@"开始获取 主数据，并清除已有标注点");
    [self.mapView removeAnnotations:mapDataArray];//清除已有标注点
    NSArray *dataArray = [NSArray array];
    self->mapDataArray = [NSMutableArray array];
    if (isDidSelect) {//只有在点击的时候才更改缩放级别
        [self.mapView setZoomLevel:zoomLevel animated:YES];
    }
    if (zoomLevel==Section_14){
        dataArray = @[@{@"id":@(306),@"name":@"龙华",@"count":@(8),@"avg":@(72401),@"lng":@(121.44339),@"lat":@(31.17943)},
                      @{@"id":@(31),@"name":@"植物园",@"count":@(0),@"avg":@(244),@"lng":@(121.44930),@"lat":@(31.15853)},
                      @{@"id":@(31),@"name":@"上海南站",@"count":@(0),@"avg":@(244),@"lng":@(121.42931),@"lat":@(31.15718)},
                      @{@"id":@(31),@"name":@"长桥",@"count":@(0),@"avg":@(244),@"lng":@(121.43239),@"lat":@(31.13636)},
                      @{@"id":@(31),@"name":@"斜土路",@"count":@(0),@"avg":@(244),@"lng":@(121.46980),@"lat":@(31.19474)},
                      @{@"id":@(31),@"name":@"漕河泾",@"count":@(0),@"avg":@(244),@"lng":@(121.41409),@"lat":@(31.18222)},
                      @{@"id":@(31),@"name":@"万体馆",@"count":@(0),@"avg":@(244),@"lng":@(121.43738),@"lat":@(31.18272)},
                      @{@"id":@(31),@"name":@"康健",@"count":@(0),@"avg":@(244),@"lng":@(121.43429),@"lat":@(31.16744)},
                      @{@"id":@(31),@"name":@"徐汇滨江",@"count":@(0),@"avg":@(244),@"lng":@(121.45689),@"lat":@(31.18594)},
                      ];
    }else if (zoomLevel==Section_16){
        dataArray = @[@{@"id":@(15),@"name":@"华富大厦",@"count":@(1),@"avg":@(24026),@"lng":@(121.444733),@"lat":@(31.174250)},
                      @{@"id":@(31),@"name":@"徐汇苑",@"count":@(1),@"avg":@(97875),@"lng":@(121.444014),@"lat":@(31.177978)},
                      @{@"id":@(17),@"name":@"宛平南路431弄",@"count":@(1),@"avg":@(73774),@"lng":@(121.451997),@"lat":@(31.182030)},
                      @{@"id":@(321),@"name":@"爱建大厦",@"count":@(1),@"avg":@(74862),@"lng":@(121.451587),@"lat":@(31.183956)},
                      @{@"id":@(9),@"name":@"俞三小区",@"count":@(1),@"avg":@(62265),@"lng":@(121.447962),@"lat":@(31.168061)},
                      @{@"id":@(321),@"name":@"协昌小区",@"count":@(2),@"avg":@(73774),@"lng":@(121.444794),@"lat":@(31.179562)},
                      ];
    }else{//Section_11
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
    }

    for (int i = 0; i < dataArray.count; i++){

        GSMAPointAnnotation *annotation = [[GSMAPointAnnotation alloc] init];
        CLLocationCoordinate2D coor = {[dataArray[i][@"lat"] floatValue],[dataArray[i][@"lng"] floatValue]};
        annotation.coordinate = coor;
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
