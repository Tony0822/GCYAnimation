//
//  UIViewAnimationController.m
//  GCYAnimationDemo
//
//  Created by gaochongyang on 2018/5/10.
//  Copyright © 2018年 gaochongyang. All rights reserved.
//

#import "UIViewAnimationController.h"

@interface UIViewAnimationController ()
@property (nonatomic, strong) UIView *redView;

@end

@implementation UIViewAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
//    UIView (UIViewAnimation) - basic animation 基础动画
//    UIView (UIViewAnimationWithBlocks) - basic animation 基础动画
//    UIView (UIViewKeyframeAnimations) - keyframe animation 关键帧动画

//    [self startAnimation];
//    [self animationWithBlocks];
    [self viewKeyframeAnimations];
}
#pragma mark -- UIViewAnimation
- (void)startAnimation {
    [UIView beginAnimations:@"UIViewAnimation" context:(__bridge void * _Nullable)(self)];
//    duration : 动画运行时间
    [UIView setAnimationDuration:2.0];
//     delay : 动画开始到执行的时间间隔
    [UIView setAnimationDelay:0.0];
    //    repeatCount:动画重复次数
    [UIView setAnimationRepeatCount:2];
//    Autoreverse 执行动画回路，前提是设置动画无限重复
    [UIView setAnimationRepeatAutoreverses:YES];
    /*
     UIViewAnimationCurve 表示动画的变化规律：
     
     UIViewAnimationCurveEaseInOut: 开始和结束时较慢
     UIViewAnimationCurveEase: 开始时较慢
     UIViewAnimationCurveEaseOut: 结束时较慢
     UIViewAnimationCurveLinear: 整个过程匀速进行
     */
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    self.redView.center = CGPointMake(300, 300);
    [UIView commitAnimations];
}

#pragma mark -- UIViewAnimationWithBlocks
- (void)animationWithBlocks {
//    duration持续时间，delay延迟时间，UIViewAnimationOptions枚举项和completion动画结束的回调
#if 0
    [UIView animateWithDuration:2.0 animations:^{
        self.redView.center = CGPointMake(300, 300);
    }];
#elif 0
    [UIView animateWithDuration:2.0 animations:^{
        self.redView.center = CGPointMake(300, 300);
    } completion:^(BOOL finished) {
        self.redView.center = CGPointMake(300, 500);
    }];
#elif 0
    [UIView animateWithDuration:3.0
                          delay:2.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        self.redView.center = CGPointMake(300, 300);
    } completion:^(BOOL finished) {
        self.redView.center = CGPointMake(300, 500);
    }];
#elif 0
//    springDamping：弹性阻尼，取值范围时 0 到 1，越接近 0 ，动画的弹性效果就越明显；如果设置为 1，则动画不会有弹性效果。
//    initialSpringVelocity：视图在动画开始时的速度，>= 0。
    [UIView animateWithDuration:3.0
                          delay:1.0
         usingSpringWithDamping:0.2
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.redView.center = CGPointMake(300, 300);
                     } completion:nil];
#elif 1
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
        view.backgroundColor = [UIColor orangeColor];
        UIView *view_1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        [view addSubview:view_1];
        view_1.backgroundColor = [UIColor redColor]; [self.view addSubview:view];
        [UIView animateKeyframesWithDuration:3
                                       delay:3
                                     options:UIViewKeyframeAnimationOptionRepeat|UIViewKeyframeAnimationOptionAutoreverse
                                  animations:^{
                                      view.frame = CGRectMake(100, 100, 50, 50);
                                      [UIView performWithoutAnimation:^{
                                          view.backgroundColor = [UIColor blueColor];
                                      }];
                                  } completion:^(BOOL finished) {
                                      
                                  }];
        [UIView performSystemAnimation:UISystemAnimationDelete
                               onViews:@[view_1]
                               options:0
                            animations:^{
                                view_1.alpha = 0;
                            }
                            completion:^(BOOL finished) {
                            }];
        
    }
#endif

}

#pragma mark -- UIViewKeyframeAnimations
- (void)viewKeyframeAnimations {
#if 0
    [UIView animateKeyframesWithDuration:3.0
                                   delay:1.0
                                 options:UIViewKeyframeAnimationOptionLayoutSubviews
                              animations:^{
                                  self.redView.center = CGPointMake(300, 300);
                              } completion:nil];
    
#elif 1

//    relativeStartTime：是相对起始时间，表示该关键帧开始执行的时刻在整个动画持续时间中的百分比，取值范围是［0-1］
//     relativeDuration：是相对持续时间，表示该关键帧占整个动画持续时间的百分比，取值范围也是［0-1］
    [UIView animateKeyframesWithDuration:3.0
                                   delay:1.0
                                 options:UIViewKeyframeAnimationOptionLayoutSubviews
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.8
                                                          relativeDuration:0.2
                                                                animations:^{
                                                                    self.redView.center = CGPointMake(300, 500);
                                                                }];
                              } completion:nil];
#endif
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
