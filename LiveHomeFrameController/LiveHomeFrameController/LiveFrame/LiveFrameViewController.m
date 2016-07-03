//
//  LiveFrameViewController.m
//  LiveHomeFrameController
//
//  Created by LeeWong on 16/6/25.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "LiveFrameViewController.h"
#import "ArtWorkFilterModel.h"
#import "ViewController.h"
#import "ArtScrollTab.h"

@interface LiveFrameViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController* pageViewController;
@property (nonatomic, strong) ArtScrollTab* scrollTab;
@property (nonatomic, strong) ArtWorkFilterModel *workFilterModel;
@property (nonatomic, assign) BOOL pageDoingScroll;
@property (nonatomic, assign) BOOL isCurrentPage;
@end

@implementation LiveFrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.workFilterModel = [ArtWorkFilterModel shared];
    [self buildMainView];
    
}

- (void)buildMainView
{
    ArtScrollTab* scrollTab = [[ArtScrollTab alloc] initWithFrame:CGRectZero];
    scrollTab.backgroundColor = [UIColor greenColor];
    self.scrollTab = scrollTab;
    [self.view addSubview:scrollTab];
    [scrollTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(@([ArtScrollTab height]));
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    

    
    
    NSMutableArray* items = [NSMutableArray array];
    [self.workFilterModel.categoryList enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
        [items addObject:[[UITabBarItem alloc] initWithTitle:obj[@"name"] image:nil tag:0]];
    }];
    
    [scrollTab setTabItems:items];
    
//    WEAKSELF(weakSelf);
    [self.workFilterModel setContentViewController:^UIViewController *(NSDictionary *info) {
        ViewController *controller = [[ViewController alloc] init];
        controller.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255. green:arc4random_uniform(255)/255. blue:arc4random_uniform(255)/255. alpha:1.];
        return controller;
    }];
    
    @weakify(self)
    [RACObserve(scrollTab, currentIndex) subscribeNext:^(NSNumber* aIndex) {
        //1.点击切换分类 idx得到的是切换之前的分类的index aIndex是当前点击的分类的index
        //2.滑动切换分类 idx得到的是切换之后的分类的index aIndex是切换之后的分类的index
        //用isCurrentPage 来标记是通过哪种方式来切换分类的
        @strongify(self)
        NSInteger idx = [self.workFilterModel indexOfPageController:self.pageViewController.viewControllers.firstObject];
        if (idx != [aIndex integerValue]) {
            _pageDoingScroll = YES;
            UIViewController* vc = [self.workFilterModel pageControllerAtIndex:[aIndex integerValue]];
            [self.pageViewController setViewControllers:@[vc]
                                              direction:UIPageViewControllerNavigationDirectionForward
                                               animated:NO
                                             completion:^(BOOL finished) {
                                                 _pageDoingScroll = NO;
                                             }];

        } else {
            if (!self.isCurrentPage) {
                ViewController* vc = (ViewController *)[self.workFilterModel pageControllerAtIndex:[aIndex integerValue]];
                if ([vc isKindOfClass:[ViewController class]]) {
                   //可以实现返回到顶部
                }
            }else
            {
                self.isCurrentPage = NO;
            }
        }
    }];
    

    
    
    self.scrollTab = scrollTab;
    RAC(self.workFilterModel, categoryListIndex) = RACObserve(self.scrollTab, currentIndex);
    
    
    
    [self createPageViewPageIndex:0];
}


- (void)createPageViewPageIndex:(NSInteger)aIndex
{
    NSDictionary* options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
    self.pageViewController.dataSource = self;
    
    [self addChildViewController:self.pageViewController];
    
    [self.pageViewController setViewControllers:@[[self.workFilterModel pageControllerAtIndex:aIndex]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    [self.pageViewController didMoveToParentViewController:self];
    
    UIView* view = [self.pageViewController view];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(self.scrollTab.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.pageViewController.delegate = self;
    
}

#pragma mark - UIPageViewControllerDelegate UIPageViewControllerDataSource

- (UIViewController*)pageViewController:(UIPageViewController*)pageViewController viewControllerBeforeViewController:(UIViewController*)viewController
{
    NSInteger idx = [self.workFilterModel indexOfPageController:viewController];
    return [self.workFilterModel pageControllerAtIndex:idx - 1];
}

- (UIViewController*)pageViewController:(UIPageViewController*)pageViewController viewControllerAfterViewController:(UIViewController*)viewController
{
    NSInteger idx = [self.workFilterModel indexOfPageController:viewController];
    return [self.workFilterModel pageControllerAtIndex:idx + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (finished) {
        NSInteger idx = [self.workFilterModel indexOfPageController:pageViewController.viewControllers.firstObject];
        self.scrollTab.currentIndex = idx;
        
        [self.workFilterModel removeMoreCachedViewController:idx];
    }
}


@end
