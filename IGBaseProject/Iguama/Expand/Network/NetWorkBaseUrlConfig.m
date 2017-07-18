//
//  NetWorkBaseUrlConfig.m
//  MobileProject
//
//  Created by wujunyang on 16/1/5.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "NetWorkBaseUrlConfig.h"

static NSString *const developer = @"developer";
static NSString *const product = @"product";

static NSString *const ACCOUNT_SERVERCENTER_Key=@"ACCOUNT_SERVERCENTER";
static NSString *const PICTURE_SERVERCENTER_key=@"PICTURE_SERVERCENTER";
static NSString *const BUSINESSLOGIC_SERVERCENTER_key=@"BUSINESSLOGIC_SERVERCENTER";
static NSString *const UPDATEVERSION_SERVERCENTER_key=@"UPDATEVERSION_SERVERCENTER";

@interface NetWorkBaseUrlConfig()
@property(nonatomic ,assign) SERVERCENTER_TYPE netType;
@property(nonatomic ,strong) NSMutableDictionary *configDictionary;
//开发测试环境
@property(nonatomic ,strong) NSDictionary *develpoerDictionary;
//产品环境
@property(nonatomic ,strong) NSDictionary *productDictionary;
@end

@implementation NetWorkBaseUrlConfig

+(instancetype)shareconfig
{
    static id share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[NetWorkBaseUrlConfig alloc] init];
    });
    
    return share;
}

-(id)init
{
    if (self == [super init]) {
        //测试环境
        self.develpoerDictionary=@{ACCOUNT_SERVERCENTER_Key:@"http://192.168.254.189:8082/mobile-user-service/",PICTURE_SERVERCENTER_key:@"http://zxpt.image.zx-erp.qeeka.com/image-service/",BUSINESSLOGIC_SERVERCENTER_key:@"http://192.168.254.189:8082/mobile-user-service/",UPDATEVERSION_SERVERCENTER_key:@"http://jia-blossom-erp-srv2.suryani.cn:8085/mobile-package-app-service/"};
        
        
        //产品环境
        self.productDictionary=@{ACCOUNT_SERVERCENTER_Key:@"https://mob-user.zxpt.api.zx-erp.qeeka.com/mobile-user-service/",PICTURE_SERVERCENTER_key:@"https://zxpt.image.zx-erp.qeeka.com/image-service/",BUSINESSLOGIC_SERVERCENTER_key:@"https://mob-user.zxpt.api.zx-erp.qeeka.com/mobile-user-service/",UPDATEVERSION_SERVERCENTER_key:@"https://mob-package.zxpt.api.zx-erp.qeeka.com:454/mobile-package-app-service/"};
        
        self.configDictionary = [NSMutableDictionary dictionary];
        [self.configDictionary setObject:self.develpoerDictionary forKey:developer];
        [self.configDictionary setObject:self.productDictionary forKey:product];
    }
    return self;
}

-(NSString*)urlWithCenterType:(SERVERCENTER_TYPE)type
{
    NSString *urlResult=@"";
    NSString *validEnvironment = @"";
    
    //过滤不同Tag
#ifdef Local
    validEnvironment=developer;
#elif Product||AppStore
    validEnvironment=product;
#endif
    
    NSString *urlKey = @"";
    switch (type) {
        case ACCOUNT_SERVERCENTER:
            urlKey = ACCOUNT_SERVERCENTER_Key;
            break;
        case PICTURE_SERVERCENTER:
            urlKey = PICTURE_SERVERCENTER_key;
            break;
        case BUSINESSLOGIC_SERVERCENTER:
            urlKey = BUSINESSLOGIC_SERVERCENTER_key;
            break;
        case UPDATEVERSION_SERVERCENTER:
            urlKey = UPDATEVERSION_SERVERCENTER_key;
            break;
        default:
            break;
    }
    urlResult = self.configDictionary[validEnvironment][urlKey];
    return urlResult;
}

@end
