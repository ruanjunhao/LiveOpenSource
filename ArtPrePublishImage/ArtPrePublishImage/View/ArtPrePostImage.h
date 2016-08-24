//
//  ArtPrePostImage.h
//  ArtPrePublishImage
//
//  Created by LeeWong on 16/7/11.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtPrePostImage : UIView

- (void)addImage:(UIImage *)aImage;
- (void)setImages:(NSArray *)aImages;

@property (nonatomic, strong) void (^removeImageBlock)(UIImage* aImage);
@property (nonatomic, strong) void (^touchImageBlock)(UIImage* aImage);

@end
