//
//  UIImage+IconFont.m
//
//  Created by Charles on 1/19/16.
//  Copyright © 2016 齐家网. All rights reserved.
//

#import "UIImage+IconFont.h"

@implementation UIImage (IconFont)

+ (UIImage *)fontImageWithCode:(NSString *)code color:(UIColor *)color fontName:(NSString *)fontName fontSize:(CGFloat)fontSize {

  UILabel *label = [[UILabel alloc] init];
  label.font = [UIFont fontWithName:fontName size:fontSize];
  label.text = code;
  label.textColor = color;
  [label sizeToFit];

  UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, 0.0);
  [[label layer] renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

+ (UIImage *)iconFontImageWithCode:(NSString *)code color:(UIColor *)color fontSize:(CGFloat)fontSize {
  return [self fontImageWithCode:code color:color fontName:ICON_FONT_NAME fontSize:fontSize];
}

@end
