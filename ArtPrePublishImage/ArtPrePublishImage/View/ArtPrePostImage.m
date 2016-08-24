//
//  ArtPrePostImage.m
//  ArtPrePublishImage
//
//  Created by LeeWong on 16/7/11.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "ArtPrePostImage.h"

static CGFloat const kLeftAndRightMargin = 10.;
static CGFloat const kTopAndBottomMargin = 10.;

#define kImageWidth  100

#define kImageSize CGSizeMake(55, 55)

@interface ArtPrePostImage ()

@property (nonatomic, strong) UIButton* addImageBtn;
@property (nonatomic, strong) NSMutableArray* imagesBtns;

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation ArtPrePostImage


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    
    return self;
}


- (void)configUI
{
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    self.addImageBtn = [self createImageBtn:[UIImage imageNamed:@"publish_add_img_ind"] canRemove:NO];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:11.];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"最多上传9张图";
    [self.addImageBtn addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.addImageBtn);
        make.centerX.equalTo(self.addImageBtn.mas_centerX);
        make.bottom.equalTo(self.addImageBtn.mas_bottom).offset(-8.);
    }];
    
    self.addImageBtn.center = [self caculateCenterForIndex:0];
    [self.scrollView addSubview:self.addImageBtn];
}


- (void)scrolToRightSide
{
    if (self.imagesBtns) {
        
    }
}


- (CGPoint)caculateCenterForIndex:(NSInteger)aIndex
{
    //    CGFloat sep = (SCREEN_W - kImageWidth*3)/4.;
    CGFloat sep = kLeftAndRightMargin;
    CGFloat x = (aIndex % 9)*(sep + kImageWidth) + (sep + kImageWidth/2);
    CGFloat y = (kTopAndBottomMargin + kImageWidth/2);
    
    return CGPointMake(x, y);
}

+ (CGFloat)rowHeight
{
    return kImageWidth + kTopAndBottomMargin;
}

- (void)removeImageBtn:(UIView *)aBtn
{
    if (self.addImageBtn.hidden) {
        self.addImageBtn.alpha = 0.;
        self.addImageBtn.hidden = NO;
    }
    
    [self.imagesBtns removeObject:aBtn];
    [UIView animateWithDuration:0.2 animations:^{
        aBtn.transform = CGAffineTransformScale(aBtn.transform, 0.2, 0.2);
        self.addImageBtn.alpha = 1.;
        
        [self.imagesBtns enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
            obj.center = [self caculateCenterForIndex:idx];
        }];
        self.addImageBtn.center = [self caculateCenterForIndex:self.imagesBtns.count];
        
    } completion:^(BOOL finished) {
        [aBtn removeFromSuperview];
        self.removeImageBlock([(UIButton *)aBtn imageForState:UIControlStateNormal]);
    }];
}

- (UIButton *)createImageBtn:(UIImage *)aImage canRemove:(BOOL)aCanRemove
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:aImage forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    btn.frame = CGRectMake(0., 0., kImageWidth, kImageWidth);
    
    if (aCanRemove) {
        UIButton* removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [removeBtn setImage:[UIImage imageNamed:@"publish_imageCloseBtn"] forState:UIControlStateNormal];
        [btn addSubview:removeBtn];
        [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@22.);
            make.top.equalTo(btn.mas_top).offset(5.);
            make.right.equalTo(btn.mas_right).offset(-5.);
        }];
        
        @weakify(self);
        [[removeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton* x) {
            @strongify(self);
            [self removeImageBtn:[x superview]];
        }];
        
        
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton* x) {
            @strongify(self);
            if (self.touchImageBlock) {
                self.touchImageBlock([x imageForState:UIControlStateNormal]);
            }
        }];
    }
    
    return btn;
}

- (void)addImage:(UIImage *)aImage
{
    if (self.imagesBtns.count >= 9)
        return;
    
    UIButton* btn = [self createImageBtn:aImage canRemove:YES];
    if (self.imagesBtns.count == 8) {
        self.addImageBtn.hidden = YES;
        
        [self.imagesBtns enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
            obj.center = [self caculateCenterForIndex:idx];
        }];
    }
    
    btn.center = [self caculateCenterForIndex:self.imagesBtns.count];
    if (self.imagesBtns.count < 8) {
        self.addImageBtn.center = [self caculateCenterForIndex:self.imagesBtns.count + 1];
    }
    
    [self.scrollView addSubview:btn];
    [self.imagesBtns addObject:btn];
    
    if (self.imagesBtns.count == 9) {
        self.addImageBtn.hidden = YES;
        self.scrollView.contentSize = CGSizeMake(self.imagesBtns.count * kImageWidth + (self.imagesBtns.count + 1)*kLeftAndRightMargin, 0);
    } else {
        if (self.imagesBtns.count >= 4) {
            self.addImageBtn.hidden = NO;
            self.scrollView.contentSize = CGSizeMake((self.imagesBtns.count + 1) * kImageWidth + (self.imagesBtns.count + 1)*kLeftAndRightMargin, 0);
            CGPoint p = self.scrollView.contentOffset;
            p.x += kImageWidth;
            [self.scrollView setContentOffset:p animated:YES];
        }
    }
    
}

- (void)setImages:(NSArray *)aImages
{
    [self.imagesBtns enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.imagesBtns removeAllObjects];
    
    [aImages enumerateObjectsUsingBlock:^(UIImage* obj, NSUInteger idx, BOOL *stop) {
        [self addImage:obj];
    }];
}

#pragma mark - Lazy Load

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (NSMutableArray *)imagesBtns
{
    if (_imagesBtns == nil) {
        _imagesBtns = [NSMutableArray arrayWithCapacity:1];
    }
    return _imagesBtns;
}

@end
