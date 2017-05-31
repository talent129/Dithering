//
//  ViewController.m
//  Dithering
//
//  Created by mac on 17/5/31.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_Width    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_Height   ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@property (nonatomic, strong) UIView *ditheringView;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

#pragma mark -
- (UIView *)ditheringView
{
    if (!_ditheringView) {
        _ditheringView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_Width - 80) * 0.5, (SCREEN_Height - 80) * 0.5, 80, 80)];
        _ditheringView.backgroundColor = [UIColor cyanColor];
        _ditheringView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"luhan"].CGImage);
        _ditheringView.layer.cornerRadius = 15;
        _ditheringView.layer.masksToBounds = YES;
        
        //添加长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction)];
        [_ditheringView addGestureRecognizer:longPressGesture];
    }
    return _ditheringView;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(15, (SCREEN_Height - 80) * 0.5 + 100, SCREEN_Width - 30, 49);
        _btn.backgroundColor = [UIColor cyanColor];
        _btn.layer.cornerRadius = 8;
        _btn.layer.masksToBounds = YES;
        [_btn setTitle:@"移除动画" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self createUI];
}

#pragma mark -createUI
- (void)createUI
{
    [self.view addSubview:self.ditheringView];
    
    [self.view addSubview:self.btn];
}

//长按手势响应事件
- (void)longPressGestureAction
{
    //创建一个关键帧动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置关键帧
    keyAnimation.values = @[@(-M_PI_4 * 0.1 * 1), @(M_PI_4 * 0.1 * 1), @(-M_PI_4 * 0.1 * 1)];
    
    //设置重复
    keyAnimation.repeatCount = CGFLOAT_MAX;
    
    //把核心动画添加到layer上
    [self.ditheringView.layer addAnimation:keyAnimation forKey:@"keyAnimation"];
}

- (void)btnAction
{
    NSLog(@"移除动画");
    
    //移除某一动画效果
    [self.ditheringView.layer removeAnimationForKey:@"keyAnimation"];
    
    //移除所有动画效果
//    [self.ditheringView.layer removeAllAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
