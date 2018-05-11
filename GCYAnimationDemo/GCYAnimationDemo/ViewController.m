//
//  ViewController.m
//  GCYAnimationDemo
//
//  Created by gaochongyang on 2018/5/10.
//  Copyright © 2018年 gaochongyang. All rights reserved.
//

#import "ViewController.h"
#import "UIViewAnimationController.h"
#import "CoreAnimationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles = @[@"first", @"secend"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100*(i+1), 100, 100)];
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)sender {
    NSInteger tag = sender.tag;
    UIViewController *VC;
    if (0 == tag) {
        VC = [[UIViewAnimationController alloc] init];
    } else {
        VC = [[CoreAnimationController alloc] init];
    }
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
