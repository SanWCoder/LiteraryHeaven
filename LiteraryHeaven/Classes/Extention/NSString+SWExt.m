//
//  NSString+SWExt.m
//  LiteraryHeaven
//
//  Created by SanW on 2017/9/21.
//  Copyright © 2017年 ONON. All rights reserved.
//

#import "NSString+SWExt.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (SWExt)
    /**
     *  MD5加密
     *
     *  @return <#return value description#>
     */
- (NSString *)md5{
    
    const char *str = [self UTF8String];
    
    if (str == NULL)
    {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *md5String = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return md5String;
}
    
    @end
