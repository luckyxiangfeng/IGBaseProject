//
//  IGMainViewController.m
//  Iguama
//
//  Created by Kennith.Zeng on 2017/3/1.
//  Copyright © 2017年 Kennith.Zeng. All rights reserved.
//

#import "IGMainViewController.h"
#import "IGHomeViewController.h"
#import "IGQuoteViewController.h"
#import "IGDiscoverViewController.h"
#import "IGMineViewController.h"
#import "UIImage+IconFont.h"
#import "UITabBarItem+WZLBadge.h"
static CGFloat const ZU_HOMETAB_SIZE = 24.0f;
@interface IGMainViewController ()

@end

@implementation IGMainViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarController];
        
        self.tabBar.selectedImageTintColor =HEXCOLOR(0x272636);
        
        /**  //显示发现红点,V1.2之后隐藏
         UINavigationController  *discoverNav = self.viewControllers[0];
         UITabBarItem *curTabBarItem=discoverNav.tabBarItem;
         
         [RACObserve([ZURedBadgeManager shareManager], discover_unread_count) subscribeNext:^(NSNumber *unReadCount) {
         if ([unReadCount intValue]==0) {
         [curTabBarItem clearBadge];
         }
         else
         {
         if(iPhone6||iPhone6P)
         {
         curTabBarItem.badgeCenterOffset = CGPointMake(-30, 8);
         }
         else
         {
         curTabBarItem.badgeCenterOffset = CGPointMake(-20, 8);
         }
         [curTabBarItem showBadge];
         }
         }];*/
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma build home tabbar controller

- (void)setupTabBarController {
    /// 设置TabBar属性数组
    
    /*
    self.tabBarItemsAttributes = @[
                                   [self tabBarItemAttributeWithTitle:@"Home" IconFontCode:IG_HOMETAB_ICON_HOME],
                                   [self tabBarItemAttributeWithTitle:@"Quote" IconFontCode:IG__HOMETAB_ICON_QUOTE],
                                   [self tabBarItemAttributeWithTitle:@"Discover" IconFontCode:IG__HOMETAB_ICON_DISCOVER],
                                   [self tabBarItemAttributeWithTitle:@"Mine" IconFontCode:IG__HOMETAB_ICON_MINE],
                                   ];
    */
    self.tabBarItemsAttributes = @[
                                   [self tabBarItemAttributeWithTitle:@"Home" norImage:@"home_nor" selectImage:@"home_select"],
                                   [self tabBarItemAttributeWithTitle:@"Quote" norImage:@"quote_nor" selectImage:@"quote_select"],
                                   [self tabBarItemAttributeWithTitle:@"Discover" norImage:@"discover_nor" selectImage:@"discover_select"],
                                   [self tabBarItemAttributeWithTitle:@"Mine" norImage:@"mine_nor" selectImage:@"mine_select"],
                                   ];
    /// 设置控制器数组
    self.viewControllers = @[[self homeNavigationController],
                             [self quoteNavigationController],
                             [self discoverNavigationController],
                             [self mineNavigationController]];
    
    
    self.delegate = self;
    self.moreNavigationController.navigationBarHidden = YES;
}

- (UINavigationController*)homeNavigationController {
    
    IGHomeViewController *homeViewController = [[IGHomeViewController alloc]init];
    ZUNavigationController *homeNavigation = [[ZUNavigationController alloc] initWithRootViewController:homeViewController];
    return homeNavigation;
}

- (UINavigationController*)quoteNavigationController {
    IGQuoteViewController *quoteViewController = [[IGQuoteViewController alloc] init];
    ZUNavigationController *quoteNavigation = [[ZUNavigationController alloc] initWithRootViewController:quoteViewController];
    return quoteNavigation;
}

- (UINavigationController*)discoverNavigationController {
    IGDiscoverViewController *discoverViewController = [[IGDiscoverViewController alloc] init];
    ZUNavigationController *discoverNavigation = [[ZUNavigationController alloc] initWithRootViewController:discoverViewController];
    return discoverNavigation;
}

- (UINavigationController*)mineNavigationController {
    IGMineViewController* mineViewController = [[IGMineViewController alloc] init];
    ZUNavigationController* mineNavigation = [[ZUNavigationController alloc] initWithRootViewController:mineViewController];
    return mineNavigation;
}

- (NSDictionary*)tabBarItemAttributeWithTitle:(NSString*)title
                                 norImage:(NSString*)norImage
                                 selectImage:(NSString*)selectImage{
//    
//    UIImage* normalImage = [UIImage iconFontImageWithCode:code color:RGB(147, 147, 147) fontSize:ZU_HOMETAB_SIZE];
//    UIImage* selectedImage = [UIImage iconFontImageWithCode:code color:RGB(182, 65, 65) fontSize:ZU_HOMETAB_SIZE];
    UIImage *normalImage = [UIImage imageNamed:norImage];
    UIImage *selectedImage = [UIImage imageNamed:selectImage];
    return @{
             CYLTabBarItemTitle         : title,
             CYLTabBarItemImage         : normalImage,
             CYLTabBarItemSelectedImage : selectedImage,
             };
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UINavigationController*)viewController {
    BOOL isDiscover = [viewController.topViewController isKindOfClass:[IGDiscoverViewController class]];
    if (isDiscover) {
        return NO;
    }
    
    
    BOOL isMine = [viewController.topViewController isKindOfClass:[IGMineViewController class]];
    if (isMine) {
        return NO;
    }
    
   /*
    if (![ZULoginValidate isLogin]&&isHomeService)
    {
        [ZULogManager postLogWithOp_type:@"专属服务-未登录" content:@""];
        viewController.tabBarItem.badgeValue = nil;
        
    } else if (isHomeService)
    {
        [ZULogManager postLogWithOp_type:@"专属服务" content:@""];
    }
    */
    
    
    return YES;
}
@end
