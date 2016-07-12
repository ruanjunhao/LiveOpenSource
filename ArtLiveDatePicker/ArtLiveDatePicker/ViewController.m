//
//  ViewController.m
//  ArtLiveDatePicker
//
//  Created by LeeWong on 16/7/12.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "ArtLiveDatePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)configUI
{
    ArtLiveDatePicker *pick = [[ArtLiveDatePicker alloc] init];
    [self.view addSubview:pick];
    [pick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@190);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
