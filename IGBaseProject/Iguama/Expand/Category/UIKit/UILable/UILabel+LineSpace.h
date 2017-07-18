//
//  UILabel+LineSpace.h
//  zxptUser
//
//  Created by QJ_001 on 16/7/9.
//  Copyright © 2016年 qijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LineSpace)
- (void)setText:(NSString *)text WithLineSpace:(CGFloat)lineSpace;
- (void)setAutoAttributedLineSpaceText:(NSString *)text;
@end
