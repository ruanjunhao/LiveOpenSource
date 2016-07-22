//
//  MenuCell.m
//  MenuController
//
//  Created by LeeWong on 16/7/22.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(handleDeleteCell:))
    {
        return YES; //显示自定义的菜单项
    }
    return NO;
}

@end
