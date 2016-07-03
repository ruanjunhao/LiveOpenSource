//
//  ArtImageView.m
//  ArtLive
//
//  Created by leoliu on 16/6/13.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "ArtImageView.h"
#import <YYWebImage/YYWebImage.h>

@implementation ArtImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self ;
}

- (void)setImageURL:(NSString *)URL
{
    //TODO:替换 placeholder 图
    [self yy_setImageWithURL:[NSURL URLWithString:URL] placeholder:[UIImage imageNamed:@"avaterplaceholder"]];
}

- (void)setImageURL:(NSString *)URL placeholder:(UIImage *)placeholder
{
    [self yy_setImageWithURL:[NSURL URLWithString:URL] placeholder:placeholder];
}

- (void)setCornerImageURL:(NSString *)URL
{
    UIImage *placeholder = [UIImage imageNamed:@"avaterplaceholder"];
    placeholder = [placeholder yy_imageByRoundCornerRadius:placeholder.size.width/2.0];
    __weak typeof(ArtImageView *) weakSelf = self;
    [self yy_setImageWithURL:[NSURL URLWithString:URL] placeholder:placeholder options:kNilOptions completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (!error) {
            [weakSelf setCornerImage:image cornerRadius:image.size.width/2.0];
        }
    }];
}

- (void)setCornerImageURL:(NSString *)URL cornerRadius:(CGFloat)radius
{
    UIImage *placeholder = [UIImage imageNamed:@"avaterplaceholder"];
    placeholder = [placeholder yy_imageByRoundCornerRadius:radius];
    __weak typeof(ArtImageView *) weakSelf = self;
    [self yy_setImageWithURL:[NSURL URLWithString:URL] placeholder:placeholder options:kNilOptions completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (!error) {
            [weakSelf setCornerImage:image cornerRadius:radius];
        }
    }];
}

- (void)setCornerImage:(UIImage *)aImage
{
    [self setCornerImage:aImage cornerRadius:aImage.size.width/2.0];
}

- (void)setCornerImage:(UIImage *)aImage cornerRadius:(CGFloat)radius
{
    //TODO:替换 placeholder 图
    UIImage *image = [UIImage imageNamed:@"avaterplaceholder"];
    if (aImage) {
        image = [aImage yy_imageByRoundCornerRadius:radius];
    } else {
        image = [image yy_imageByRoundCornerRadius:image.size.width/2.0];
    }
    self.image = image;
}
@end
