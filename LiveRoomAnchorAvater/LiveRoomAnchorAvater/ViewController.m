//
//  ViewController.m
//  LiveRoomAnchorAvater
//
//  Created by LeeWong on 16/6/27.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "AnchorAvaterView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AnchorAvaterView *anchor = [[AnchorAvaterView alloc] init];
    [anchor configAnchorAvaterView:nil];
    [self.view addSubview:anchor];
    [anchor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(50);
        make.left.equalTo(self.view.mas_left).offset(100);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
