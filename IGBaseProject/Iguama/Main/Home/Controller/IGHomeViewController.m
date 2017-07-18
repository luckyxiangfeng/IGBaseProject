//
//  IGHomeViewController.m
//  Iguama
//
//  Created by Kennith.Zeng on 2017/3/1.
//  Copyright © 2017年 Kennith.Zeng. All rights reserved.
//

#import "IGHomeViewController.h"
#import "ZJScrollPageView.h"
#import "IGHomeChildViewController.h"

@interface IGHomeViewController()


@property (nonatomic, strong) ZJSegmentStyle *segmentStyle;
@property (nonatomic, strong) ZJScrollPageView *scrollPageView;
@end

@implementation IGHomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self layoutUI];

}

- (void)layoutUI{

    if (!_segmentStyle) {
        _segmentStyle = [[ZJSegmentStyle alloc] init];
        //显示滚动条
        _segmentStyle.showLine = YES;
        // 颜色渐变
        _segmentStyle.gradualChangeTitleColor = YES;
        _segmentStyle.segmentHeight = 30;
        _segmentStyle.selectedTitleColor = HEXCOLOR(0x1377cc);
        _segmentStyle.normalTitleColor = HEXCOLOR(0x333333);
        _segmentStyle.scrollLineColor = HEXCOLOR(0x1377cc);
    }

    if(!_scrollPageView){
        // 设置子控制器 --- 注意子控制器需要设置title, 将用于对应的tag显示title
        NSArray *childVcs = [NSArray arrayWithArray:[self setupChildVcAndTitle]];
        // 初始化
        _scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64.5) segmentStyle:_segmentStyle childVcs:childVcs parentViewController:self];
        
        [self.view addSubview:_scrollPageView];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)setupChildVcAndTitle {
    
    NSArray *array = @[@"最新", @"独家活动",@"精选好文",@"女款精品",@"男款精品"];
    NSMutableArray *childVcs = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        IGHomeChildViewController *childView = [[IGHomeChildViewController alloc] init];
        childView.title = array[i];
        childView.view.backgroundColor = PAGE_BACKGROUND_COLOR;
        [childVcs addObject:childView];
    }
    return childVcs;
}

#pragma mark - 自定义导航栏
-(NSMutableAttributedString*)setTitle
{
    NSString *titleStr=@"Home";
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x333333) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:kFontESize(18) range:NSMakeRange(0, title.length)];
    
    return title;
}
//不显示左按钮
- (UIButton *)set_leftButton
{
    return nil;
}
- (BOOL)showNavSeparateLine{
    return YES;
}
@end
