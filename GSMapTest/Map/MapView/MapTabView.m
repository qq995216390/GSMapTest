//
//  MapTabView.m
//  Xinyi
//
//  Created by goldenSir on 2018/1/31.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import "MapTabView.h"
#import "UsedHouseMainCell.h"

@interface MapTabView ()<UITableViewDelegate,UITableViewDataSource>{

    NSString *showStr;
}
@property (nonatomic,assign)NSInteger areaID;
@end

@implementation MapTabView

+ (instancetype)myMapTabView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}
- (void)setup
{
    showStr = @"对应小区所包含的房源";
    _mapTb.delegate = self;
    _mapTb.dataSource = self;
    _mapTb.tableFooterView = [UIView new];
    [_mapTb registerNib:[UINib nibWithNibName:@"UsedHouseMainCell" bundle:nil] forCellReuseIdentifier:@"UsedHouseMainCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UsedHouseMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UsedHouseMainCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myLabel.text = [NSString stringWithFormat:@"%@ 对应的房源",showStr];
    return cell;

}

- (IBAction)moreRightBtnClick:(id)sender {
    
}

- (void)reloadDataWithTitle:(NSString *)title withContent:(NSString *)content{
    self.nameLab.text = title;
    showStr = content;
    [self.mapTb reloadData];
}
@end

