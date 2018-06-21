//
//  MapTabView.h
//  Xinyi
//
//  Created by goldenSir on 2018/1/31.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapTabView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *prceLab;

@property (weak, nonatomic) IBOutlet UITableView* mapTb;

+ (instancetype)myMapTabView;
- (void)reloadDataWithTitle:(NSString *)title withContent:(NSString *)content;

@end

