//
//  ViewController.m
//  我的页面
//
//  Created by 施永辉 on 16/7/20.
//  Copyright © 2016年 mac. All rights reserved.
//
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define VIEW_WEDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height
#import "ViewController.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"
#import "ToolMothod.h"
#import "UIView+Extension.h"
#import "CustomBar.h"
@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate>
{
     CGFloat _yOffset;
    CustomBar * firstBar;
    CustomBar * secondBar;
    CustomBar * thirdBar;
    UIView * bottomLine;
    UIView * movingLine;
    NSInteger indext;
}
@property (nonatomic,strong)UIScrollView * tableScrollView;
@property (nonatomic,strong)FirstView * firstView;
@property (nonatomic,strong)SecondView * secondView;
@property (nonatomic,strong)ThirdView * thirdView;

@property (nonatomic,strong)UIView * headView;
@property (nonatomic,strong)UIView * sectionView;
@property (nonatomic,strong)UIImageView * userHeadView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view, typically from a nib.
    [self createTableScrollView];
    [self createHeaderView];
    [self createUserHeadView];
}

- (void)createTableScrollView{
    self.tableScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    self.tableScrollView.delegate = self;
    self.tableScrollView.contentSize = CGSizeMake(3 * SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableScrollView.pagingEnabled = YES;
    self.tableScrollView.alwaysBounceVertical = NO;
    self.tableScrollView.bounces = NO;
    
    _firstView = [[FirstView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _firstView.tag = 100;
    _firstView.tableView.delegate = self;
     [self createTableHeadView:_firstView.tableView];
    [_tableScrollView addSubview:_firstView];
    
    _secondView = [[SecondView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _secondView.tag = 101;
    _secondView.tableView.delegate = self;
     [self createTableHeadView:_secondView.tableView];
      [_tableScrollView addSubview:_secondView];
    
    _thirdView = [[ThirdView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _firstView.tag = 102;
    _thirdView.tableView.delegate = self;
    [self createTableHeadView:_thirdView.tableView];
      [_tableScrollView addSubview:_thirdView];
    [self.view addSubview:_tableScrollView];
    
}
- (void)createTableHeadView:(UITableView *)tableView{
    UIView * tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 246)];
    tableHeadView.backgroundColor = [UIColor clearColor];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.tableHeaderView = tableHeadView;
    tableView.backgroundColor = [UIColor grayColor];
}
- (void)createHeaderView{
    CGFloat margin = 80;
    CGFloat labelW = SCREEN_WIDTH - 2*margin;
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 246)];
    _headView.backgroundColor = [UIColor lightGrayColor];
    _yOffset = _headView.center.y;
    //昵称
    UILabel * userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, 50, labelW, 30)];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.font = [UIFont systemFontOfSize:18];
    userNameLabel.text = @"施永辉";
    [_headView addSubview:userNameLabel];
    
    //简介描述
    UILabel * describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(userNameLabel.frame)+2, labelW, 24)];
    describeLabel.textAlignment = NSTextAlignmentCenter;
    describeLabel.font = [UIFont systemFontOfSize:13];
    describeLabel.text = @"iOS程序员";
    [describeLabel setTextColor:[UIColor blackColor]];
    [_headView addSubview:describeLabel];
    
    //详细
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(describeLabel.frame)+2, labelW, 24)];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = [UIFont systemFontOfSize:13];
    [detailLabel setTextColor:[UIColor blackColor]];
    detailLabel.text = @"写了0字，获得0个喜欢";
    [_headView addSubview:detailLabel];
    
    //编辑按钮
    //编辑按钮
    CGFloat btnW = 96;
    CGFloat btnH = 32;
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.bounds = CGRectMake(0, 0, btnW, btnH);
    editBtn.center = CGPointMake(self.view.center.x, CGRectGetMaxY(detailLabel.frame)+26);
    editBtn.layer.cornerRadius = 4;
    editBtn.layer.borderWidth = 0.8;
    editBtn.layer.borderColor = [UIColor redColor].CGColor;
    [editBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [editBtn setTitle:@"编辑个人资料" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:editBtn];
    
    [self createSectionView];
    
    [self.view addSubview:_headView];
}
//创建头像
- (void)createUserHeadView
{
    CGFloat centerX = self.view.centerX;
    _userHeadView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    _userHeadView.layer.cornerRadius = 35;
    _userHeadView.layer.masksToBounds = YES;
    _userHeadView.size = CGSizeMake(70 , 70);
    _userHeadView.origin = CGPointMake(centerX - 35, 9);
    [self.navigationController.navigationBar addSubview:_userHeadView];
}
- (void)createSectionView{
    _sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 48)];
    _sectionView.backgroundColor = [UIColor whiteColor];
    
    //划线
    UIView * topLine = [ToolMothod createLineWithWidth:SCREEN_WIDTH andHeight:1 andColor:[UIColor redColor]];
    [topLine setOrigin:CGPointMake(0, 0)];
    [_sectionView addSubview:topLine];
    
    CGFloat ControlBarWidth = VIEW_WEDTH /3;
    CGFloat ControlBarHeight = 30;
    CGFloat ControlBarY = CGRectGetMaxY(topLine.frame) + 7;
    CGSize barSize = CGSizeMake(ControlBarWidth, ControlBarHeight);
    
    //第一个bar
    firstBar = [[CustomBar alloc]initWithCount:@"0" andName:@"第一个" size:barSize];
    [firstBar addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    firstBar.tag = 0;
    firstBar.nameLabel.textColor = [UIColor blackColor];
    [firstBar setOrigin:CGPointMake(0, ControlBarY)];
    [_sectionView addSubview:firstBar];
    
    //第二个bar
    secondBar = [[CustomBar alloc]initWithCount:@"0" andName:@"第二个" size:barSize];
    [secondBar addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    secondBar.tag = 1;
    [secondBar setOrigin:CGPointMake(ControlBarWidth, ControlBarY)];
    [_sectionView addSubview:secondBar];
    
    //第三更bar
    thirdBar = [[CustomBar alloc]initWithCount:@"0" andName:@"第三个" size:barSize];
    [thirdBar addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    thirdBar.tag = 2;
    [thirdBar setOrigin:CGPointMake(2*ControlBarWidth, ControlBarY)];
    [_sectionView addSubview:thirdBar];
    
    //划线
    bottomLine = [ToolMothod createLineWithWidth:SCREEN_WIDTH andHeight:1 andColor:[UIColor purpleColor]];
    [bottomLine setOrigin:CGPointMake(0, CGRectGetMaxY(firstBar.frame) +8)];
    [_sectionView addSubview:bottomLine];
    
    //移动的下划线
    movingLine = [ToolMothod createLineWithWidth:35 andHeight:2 andColor:[UIColor orangeColor]];
    movingLine.center = CGPointMake(firstBar.centerX, 0);
    [bottomLine addSubview:movingLine];
    [_headView addSubview:_sectionView];
}
- (void)changeView :(CustomBar *)sender{
    
    indext = sender.tag;
    [self moveLine:indext];
    
    if ([firstBar isEqual:sender]) {
        
        [self changeItemTintColor:(CustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        firstBar.nameLabel.textColor = [UIColor blackColor];
        secondBar.selected = NO;
        thirdBar.selected = NO;
        
    }else if ([secondBar isEqual:sender]){
        
        [self changeItemTintColor:(CustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        secondBar.nameLabel.textColor = [UIColor redColor];
        firstBar.selected = NO;
        thirdBar.selected = NO;
        
    }else if ([thirdBar isEqual:sender]){
        
        [self changeItemTintColor:(CustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0) animated:NO];
        thirdBar.nameLabel.textColor = [UIColor redColor];
        firstBar.selected = NO;
        secondBar.selected = NO;
    }
}
-(void)moveLine:(NSInteger)sender
{
    CGFloat lineX;
    if (sender == 0) {
        lineX = firstBar.centerX;
    }else if (sender == 1){
        lineX = secondBar.centerX;
    }else{
        lineX = thirdBar.centerX;
    }
    [UIView animateWithDuration:0.2 animations:^{
        
        movingLine.center = CGPointMake(lineX, 0);
    }];
}
-(void)changeItemTintColor:(CustomBar *)sender
{
    if (![firstBar isEqual:sender]) {
        
        firstBar.nameLabel.textColor = [UIColor greenColor];
        
    }
    if (![secondBar isEqual:sender]){
        
        secondBar.nameLabel.textColor = [UIColor greenColor];
    }
    if (![thirdBar isEqual:sender]){
        
        thirdBar.nameLabel.textColor = [UIColor greenColor];
    }
}


#pragma mark scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_tableScrollView]) {
        indext = _tableScrollView.bounds.origin.x/_tableScrollView.bounds.size.width;
        [self moveLine:indext];
        return;
    }
    
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"************* %f",offsetY);
    
    CGFloat scale = 1.0;
    // 放大
    if (offsetY < 0) {
        
    } else if (offsetY > 0) { // 缩小
        // 允许向上超过导航条缩小的最大距离为200
        // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
        // 头像最小是31.5像素
        scale = MAX(0.45, 1 - offsetY / 200);
        
        _userHeadView.transform = CGAffineTransformMakeScale(scale, scale);
        
        // 保证缩放后y坐标不变
        CGRect frame = _userHeadView.frame;
        frame.origin.y = 5;
        _userHeadView.frame = frame;
    }
    
    
    if (scrollView.contentOffset.y > 200) {
        _headView.center = CGPointMake(_headView.center.x, _yOffset - 200);
        return;
    }
    CGFloat h = _yOffset - offsetY;
    _headView.center = CGPointMake(_headView.center.x, h);
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual:_tableScrollView]) {
        
        if (indext == 0) {
            [self changeView:firstBar];
        }else if (indext == 1){
            [self changeView:secondBar];
        }else if (indext == 2){
            [self changeView:thirdBar];
        }
        
        return;
    }
    
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:_tableScrollView]) {
        return;
    }
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}
//设置tableView的偏移量
-(void)setTableViewContentOffsetWithTag:(NSInteger)tag contentOffset:(CGFloat)offset{
    
    CGFloat tableViewOffset = offset;
    if(offset > 200){
        
        tableViewOffset = 200;
    }
    if (tag == 100) {
        [_secondView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_thirdView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }else if(tag == 101){
        
        [_firstView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_thirdView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }else{
        
        [_firstView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_secondView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }
}

- (void)editBtnClick {
    }

@end
