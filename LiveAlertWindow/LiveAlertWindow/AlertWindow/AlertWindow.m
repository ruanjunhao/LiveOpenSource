//
//  AlertWindow.m
//  LiveAlertWindow
//
//  Created by LeeWong on 16/6/24.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "AlertWindow.h"
#import "LiveViewerView.h"
#import "ArtImageView.h"

@interface AlertWindow ()

@property (nonatomic,strong) ArtImageView *avaterIcon;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *sourceLabel;

@property (nonatomic,strong) UIButton *locationButton;

@property (nonatomic,strong) UIButton *setTagsBtn;

@property (nonatomic,strong) UIView *midLine;

@property (nonatomic,strong) LiveViewerView *imageCollection;

@property (nonatomic,strong) UIButton *nextBtn;

@property (nonatomic,strong) UIButton *reportBtn;

@property (nonatomic,strong) UIButton *focusBtn;

@property (nonatomic,strong) UIView *bottomLine;

@property (nonatomic,strong) UIButton *closeBtn;

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
    
    
    [self.setTagsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sourceLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@(0.5));
        make.top.equalTo(self.setTagsBtn.mas_bottom).offset(10);
    }];
    
    [self.imageCollection.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.midLine.mas_left);
        make.right.equalTo(self.midLine.mas_right);
        make.height.equalTo(@(50));
        make.top.equalTo(self.midLine.mas_bottom).offset(10);
    }];

    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(-5);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.top.equalTo(self.imageCollection.view.mas_bottom).offset(15);
    }];
    
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.left.equalTo(self.mas_centerX).offset(5);
        make.top.equalTo(self.reportBtn.mas_top);
    }];

    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.midLine);
        make.top.equalTo(self.reportBtn.mas_bottom).offset(15);
    }];
    
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
}

- (void)configAlertView:(id)aUser
{
    [self.avaterIcon setCornerImageURL:@"http://ww1.sinaimg.cn/crop.3.45.1919.1919.1024/6b805731jw1em0hze051hj21hk1isn5k.jpg"];
    self.titleLabel.text = [NSString stringWithFormat:@"%@   %@",@"陶老大大大",@"粉丝 12345人"];
    self.sourceLabel.text = @"来自 陶作坊  TAIWAN";
    [self configSource:@"陶作坊"];
    
}


- (void)configSource:(NSString *)text
{
    NSString *allText = [NSString stringWithFormat:@"%@%@  TAIWAN",@"来自",text];
    NSRange range = [allText rangeOfString:text];
    
    NSMutableAttributedString* titleText = [[NSMutableAttributedString alloc] initWithString:allText];
    [titleText addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, range.location)];
    [titleText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11.] range:NSMakeRange(0, range.location)];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.paragraphSpacing = 5.;
    
    [titleText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [titleText length])];
    [titleText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.] range:NSMakeRange(range.location, range.length)];
    [titleText addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(range.location, range.length)];
    
    self.sourceLabel.attributedText = titleText;
}

#pragma mark - AlertWindowDelegate

- (void)onClick:(UIButton *)aBtn
{
    if ([self.delegate respondsToSelector:@selector(alertWindowActionType:)]) {
        [self.delegate alertWindowActionType:aBtn.tag];
    }
}


#pragma mark - lazy load

- (UIButton *)closeBtn
{
    if (_closeBtn == nil) {
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.tag = EArtAlertWindowActionTypeClose;
        [_closeBtn setBackgroundColor: [UIColor clearColor]];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:_closeBtn];
        
        
    }
    
    return _closeBtn;
}

- (UIButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.tag = EArtAlertWindowActionTypeNext;
        [_nextBtn setTitle:@">" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextBtn];
    }
    
    return _nextBtn;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_bottomLine];
    }
    
    return _bottomLine;
}


- (UIButton *)focusBtn
{
    if (_focusBtn == nil) {
        _focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _focusBtn.tag = EArtAlertWindowActionTypeFocus;
        [_focusBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_focusBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_focusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_focusBtn setBackgroundColor:[UIColor darkGrayColor]];
        [self addSubview:_focusBtn];
    }
    
    return _focusBtn;
}


- (UIButton *)reportBtn
{
    if (_reportBtn == nil) {
        _reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reportBtn.tag = EArtAlertWindowActionTypeReport;
        [_reportBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_reportBtn setTitle:@"举报" forState:UIControlStateNormal];
        [_reportBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_reportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self addSubview:_reportBtn];
    }
    
    return _reportBtn;
}


- (LiveViewerView *)imageCollection
{
    if (_imageCollection == nil) {
        _imageCollection = [[LiveViewerView alloc] initWithCellType:EArtCollectionViewCellTypeImage];
        _imageCollection.itemSize = CGSizeMake(60, 60);
        [self addSubview:_imageCollection.view];
    }
    
    return _imageCollection;
}

- (UIView *)midLine
{
    if (_midLine == nil) {
        _midLine = [[UIView alloc] init];
        _midLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_midLine];
    }
    return _midLine;
}

- (UIButton *)setTagsBtn
{
    if (_setTagsBtn == nil) {
        _setTagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setTagsBtn setTitle:@"设置备注和标签" forState:UIControlStateNormal];
        [_setTagsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_setTagsBtn setBackgroundColor:[UIColor lightGrayColor]];
        _setTagsBtn.tag =  EArtAlertWindowActionTypeTags;
        [_setTagsBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
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
        [self bringSubviewToFront:_avaterIcon];
    }
    
    return _avaterIcon;
}

@end
