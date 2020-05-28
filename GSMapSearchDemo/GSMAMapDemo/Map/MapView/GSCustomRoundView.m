//
//  GSCustomRoundView.m
//  GSMAMapDemo
//
//  Created by goldenSir on 2018/6/15.
//  Copyright © 2018年 goldenSir. All rights reserved.
//

#import "GSCustomRoundView.h"

@interface GSCustomRoundView ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation GSCustomRoundView

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

#pragma mark - Life Cycle
- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];

    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, 70, 70);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 35;

        self.backgroundColor = [UIColor colorWithRed:(40)/255.0 green:(170)/255.0 blue:(53)/255.0 alpha:1];

        /* Create name label. */
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 70, 70)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.numberOfLines    = 2;
        self.nameLabel.textColor        = [UIColor whiteColor];
        self.nameLabel.font             = [UIFont systemFontOfSize:13.f];

        [self addSubview:self.nameLabel];
    }

    return self;
}

@end
