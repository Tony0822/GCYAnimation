//
//  CoreAnimationController.m
//  GCYAnimationDemo
//
//  Created by gaochongyang on 2018/5/10.
//  Copyright © 2018年 gaochongyang. All rights reserved.
//

#import "CoreAnimationController.h"

@interface CoreAnimationController ()
@property (nonatomic, strong) UIView *redView;

@end

@implementation CoreAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(80, 80, 50, 50)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
/*
 CAAnimation是所有动画对象的父类，实现CAMediaTiming协议，负责控制动画的时间、速度和时间曲线等等，是一个抽象类，不能直接使用
 CAPropertyAnimation ：是CAAnimation的子类，它支持动画地显示图层的keyPath，一般不直接使用。
 iOS9.0之后新增CASpringAnimation类，它实现弹簧效果的动画，是CABasicAnimation的子类。
 
    CABasicAnimation
 　　CAKeyframeAnimation
 　　CATransition
 　　CAAnimationGroup
 　　CASpringAnimation
 
 */
//    [self position];
    [self transForm1];
    
}

#pragma mark -- CABasicAnimation
/*
 属性说明
 fromValue：keyPath相应属性的初始值
 toValue：keyPath相应属性的结束值
 byValue：keyPath累加
 */
// 平移动画
- (void)position {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    // 动画持续1秒
    anim.duration = 3;
    // 因为CGPoint是结构体，所以用NSValue包装成一个OC对象
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(105, 105)];
//    anim.byValue = [NSValue valueWithCGPoint:CGPointMake(200, 500)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 500)];
//    是否回到原位置
    anim.removedOnCompletion = NO;
//    kCAFillModeRemoved   默认,当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
//    kCAFillModeForwards  当动画结束后,layer会一直保持着动画最后的状态
//    kCAFillModeBackwards 和kCAFillModeForwards相对,具体参考上面的URL
//    kCAFillModeBoth      kCAFillModeForwards和kCAFillModeBackwards在一起的效果
    anim.fillMode = kCAFillModeForwards;
//    kCAMediaTimingFunctionLinear 匀速
//    kCAMediaTimingFunctionEaseIn 慢进
//    kCAMediaTimingFunctionEaseOut 慢出
//    kCAMediaTimingFunctionEaseInEaseOut 慢进慢出
//    kCAMediaTimingFunctionDefault 默认值（慢进慢出）

    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.redView.layer addAnimation:anim forKey:@"positionAni"];
    // 通过positionAni可以取回相应的动画对象，比如用来中途取消动画
}
// 缩放动画
- (void)transForm1 {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 2, 2)];
    anim.duration = 3;
    [self.redView.layer addAnimation:anim forKey:nil];
    
}
#pragma mark -- CAAnimationGroup
#pragma mark -- CASpringAnimation
#pragma mark -- CAKeyframeAnimation
#pragma mark -- CATransaction

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
