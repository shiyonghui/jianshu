//
//  ToolMothod.m
//  我的页面
//
//  Created by 施永辉 on 16/7/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ToolMothod.h"

@implementation ToolMothod

//绘制线
+ (UIView *)createLineWithWidth:(CGFloat)width andHeight:(CGFloat)height andColor:(UIColor *)color{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    line.backgroundColor = color;
    
    return line;
}

@end
