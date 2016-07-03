//
//  AnchorAvaterView.m
//  LiveRoomAnchorAvater
//
//  Created by LeeWong on 16/6/27.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "AnchorAvaterView.h"
#import "ArtImageView.h"

@interface AnchorAvaterView ()

@property (nonatomic,strong) ArtImageView *avaterImage;

@property (nonatomic,strong) UIView *backgroundView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *viewerCountLabel;

@property (nonatomic,strong) UIButton *focusBtn;

@end


@implementation AnchorAvaterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 3;
        [self UIConfigConstrains];
    }
    return self;
}

- (void)UIConfigConstrains
{
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self.avaterImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.left.equalTo(self.backgroundView.mas_left);
        make.centerY.equalTo(self.backgroundView.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avaterImage.mas_right).offset(5);
        make.bottom.equalTo(self.avaterImage.mas_centerY).offset(-2);
    }];
    
    [self.viewerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.avaterImage.mas_centerY).offset(2);
    }];
    
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundView.mas_right).offset(-3);
        make.centerY.equalTo(self.avaterImage.mas_centerY);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
}

- (void)configAnchorAvaterView:(id)aContent
{
    [self.avaterImage setCornerImageURL:@"http://ww1.sinaimg.cn/crop.3.45.1919.1919.1024/6b805731jw1em0hze051hj21hk1isn5k.jpg"];
    
    self.titleLabel.text = @"力宝宝";
    self.viewerCountLabel.text = @"12345";
    
}

#pragma mark - lazy load

- (UIButton *)focusBtn
{
    if (_focusBtn == nil) {
        _focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_focusBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_focusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_focusBtn setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:_focusBtn];
        _focusBtn.tag = 10001;
    }
    
    return _focusBtn;
}

- (UILabel *)viewerCountLabel
{
    if (_viewerCountLabel == nil) {
        _viewerCountLabel = [[UILabel alloc] init];
        _viewerCountLabel.font = [UIFont systemFontOfSize:13.];
        _viewerCountLabel.textColor = [UIColor whiteColor];
        [self.backgroundView addSubview:_viewerCountLabel];
    }
    
    return _viewerCountLabel;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (ArtImageView *)avaterImage
{
    if (_avaterImage == nil) {
        _avaterImage = [[ArtImageView alloc] init];
        [self.backgroundView addSubview:_avaterImage];
    }
    
    return _avaterImage;
}

- (UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_backgroundView];
    }
    
    return _backgroundView;
}

@end
