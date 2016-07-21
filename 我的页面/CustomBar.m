//
//  CustomBar.m
//  我的页面
//
//  Created by 施永辉 on 16/7/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CustomBar.h"
#import "UIView+Extension.h"
@implementation CustomBar

- (instancetype)initWithCount:(NSString *)count andName:(NSString *)name size:(CGSize)size{
    self = [super init];
    if (self) {
        [self createControlBarWithCount:count andName:name size:size];
    }
    return self;
}

//创建item
- (void)createControlBarWithCount:(NSString *)count andName:(NSString *)name size:(CGSize)size{
    
    [self setSize:size];
    
    //标题
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = name;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    
    //    _countLabel.textColor = ItemNorTintColor;
    _nameLabel.textColor = [UIColor blackColor];
    
    [self addSubview:_nameLabel];
    
}

@end
