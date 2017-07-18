//
//  IGHomeChildViewCell.m
//  Iguama
//
//  Created by Kennith.Zeng on 2017/3/1.
//  Copyright © 2017年 Kennith.Zeng. All rights reserved.
//

#import "IGHomeChildViewCell.h"

@interface IGHomeChildViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UILabel *discountLab;
@property (nonatomic, strong) UILabel *recomendLab;
@end

@implementation IGHomeChildViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        
    }
    
    return self;
}

-(void)layoutUI
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(120);
        }];
        
    }
    
    if (!_dateLab) {
        _dateLab = [[UILabel alloc] init];
        _dateLab.font = kFontSize(13);
        _dateLab.textColor = HEXCOLOR(0x727272);
        _dateLab.textAlignment = NSTextAlignmentRight;
        _dateLab.numberOfLines = 1;
        _dateLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_dateLab];
        [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        }];
    }
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont boldSystemFontOfSize:16];
        _titleLab.textColor = HEXCOLOR(0x333333);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 2;
        _titleLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_dateLab.mas_bottom).offset(10);
            make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
            make.right.mas_equalTo(-15);
        }];
    }
    
    if (!_discountLab) {
        _discountLab = [[UILabel alloc] init];
        _discountLab.font = kFontSize(13);
        _discountLab.textColor = HEXCOLOR(0x727272);
        _discountLab.textAlignment = NSTextAlignmentRight;
        _discountLab.numberOfLines = 1;
        _discountLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_discountLab];
        [_discountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLab.mas_bottom).offset(10);
            make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(15);
        }];
    }
    
    if (!_recomendLab) {
        _recomendLab = [[UILabel alloc] init];
        _recomendLab.font = kFontSize(13);
        _recomendLab.textColor = HEXCOLOR(0x727272);
        _recomendLab.textAlignment = NSTextAlignmentRight;
        _recomendLab.numberOfLines = 1;
        _recomendLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_recomendLab];
        [_recomendLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_discountLab.mas_bottom).offset(10);
            make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(15);
        }];
    }
    
    
}


- (void)configData:(id)data{

    [_iconImageView setImage:[UIImage imageNamed:@"iconImage2.jpg"]];
    _dateLab.text = @"2017/03/01";
    _titleLab.text = @"谁家免费送价值$250的17件套大礼包？";
    _discountLab.text = @"点我查看";
    _recomendLab.text = @"小吉 推荐";
    

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
