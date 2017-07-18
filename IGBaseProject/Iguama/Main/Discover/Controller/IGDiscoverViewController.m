//
//  IGDiscoverViewController.m
//  Iguama
//
//  Created by Kennith.Zeng on 2017/3/1.
//  Copyright © 2017年 Kennith.Zeng. All rights reserved.
//

#import "IGDiscoverViewController.h"

@interface IGDiscoverViewController ()

@end

@implementation IGDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义导航栏
-(NSMutableAttributedString*)setTitle
{
    NSString *titleStr=@"Discover";
    
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

@end
