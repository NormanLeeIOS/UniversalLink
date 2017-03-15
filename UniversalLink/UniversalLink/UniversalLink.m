//
//  UniversalLink.m
//  UniversalLink
//
//  Created by 李亚坤 on 2017/3/15.
//  Copyright © 2017年 . All rights reserved.
//

#import "UniversalLink.h"
#import <UIKit/UIKit.h>

@interface UniversalLink ()

@property (nonatomic, strong) NSDictionary *params;

@end

@implementation UniversalLink

+ (UniversalLink *)sharedManager
{
    static UniversalLink *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

- (BOOL)universalLinkDispatchCenterWithURL:(NSURL *)url
{
    if (!url.host) {
        return NO;
    }
    
    NSString *urlStr = [url absoluteString];
    NSString *linkAddrDecoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)urlStr, CFSTR(""), kCFStringEncodingUTF8);
    NSString *query = [[NSURL URLWithString:linkAddrDecoded] query];
    
    if (query) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        for (NSString *param in [query componentsSeparatedByString:@"&"]) {
            NSArray *elts = [param componentsSeparatedByString:@"="];
            if ([elts count] < 2) {
                continue;
            }
            [params setObject:[elts lastObject] forKey:[elts firstObject]];
        }
        
        if ([params count] > 0) {
            self.params = [NSDictionary dictionaryWithDictionary:params];
        } else {
            return NO;  //无参数,只有一个domian
        }
    } else {
        // 无参数打开wap页
        [[UIApplication sharedApplication] openURL:url
                                           options:@{}
                                 completionHandler:nil];
    }
    return YES;
}

@end
