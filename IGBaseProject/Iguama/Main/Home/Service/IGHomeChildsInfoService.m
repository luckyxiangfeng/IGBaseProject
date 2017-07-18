//
//  IGHomeChildsInfoService.m
//  Iguama
//
//  Created by Kennith.Zeng on 2017/3/6.
//  Copyright © 2017年 Kennith.Zeng. All rights reserved.
//

#import "IGHomeChildsInfoService.h"

@interface IGHomeChildsInfoService (){
       NSString *_index;
}
@end

@implementation IGHomeChildsInfoService
- (instancetype)initWithIndex:(NSString *)index
{
    if (self = [super init]) {
        _index = index;
    }
    return self;
}
- (NSString *)requestUrl {
    
    NSString *url = [NSString stringWithFormat:@"lookup?id=%@&country=cn&entity=software",_index];
    return url;
    
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

-(SERVERCENTER_TYPE)centerType
{
    return BUSINESSLOGIC_SERVERCENTER;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}
@end
