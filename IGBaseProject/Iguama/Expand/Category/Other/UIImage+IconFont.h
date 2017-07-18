//
//  UIImage+IconFont.h
//
//  Created by Charles on 1/19/16.
//  Copyright © 2016 齐家网. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ICON_FONT_NAME = @"jia-user";

@interface UIImage (IconFont)

/**
 *  iconfont font name is “iconfont”
 *  @param code     icon code
 *  @param color    color
 *  @param fontSize font size
 *  @return a icon font image
 */
+ (UIImage *)iconFontImageWithCode:(NSString *)code color:(UIColor *)color fontSize:(CGFloat)fontSize;

@end
