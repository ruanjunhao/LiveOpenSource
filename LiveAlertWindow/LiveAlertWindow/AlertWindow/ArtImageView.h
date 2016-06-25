//
//  ArtImageView.h
//  ArtLive
//
//  Created by leoliu on 16/6/13.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtImageView : UIImageView

- (void)setImageURL:(NSString *)URL;

- (void)setImageURL:(NSString *)URL placeholder:(UIImage *)placeholder;

/**
 *  设置圆角图片
 *
 *  @param URL 图片的 url
 */
- (void)setCornerImageURL:(NSString *)URL;

/**
 *  根据radius设置圆角图片
 *
 *  @param URL    图片的 url
 *  @param radius radius
 */
- (void)setCornerImageURL:(NSString *)URL cornerRadius:(CGFloat)radius;

- (void)setCornerImage:(UIImage *)aImage;
- (void)setCornerImage:(UIImage *)aImage cornerRadius:(CGFloat)radius;
@end
