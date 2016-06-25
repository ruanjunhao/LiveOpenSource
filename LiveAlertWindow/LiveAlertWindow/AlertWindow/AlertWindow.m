//
//  AlertWindow.m
//  LiveAlertWindow
//
//  Created by LeeWong on 16/6/24.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "AlertWindow.h"
#import "ArtImageView.h"
#import "Masonry.h"
@interface AlertWindow ()

@property (nonatomic,strong) ArtImageView *avaterIcon;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *sourceLabel;

@property (nonatomic,strong) UIButton *locationButton;

@property (nonatomic,strong) UIButton *setTagsBtn;

@property (nonatomic,strong) UIView *midLine;

@property (nonatomic,strong) UIScrollView *imageCollection;

@property (nonatomic,strong) UIButton *reportBtn;

@property (nonatomic,strong) UIButton *focusBtn;

@end

@implementation AlertWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    
    return self;
}


- (void)configUI
{
    [self.avaterIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_top);
        make.width.height.equalTo(@60);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.avaterIcon.mas_bottom).offset(15);
    }];
    
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.titleLabel.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
    }];
    
    
    
}


#pragma mark - lazy load


- (UIButton *)setTagsBtn
{
    if (_setTagsBtn == nil) {
        _setTagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_setTagsBtn];
    }
    
    return _setTagsBtn;
}


- (UILabel *)sourceLabel
{
    if (_sourceLabel == nil) {
        _sourceLabel = [[UILabel alloc] init];
        [self addSubview:_sourceLabel];
    }
    return _sourceLabel;
}


- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (ArtImageView *)avaterIcon
{
    if (_avaterIcon == nil) {
        
        _avaterIcon = [[ArtImageView alloc] init];
        [self addSubview:_avaterIcon];
    }
    
    return _avaterIcon;
}

@end
