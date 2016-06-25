//
//  AlertWindow.h
//  LiveAlertWindow
//
//  Created by LeeWong on 16/6/24.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSUInteger,EArtAlertWindowActionType){
    EArtAlertWindowActionTypeAvater,
    EArtAlertWindowActionTypeSource,
    EArtAlertWindowActionTypeTags,
    EArtAlertWindowActionTypeImageTap,
    EArtAlertWindowActionTypeNext,
    EArtAlertWindowActionTypeReport,
    EArtAlertWindowActionTypeFocus,
    EArtAlertWindowActionTypeClose,
    
};

@protocol AlertWindowDelegate <NSObject>

- (void)alertWindowActionType:(EArtAlertWindowActionType)aActionType;

@end

@interface AlertWindow : UIView

@property (nonatomic,weak) id<AlertWindowDelegate> delegate;

- (void)configAlertView:(id)aUser;

@end
