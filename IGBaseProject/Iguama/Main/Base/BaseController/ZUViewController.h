//
//  ZUViewController.h
//  zxptuser
//
//  Created by warren on 3/15/16.
//  Copyright © 2016 warren. All rights reserved.
//

@protocol  ZUBaseViewControllerDataSource<NSObject>
@optional
-(NSInteger)numberOfLeft_buttons;
//-(UIImage*)setNavi_bg_image;
-(NSMutableAttributedString*)setTitle;
-(UIButton*)set_leftButton;
-(UIButton*)set_rightButton;
-(UIColor*)set_colorBackground;
-(CGFloat)set_navigationHeight;
-(UIView*)set_bottomView;
//-(UISegmentedControl*)set_title_segments;
-(BOOL)showNavDopMenu;
-(UIImage*)backgroundImage;
-(CGFloat)set_leftBarButtonItemVerticalPosition;
-(CGFloat)set_rightBarButtonItemVerticalPosition;
-(UIImage*)set_leftBarButtonItemWithImage;
-(UIImage*)set_rightBarButtonItemWithImage;
-(BOOL)showNavSeparateLine;
@end


@protocol ZUBaseViewControllerDelegate <NSObject>


@optional
//-(void)left_button_didselectWithIndex:(NSInteger)index;
-(void)left_button_event;
-(void)right_button_event;
-(void)right_button_event:(UIButton*)sender;
-(void)title_click_event:(UIView*)sender;
@end

@interface ZUViewController: UIViewController<ZUBaseViewControllerDataSource,ZUBaseViewControllerDelegate>

/// The `viewModel` parameter in `-initWithViewModel:` method.
@property(nonatomic, strong, readonly) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property(nonatomic, strong) UIView *snapshot;


///
/// 此bindViewModel方法将在`-viewDidLoad`方法执行完毕后执行
///
- (void)bindViewModel;
- (void)resTitle:(NSMutableAttributedString *)title;
- (void)resRightButton:(UIButton *)btn;
- (void)resLeftButton:(UIButton *)btn;

-(void)set_Title:(NSMutableAttributedString *)title;
@end
