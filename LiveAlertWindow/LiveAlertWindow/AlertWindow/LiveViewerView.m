//
//  LiveViewerViewController.m
//  LiveViewer
//
//  Created by LeeWong on 16/6/23.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#import "LiveViewerView.h"
#import "LiveViewerCell.h"


static NSString *const CollectionViewCellIdentifier = @"cell";

@interface LiveViewerView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *viewerList;

@property (nonatomic,assign) EArtCollectionViewCellType aCellType;

@end

@implementation LiveViewerView


- (instancetype)initWithCellType:(EArtCollectionViewCellType)aType
{
    if (self = [super init]) {
        self.aCellType = aType;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.itemSize;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    
    [self.collectionView registerClass:[LiveViewerCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewerList.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LiveViewerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];

    NSString *url = self.viewerList[indexPath.item];
    
    [cell setAvaterImageURL:url type:self.aCellType];
    
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark -data
- (NSArray *)viewerList
{
    return @[@"http://ww1.sinaimg.cn/crop.3.45.1919.1919.1024/6b805731jw1em0hze051hj21hk1isn5k.jpg",@"http://f.hiphotos.baidu.com/zhidao/pic/item/962bd40735fae6cd5eb9228b0db30f2443a70fce.jpg",@"http://f.hiphotos.baidu.com/zhidao/pic/item/962bd40735fae6cd5eb9228b0db30f2443a70fce.jpg",@"http://f.hiphotos.baidu.com/zhidao/pic/item/962bd40735fae6cd5eb9228b0db30f2443a70fce.jpg",@"http://f.hiphotos.baidu.com/zhidao/pic/item/962bd40735fae6cd5eb9228b0db30f2443a70fce.jpg",@"http://f.hiphotos.baidu.com/zhidao/pic/item/962bd40735fae6cd5eb9228b0db30f2443a70fce.jpg",@"http://f.hiphotos.baidu.com/zhidao/pic/item/962bd40735fae6cd5eb9228b0db30f2443a70fce.jpg",@"http://f.hiphotos.baidu.com/zhidao/pic/item/962bd40735fae6cd5eb9228b0db30f2443a70fce.jpg",@"http://f.hiphotos.baidu.com/zhidao/pic/item/962bd40735fae6cd5eb9228b0db30f2443a70fce.jpg",@"http://f.hiphotos.baidu.com/zhidao/pic/item/962bd40735fae6cd5eb9228b0db30f2443a70fce.jpg"];
}


@end
