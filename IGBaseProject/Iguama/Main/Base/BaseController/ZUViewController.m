//
//  ZUViewController.m
//  zxptuser
//
//  Created by warren on 3/15/16.
//  Copyright © 2016 warren. All rights reserved.
//

#import "ZUViewController.h"
#import "UIImage+Color.h"

@interface ZUViewController ()
{
    CGFloat navigationY;
    CGFloat navBarY;
    CGFloat verticalY;
    BOOL _isShowMenu;
    
}
@property CGFloat original_height;
@property(nonatomic ,strong)UIView *overlay;
@property(nonatomic, strong, readwrite) id viewModel;
@property(nonatomic, strong, readwrite) UIPercentDrivenInteractiveTransition* interactivePopTransition;
@end

@implementation ZUViewController

+ (instancetype)allocWithZone:(struct _NSZone*)zone {
    ZUViewController* viewController = [super allocWithZone:zone];

    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)]
                     subscribeNext:^(id x) {
                         @strongify(viewController)
                         [viewController bindViewModel];
                     }];

    return viewController;
}

- (void)bindViewModel {
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Being popped, take a snapshot
    if ([self isMovingFromParentViewController]) {
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark --custome NavBar

-(id)init
{
    if (self == [super init]) {

        [self.navigationController setNavigationBarHidden:YES];
        navBarY = 0;
        navigationY = 0;
        
        //设置返回按钮
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = item;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = PAGE_BACKGROUND_COLOR;
    
    if ([self respondsToSelector:@selector(backgroundImage)]) {
        UIImage *bgimage = [self backgroundImage];
        [self setNavigationBack:bgimage];
    }
    if ([self respondsToSelector:@selector(setTitle)]) {
        NSMutableAttributedString *titleAttri = [self setTitle];
        [self set_Title:titleAttri];
    }
    if (![self leftButton]) {
        [self configLeftBaritemWithImage];
    }
    
    if (![self rightButton]) {
        [self configRightBaritemWithImage];
    }
    
    //去掉系统自带的黑边
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)resTitle:(NSMutableAttributedString *)title{
  
    [self set_Title:title];
}

- (void)resRightButton:(UIButton *)btn{
    
    if(btn){
        UIButton *right_button = btn;
        [right_button addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:right_button];
        self.navigationItem.rightBarButtonItem = item;
    }
    else{
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
    }

}
- (void)resLeftButton:(UIButton *)btn{

    if(btn){
        UIButton *leftbutton = btn;
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }
    else{
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIColor *backgroundColor = nil;
    [self.navigationController.navigationBar setTranslucent:NO];
    if ([self respondsToSelector:@selector(set_colorBackground)]) {
       backgroundColor =  [self set_colorBackground];
    }else{
        
      backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_bg"]];
        
    }
    UIImage *bgimage = [UIImage imageWithColor:backgroundColor];
    
    [self.navigationController.navigationBar setBackgroundImage:bgimage forBarMetrics:UIBarMetricsDefault];
//    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.navigationController.navigationBar.bounds) + 20)];
//    self.overlay.userInteractionEnabled = NO;
//    self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    [self.navigationController.navigationBar insertSubview:self.overlay atIndex:0];
//    self.overlay.backgroundColor = backgroundColor;
    //以上先注释，在导航栏的- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated； 添加self.view.backgroundColor = [UIColor whiteColor];解决push嘿影问题


    if ([backgroundColor isEqual:COLOR_Navigation_BackGround]||[backgroundColor isEqual:COLOR_Navigation_BLUEBackGround]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
    
    //设置导航栏分割线
    [self showOrNotNavSeparateLine];
}

- (void)showOrNotNavSeparateLine
{
    BOOL isShowNavSeparateLine;
    if ([self respondsToSelector:@selector(showNavSeparateLine)]) {
        isShowNavSeparateLine =  [self showNavSeparateLine];
    }else{
        isShowNavSeparateLine = NO;
    }

    [(ZUNavigationController *)self.navigationController isShowNavSeparateLine:isShowNavSeparateLine];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



-(void)setNavigationBack:(UIImage*)image
{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image ];
    [self.navigationController.navigationBar setShadowImage:image];
    
}



#pragma mark --- NORMAl

-(void)set_Title:(NSMutableAttributedString *)title
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    label.numberOfLines=1;//可能出现多行的标题
    [label setAttributedText:title];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
    [label addGestureRecognizer:tap];
    self.navigationItem.titleView = label;
    
}


-(void)titleClick:(UIGestureRecognizer*)Tap
{
    
    UIView *view = Tap.view;
    if ([self respondsToSelector:@selector(title_click_event:)]) {
        [self title_click_event:view];
    }
}

#pragma mark -- left_item
-(void)configLeftBaritemWithImage
{
    if ([self respondsToSelector:@selector(set_leftBarButtonItemWithImage)]) {
        UIImage *image = [self set_leftBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleBordered target:self  action:@selector(left_click:)];
        self.navigationItem.backBarButtonItem = item;
    }
}

-(void)configRightBaritemWithImage
{
    if ([self respondsToSelector:@selector(set_rightBarButtonItemWithImage)]) {
        UIImage *image = [self set_rightBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleBordered target:self  action:@selector(right_click:)];
        self.navigationItem.rightBarButtonItem = item;
    }
}


#pragma mark -- left_button
-(BOOL)leftButton
{
    BOOL isleft =  [self respondsToSelector:@selector(set_leftButton)];
    if (isleft) {
        UIButton *leftbutton = [self set_leftButton];
        if (leftbutton) {
            [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
            self.navigationItem.leftBarButtonItem = item;
        }
        else
        {
            self.navigationItem.hidesBackButton = YES;
        }
    }else{
        UIButton *left_button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
        [left_button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [left_button setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
        [left_button addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:left_button];
        self.navigationItem.leftBarButtonItem = item;
    }
    return isleft;
}


#pragma mark -- right_button
-(BOOL)rightButton
{
    BOOL isright = [self respondsToSelector:@selector(set_rightButton)];
    if (isright) {
        UIButton *right_button = [self set_rightButton];
        [right_button addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:right_button];
        self.navigationItem.rightBarButtonItem = item;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.customView.hidden=YES;
    }
    return isright;
}


-(void)left_click:(id)sender
{
    if ([self respondsToSelector:@selector(left_button_event)]) {
        [self left_button_event];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)right_click:(id)sender
{
    if ([self respondsToSelector:@selector(right_button_event:)]) {
        [self right_button_event:sender];
    }
}

-(void)changeNavigationBarHeight:(CGFloat)offset
{
    [UIView animateWithDuration:0.3f animations:^{
        self.navigationController.navigationBar.frame  = CGRectMake(
                                                                    self.navigationController.navigationBar.frame.origin.x,
                                                                    navigationY,
                                                                    self.navigationController.navigationBar.frame.size.width,
                                                                    self.navigationController.navigationBar.frame.size.height-offset
                                                                    );
        verticalY = verticalY+offset;
        [self.navigationItem.leftBarButtonItem setBackgroundVerticalPositionAdjustment:verticalY forBarMetrics:UIBarMetricsDefault];
        [self.navigationItem.rightBarButtonItem setBackgroundVerticalPositionAdjustment:verticalY forBarMetrics:UIBarMetricsDefault];
        
    }];
    
}

-(void)changeNavigationBarTranslationY:(CGFloat)translationY
{
    self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, translationY);
}

-(void)setContentAlpha:(CGFloat)alpha
{
    for (UIView *subview in self.navigationController.navigationBar.subviews) {
        subview.alpha = alpha;
    }
}

@end
