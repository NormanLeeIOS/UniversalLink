//
//  UniversalLink.h
//  UniversalLink
//
//  Created by 李亚坤 on 2017/3/15.
//  Copyright © 2017年 chinaNews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UniversalLink : NSObject

/**
 url中获取的参数
 */
@property (nonatomic, strong, readonly) NSDictionary *params;

+ (UniversalLink *)sharedManager;

/**
 UniversalLink分发方法

 @param url url链接
 @return YES为成功打开wap或者获取参数，NO为未获取参数
 */
- (BOOL)universalLinkDispatchCenterWithURL:(NSURL *)url;

@end
