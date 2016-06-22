//
//  UIImage+Art.h
//  BlurImage
//
//  Created by LeeWong on 16/6/22.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Art)
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

- (UIImage *)imageByBlurSoft ;
- (UIImage *)imageByBlurLight;
- (UIImage *)imageByBlurExtraLight ;
- (UIImage *)imageByBlurDark;
- (UIImage *)imageByBlurWithTint:(UIColor *)tintColor;

@end
