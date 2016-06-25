//
//  ViewController.m
//  LiveAlertWindow
//
//  Created by LeeWong on 16/6/24.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "AlertWindow.h"

@interface ViewController () <AlertWindowDelegate>

@property (nonatomic,strong) UIView *setScoreBgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self popWindow];
}

- (void)popWindow
{
    self.setScoreBgView = [[UIView alloc] init];
    self.setScoreBgView.backgroundColor = [UIColor blackColor];
    self.setScoreBgView.alpha = 0.7;
    [[UIApplication sharedApplication].keyWindow addSubview:self.setScoreBgView];
    [self.setScoreBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    AlertWindow *alert = [[AlertWindow alloc] init];
    alert.backgroundColor = [UIColor whiteColor];
    alert.delegate = self;
    [alert configAlertView:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];

    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo([UIApplication sharedApplication].keyWindow.mas_centerX);
        make.centerY.equalTo([UIApplication sharedApplication].keyWindow.mas_centerY);
        make.width.equalTo(@250);
        make.height.equalTo(@320);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)alertWindowActionType:(EArtAlertWindowActionType)aActionType
{
    NSLog(@"%@",@(aActionType));
}

@end
