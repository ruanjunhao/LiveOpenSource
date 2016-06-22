//
//  ViewController.m
//  BlurImage
//
//  Created by LeeWong on 16/6/22.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Art.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imageV = [[UIImageView alloc] init];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://image38.360doc.com/DownloadImg/2011/10/0615/18271155_8.jpg"]];
    
    UIImage *image = [UIImage imageWithData:data];
    //blur number 0-1
//    imageV.image = [UIImage boxblurImage:image withBlurNumber:0.5];
    //深色
//    imageV.image = [image imageByBlurDark];
//    imageV.image = [image imageByBlurSoft];
//    imageV.image = [image imageByBlurLight];
    imageV.image = [image imageByBlurWithTint:[UIColor lightGrayColor]];
    imageV.frame = self.view.bounds;
    [self.view addSubview:imageV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
