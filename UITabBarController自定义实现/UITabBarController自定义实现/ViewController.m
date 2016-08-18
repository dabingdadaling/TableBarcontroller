//
//  ViewController.m
//  UITabBarController自定义实现
//
//  Created by xiebin on 16/8/1.
//  Copyright © 2016年 xiebin. All rights reserved.
//

#import "ViewController.h"
/*
 UITabBarController有多少个按钮,就有多少个子控制器;点击按钮切换不同的子控制器
 
 */
@interface ViewController ()
// 占位的View
@property (weak, nonatomic) IBOutlet UIView *containerView;
// tableBar
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic , weak) UIButton *selectBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self addChildVc];
    // 添加TabBar的按钮
    [self addButton];
}

- (void)addChildVc
{
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.title = @"全部";
    vc1.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.title = @"视频";
    vc2.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:vc2];

    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.title = @"声音";
    vc3.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.title = @"段子";
    vc4.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:vc4];
}

- (void)addButton
{
    NSInteger count = self.view.subviews.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.bottomView.bounds.size.width / count;
    CGFloat btnH = self.bottomView.bounds.size.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btnX = i *btnW;
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [self.bottomView addSubview:btn];
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 默认选中第一按钮
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
    }

}

- (void)btnClick:(UIButton *)btn
{
    // 切换界面
    NSInteger i = btn.tag;
    UIViewController *vc = self.childViewControllers[i];
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 设置按钮选中状态
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
    [self.containerView addSubview:vc.view];
}
@end
