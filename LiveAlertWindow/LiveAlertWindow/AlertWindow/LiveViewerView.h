//
//  LiveViewerViewController.h
//  LiveViewer
//
//  Created by LeeWong on 16/6/23.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveDefine.h"
@interface LiveViewerView : UIViewController

- (instancetype)initWithCellType:(EArtCollectionViewCellType)aType;

@property (nonatomic,assign) CGSize itemSize;
@end
