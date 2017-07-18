//
//  Macros.h
//  Iguama
//
//  Created by Kennith.Zeng on 2017/3/1.
//  Copyright © 2017年 Kennith.Zeng. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


// 是否大于IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否大于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)

// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define COLOR_RGB(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]

//常用色值
#define LINE_COLOR HEXCOLOR(0xe5e5e5)
#define PAGE_BACKGROUND_COLOR RGB(242,242,242)
#define COLOR_WORD_BLACK  HEXCOLOR(0x333333)
#define COLOR_WORD_GRAY_1  HEXCOLOR(0x666666)
#define COLOR_WORD_GRAY_2  HEXCOLOR(0x999999)
#define COLOR_WORD_GRAY_3  HEXCOLOR(0xcccccc)
#define COLOR_Navigation_BackGround HEXCOLOR(0xd23f3f)
#define COLOR_Navigation_BLUEBackGround HEXCOLOR(0x3bcceb)

///中文字体
// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]
///英文跟数字的字体
#define ENGLISH_NUMBER_FONT_NAME  @"Helvetica Neue"
#define ENGLISH_SYSTEM(x) [UIFont fontWithName:ENGLISH_NUMBER_FONT_NAME size:x]

//字体
#define kFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))
#define kFontESize(R)     ENGLISH_SYSTEM(AdaptedWidth(R))

// 界面宽高
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//不同屏幕尺寸字体适配
#define kScreenWidthRatio  (SCREEN_WIDTH / 320.0)
#define kScreenHeightRatio (SCREEN_HEIGHT / 568.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)


//获取状态栏高度
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#endif /* Macros_h */
