//
//  ViewController.m
//  LiveCountDown
//
//  Created by LeeWong on 16/8/23.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self countDown:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self countDown:3];
}

-(void)countDown:(int)count{
    if(count <=0){
        //倒计时已到，作需要作的事吧。
        return;
    }
    CGPoint center = CGPointMake([UIScreen mainScreen].bounds.size.width/2., [UIScreen mainScreen].bounds.size.height/2.);
    UILabel* lblCountDown = [[UILabel alloc] initWithFrame:CGRectMake(center.x - 125,center.y - 125, 250, 250)];
    lblCountDown.textColor = [UIColor redColor];
    lblCountDown.font = [UIFont boldSystemFontOfSize:150];
    lblCountDown.backgroundColor = [UIColor clearColor];
    lblCountDown.text =[NSString stringWithFormat:@"%d",count];
    [self.view addSubview:lblCountDown];
    [UIView animateWithDuration:1
                         delay:0
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        lblCountDown.alpha =0;
                        lblCountDown.transform =CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
                    }
                    completion:^(BOOL finished) {
                        [lblCountDown removeFromSuperview];
                        //递归调用，直到计时为零
                        [self countDown:count -1];
                    }
     ];
    [self.view bringSubviewToFront:lblCountDown];
}

@end
