//
//  XTChatViewController.m
//  XTChatDemo
//
//  Created by a on 17/3/23.
//  Copyright © 2017年 a. All rights reserved.
//

#import "XTChatViewController.h"

@interface XTChatViewController ()

@end

@implementation XTChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self createNavigationItem];

}

- (void)createNavigationItem
{
    self.navigationItem.title = @"聊天界面";



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
