//
//  AnchorAvaterView.h
//  LiveRoomAnchorAvater
//
//  Created by LeeWong on 16/6/27.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,EArtAnchorClickType){
    EArtAnchorClickTypeAvater,
    EArtAnchorClickTypeFocus
};

@interface AnchorAvaterView : UIView

- (void)configAnchorAvaterView:(id)aContent;

@end
