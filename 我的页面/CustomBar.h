//
//  CustomBar.h
//  我的页面
//
//  Created by 施永辉 on 16/7/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBar : UIControl
@property(nonatomic,strong)UILabel *nameLabel;
/**
 *  创建问答详情页导航条
 *
 *  @param count 数量
 *  @param name  标题
 *
 */
- (instancetype) initWithCount:(NSString *)count andName :(NSString *)name size:(CGSize)size;
@end
