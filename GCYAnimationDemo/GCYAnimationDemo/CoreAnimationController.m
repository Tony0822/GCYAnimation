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
//    [self transForm1];
//    [self transForm2];
//    [self valueKeyFrameAnim];
//    [self pathKeyFrameAnim];
//    [self transaction];
//    [self springAnimation];
    [self animationGroup];
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
// 旋转动画
- (void)transForm2 {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    // 这里是以向量(1, 1, 0)为轴，旋转π/2弧度(90°)
    // 如果只是在手机平面上旋转，就设置向量为(0, 0, 1)，即Z轴
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 1, 1, 0)];
    anim.duration = 3;
    [self.redView.layer addAnimation:anim forKey:nil];
}
#pragma mark -- CAAnimationGroup
/**
 说明
 组合动画
 position、bounds和opacity改变的组合动画
 */
- (void)animationGroup {
    CABasicAnimation *posAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    posAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 100)];
    
    CABasicAnimation *opcAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opcAnim.toValue = [NSNumber numberWithFloat:1.0];
    opcAnim.toValue = [NSNumber numberWithFloat:0.7];
    
    CABasicAnimation *bodAnim = [CABasicAnimation animationWithKeyPath:@"bounds"];
    bodAnim.toValue = [NSValue valueWithCGRect:self.view.bounds];
    
    CAAnimationGroup *groupAni = [CAAnimationGroup animation];
    groupAni.animations = @[posAnim, opcAnim, bodAnim];
    groupAni.duration = 3;
    groupAni.fillMode = kCAFillModeForwards;
    groupAni.removedOnCompletion = NO;
    groupAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.redView.layer addAnimation:groupAni forKey:@"animationGroup"];
}
#pragma mark -- CASpringAnimation

/**
 说明
 CASpringAnimation是iOS9新加入动画类型，是CABasicAnimation的子类，用于实现弹簧动画。
 mass:质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大）
 stiffness:弹性系数（弹性系数越大，弹簧的运动越快
 damping:阻尼系数（阻尼系数越大，弹簧的停止越快）
 initialVelocity:初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）
 settlingDuration:结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置
 */

- (void)springAnimation {
    CASpringAnimation *anim = [CASpringAnimation animationWithKeyPath:@"bounds"];
    anim.mass = 10;
    anim.stiffness = 5000;
    anim.damping = 100;
    anim.initialVelocity = 5;
    anim.duration = anim.settlingDuration;
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 500)];
    anim.toValue = [NSValue valueWithCGRect:self.view.bounds];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.redView.layer addAnimation:anim forKey:@"springAnimation"];
}


#pragma mark -- CAKeyframeAnimation

/**
 说明
 values:关键帧数组对象，里面每一个元素即为一个关键帧，动画会在对应的时间段内，依次执行数组中每一个关键帧的动画。
 path:动画路径对象，可以指定一个路径，在执行动画时路径会沿着路径移动，Path在动画中只会影响视图的Position
 keyTimes:设置关键帧对应的时间点，范围：0-1。如果没有设置该属性，则每一帧的时间平分。
 
 calculationMode: {
 kCAAnimationLinear：默认值，表示当关键帧为座标点的时候，关键帧之间直接直线相连进行插值计算
 kCAAnimationDiscrete：离散的，不进行插值计算，所有关键帧直接逐个进行显示
 kCAAnimationPaced：使得动画均匀进行，而不是按keyTimes设置的或者按关键帧平分时间，此时keyTimes和timingFunctions无效
 kCAAnimationCubic：对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算，这里的主要目的是使得运行的轨迹变得圆滑
 kCAAnimationCubicPaced：看这个名字就知道和kCAAnimationCubic有一定联系,其实就是在kCAAnimationCubic的基础上使得动画运行变得均匀，就是系统时间内运动的距离相同，此时keyTimes以及timingFunctions也是无效的

 }
 */
- (void)valueKeyFrameAnim {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.duration = 3;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(300, 100)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    anim.values = @[value1, value2, value3, value4, value5];
    [self.redView.layer addAnimation:anim forKey:@"valueKeyFrameAnim"];
}

- (void)pathKeyFrameAnim {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(50, 50, 100, 100));
    anim.path = path;
    CGPathRelease(path);
    
    anim.duration = 3;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    [self.redView.layer addAnimation:anim forKey:@"valueKeyFrameAnim"];
}
#pragma mark -- CATransaction

/**
 属性
 type:过度动画的类型 {
 kCATransitionFade 渐变
 kCATransitionMoveIn 覆盖
 kCATransitionPush 推出
 kCATransitionReveal 揭开
 私有动画类型的值有："cube"、"suckEffect"、"oglFlip"、 "rippleEffect"、"pageCurl"、"pageUnCurl"
 }
 subtype:过度动画的方向 {
 kCATransitionFromRight 从右边
 kCATransitionFromLeft 从左边
 kCATransitionFromTop 从顶部
 kCATransitionFromBottom 从底部
 }
 startProgress;
 endProgress;
 */
- (void)transaction {
    CATransition *anim = [CATransition animation];
    anim.type = kCATransitionPush;
    anim.subtype = kCATransitionFromBottom;
    anim.duration = 10;
    self.redView.backgroundColor = [UIColor yellowColor];
    [self.redView.layer addAnimation:anim forKey:@"transaction"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
