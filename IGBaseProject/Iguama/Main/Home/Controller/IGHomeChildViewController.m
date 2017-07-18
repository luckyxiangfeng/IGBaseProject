//
//  IGHomeChildViewController.m
//  Iguama
//
//  Created by Kennith.Zeng on 2017/3/1.
//  Copyright © 2017年 Kennith.Zeng. All rights reserved.
//

#import "IGHomeChildViewController.h"
#import "IGHomeChildViewCell.h"
#import "SDCycleScrollView.h"
@interface IGHomeChildViewController ()<UITableViewDataSource, UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) SDCycleScrollView *bannerView;

@end

@implementation IGHomeChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTableView];
    // Do any additional setup after loading the view.
}

- (void)creatTableView{
    if(!_dataList)
    {
        _dataList=[[NSMutableArray alloc]init];
    }
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = HEXCOLOR(0xffffff);
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator=NO;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_myTableView registerClass:[IGHomeChildViewCell class] forCellReuseIdentifier:NSStringFromClass([IGHomeChildViewCell class])];
        _myTableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _myTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [_myTableView.mj_header beginRefreshing];
        [self.view addSubview:_myTableView];
        [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    

    [self creatBannerView];

}
- (void)creatBannerView{
    
    NSArray *imagesURLStrings = @[
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488365628184&di=129f7d1912dadd57b1f426df965d11ea&imgtype=0&src=http%3A%2F%2Fpic10.nipic.com%2F20101016%2F2993280_145938045687_2.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488365628181&di=430eccd077bd37cbe8fb240000783ff0&imgtype=0&src=http%3A%2F%2Fpic1a.nipic.com%2F2009-01-08%2F200918134444639_2.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488365628185&di=1774dec263b08cdc6ba22c726b073121&imgtype=0&src=http%3A%2F%2Fpic1.shejiben.com%2Fcase%2F2015%2F11%2F03%2F20151103162050-a991d121.jpg",
                                  ];
//    NSArray *titles = @[@"测试标题1 ",
//                        @"测试标题2",
//                        @"测试标题3",
//                        @"测试标题4"
//                        ];
    if(!_bannerView){
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        _bannerView.titlesGroup = titles;
        _bannerView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        self.myTableView.tableHeaderView = _bannerView;
    }
      _bannerView.imageURLStringsGroup = imagesURLStrings;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    [_myTableView.mj_header endRefreshing];
}

- (void)loadMoreData{


}
#pragma mark -
#pragma mark UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IGHomeChildViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IGHomeChildViewCell class]) forIndexPath:indexPath];
    [cell configData:nil];
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}
//

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGB(242, 242, 242);
    return view;
}



#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

// 滚动到第几张图回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
   // NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
}

@end
