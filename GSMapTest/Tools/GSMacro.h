//
//  GSMacro.h
//  ModelShow
//
//  Created by goldenSir on 2017/5/2.
//  Copyright © 2017年 goldenSir. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Section_11        11
#define Section_13        13
#define Section_14        14
#define Section_15        15
#define Section_16        16

//数据请求
#define GSTimeout 25

#define GS_Http_Url     @"http://222.73.113.139:8082/api"    //线上正式


#define RequestType_get     @"GET"
#define RequestType_post     @"POST"
#define RequestType_put     @"PUT"
#define RequestType_delete     @"DELETE"

#define IS_IPHONE_X (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)812) < DBL_EPSILON)
#define statusBar_H (IS_IPHONE_X ?(44.0f): 20.0f)
#define statusAndNav_H (IS_IPHONE_X ?(88.0f): 64.0f)
#define Get_NavStatusBar_height [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height
#define Get_TabBar_height self.tabBarController.tabBar.frame.size.height

//适配   collegeView。tableView
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//颜色类
#define GSRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define GSBLack_Color [UIColor blackColor]
#define GSWhite_Color [UIColor whiteColor]
#define GSGreen_Color GSRGBColor(40, 170, 53)
#define GSRed_Color GSRGBColor(211, 31, 40)

//高德
#define User_latitude @"userlatitude" // 用户纬度
#define User_longitude @"userlongitude" // 用户经度


//其他
#define WS(weakself)  __weak __typeof(&*self)weakself = self;

@interface GSMacro : NSObject

@end
