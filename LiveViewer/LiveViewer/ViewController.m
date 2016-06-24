//
//  ViewController.m
//  LiveViewer
//
//  Created by LeeWong on 16/6/23.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"

#import "LiveViewerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LiveViewerViewController *vc = [[LiveViewerViewController alloc] init];
    [self.view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.top.equalTo(self.view).offset(100);
        make.right.equalTo(self.view);
    }];
    [self addChildViewController:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
