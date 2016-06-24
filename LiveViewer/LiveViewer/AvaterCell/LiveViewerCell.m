//
//  LiveViewerCell.m
//  LiveViewer
//
//  Created by LeeWong on 16/6/23.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "LiveViewerCell.h"
#import "ArtImageView.h"


@interface LiveViewerCell ()

@property (nonatomic,strong) ArtImageView *avaterIcon;


@end

@implementation LiveViewerCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.avaterIcon = [[ArtImageView alloc] init];
        [self.contentView addSubview:self.avaterIcon];
        [self.avaterIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

    }
    
    return self;
}

- (void)setAvaterImageURL:(NSString *)aImageURL
{
    [self.avaterIcon setCornerImageURL:[aImageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}





@end
