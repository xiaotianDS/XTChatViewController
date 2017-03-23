//
//  ViewController.m
//  XTChatDemo
//
//  Created by a on 17/3/23.
//  Copyright © 2017年 a. All rights reserved.
//

#import "ViewController.h"

#import "XTChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];

    [self createNavigationItem];


    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"聊天" forState:UIControlStateNormal];
    [self.view addSubview:btn];

    [btn addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)createNavigationItem
{
    self.navigationItem.title = @"首页";
}

- (void)chatButtonClick
{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
