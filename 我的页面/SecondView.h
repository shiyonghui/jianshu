//
//  SecondView.h
//  我的页面
//
//  Created by 施永辉 on 16/7/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong) void(^scrollObserve)();
@end
