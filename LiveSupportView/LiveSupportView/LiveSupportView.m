//
//  LiveSupportView.m
//  LiveSupportView
//
//  Created by LeeWong on 16/7/3.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "LiveSupportView.h"


//rbg转UIColor(16进制)
#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA16(rgbaValue) [UIColor colorWithRed:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbaValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbaValue & 0xFF))/255.0 alpha:((float)((rgbaValue & 0xFF000000) >> 24))/255.0]


//字体颜色
#define COLOR_FONT_RED   0xD54A45
#define COLOR_FONT_WHITE 0xFFFFFF
#define COLOR_FONT_LIGHTWHITE 0xEEEEEE
#define COLOR_FONT_DARKGRAY  0x555555
#define COLOR_FONT_GRAY  0x777777
#define COLOR_FONT_LIGHTGRAY  0x999999
#define COLOR_FONT_BLACK 0x000000

//背景颜色
#define COLOR_BG_GRAY      0xEDEDED
#define COLOR_BG_ALPHABLACK     0x88000000
#define COLOR_BG_ORANGE 0xf69e21
#define COLOR_BG_ALPHARED  0x88D54A45
#define COLOR_BG_LIGHTGRAY 0xEEEEEE
#define COLOR_BG_ALPHAWHITE 0x55FFFFFF
#define COLOR_BG_WHITE     0xFFFFFF
#define COLOR_BG_DARKGRAY     0xAFAEAE
#define COLOR_BG_RED       0xD54A45
#define COLOR_BG_BLUE      0x4586DA
#define COLOR_BG_CLEAR     0x00000000


@interface LiveSupportView ()

@property (weak, nonatomic) IBOutlet UILabel *loveCountLabel;
@property (weak, nonatomic) IBOutlet UIView *messageContentView;
@property (weak, nonatomic) IBOutlet UIView *loveView;
@end


@implementation LiveSupportView

- (void)awakeFromNib
{
//    self.loveView.backgroundColor = RGBA16(COLOR_BG_ALPHAWHITE);
    self.loveView.layer.cornerRadius = 5;
    self.loveView.clipsToBounds = YES;
    self.loveView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addLove)];
    [self.loveView addGestureRecognizer:tap];
    //点赞人数
    self.loveCountLabel.textColor = RGB16(COLOR_FONT_WHITE);
}



- (void)addLove
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger newCount = [self.loveCountLabel.text integerValue] + 1;
        self.loveCountLabel.text = [[NSNumber numberWithInteger:newCount] stringValue];
        
        int index = arc4random() % 6;
        NSString* imageName = [NSString stringWithFormat:@"heart%d",index];
        UIImageView* animateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        animateView.center = self.loveView.center;
        animateView.image = [UIImage imageNamed:imageName];
        [self.messageContentView addSubview:animateView];
        
        [UIView animateWithDuration:4 animations:^{
            animateView.frame = CGRectMake(animateView.frame.origin.x, 0, animateView.frame.size.width, animateView.frame.size.height);
            animateView.alpha = 0;
        } completion:^(BOOL finish) {
            [animateView removeFromSuperview];
        }];
    });
}




@end
