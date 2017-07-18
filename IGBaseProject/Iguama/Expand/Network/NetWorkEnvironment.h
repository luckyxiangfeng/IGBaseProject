//
//  NetWorkEnvironment.h
//  MobileProject 枚举存放
//
//  Created by wujunyang on 16/1/5.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#ifndef NetWorkEnvironment_h
#define NetWorkEnvironment_h
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,SERVERCENTER_TYPE)
{
    ACCOUNT_SERVERCENTER,
    PICTURE_SERVERCENTER,
    BUSINESSLOGIC_SERVERCENTER,
    UPDATEVERSION_SERVERCENTER
};


typedef NS_ENUM(NSInteger, RequestType)
{
    GETMethod_JSON,
    POSTMethod_JSON,
};

typedef NS_ENUM(NSInteger,CENTER_TYPE)
{
    BABY_CENTER,
    MESSAGE_CENTER,
    SNS_CENTER,
    ACCOUNT_CENTER,
    PICTURE_CENTER,
    BUSINESSLOGIC_CENTER,
    UPDATEVERSION_CENTER,
};


#endif /* NetWorkEnvironment_h */
