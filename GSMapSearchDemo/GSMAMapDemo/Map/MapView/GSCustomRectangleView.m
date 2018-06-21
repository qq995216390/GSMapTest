//
//  GSCustomRectangleView.m
//  GSMAMapDemo
//
//  Created by goldenSir on 2018/6/15.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import "GSCustomRectangleView.h"

@interface GSCustomRectangleView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImage *bgImage;

@end

@implementation GSCustomRectangleView

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}
- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:YES];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (self.canNotSelect) {
        return;
    }
    if (selected) {
        self.portraitImageView.image = [UIImage imageNamed:@"loc_red"];
    }else{
        self.portraitImageView.image = [UIImage imageNamed:@"loc_green"];
    }
}
#pragma mark - Life Cycle
- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];

    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, 110, 32);
        self.backgroundColor = [UIColor clearColor];
        self.portraitImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 42)];
        [self addSubview:self.portraitImageView];

        /* Create name label. */
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 110, 32)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.numberOfLines    = 1;
        self.nameLabel.textColor        = [UIColor whiteColor];
        self.nameLabel.font             = [UIFont systemFontOfSize:14.f];

        [self addSubview:self.nameLabel];
    }

    return self;
}

@end
