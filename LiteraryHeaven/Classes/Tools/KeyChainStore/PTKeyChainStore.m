//
//  PTKeyChainStore.m
//  PourOutAllTheWay
//
//  Created by SanW on 16/8/30.
//  Copyright © 2016年 ONON. All rights reserved.
//

#import "PTKeyChainStore.h"
NSString *const kKeyChainStore = @"news.onon.pourOutAllTheWay";

@implementation PTKeyChainStore
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}
/**
 *  存储
 *
 *  @param service <#service description#>
 *  @param data    <#data description#>
 */
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}
/**
 *  初始化
 *
 *  @param service <#service description#>
 *
 *  @return <#return value description#>
 */
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            
        } @finally {
            
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}
/**
 *  删除
 *
 *  @param service <#service description#>
 */
+ (void)deleteKeyData:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}
/**
 *  获取设备UUID
 *
 *  @return <#return value description#>
 */
+ (NSString *)UUID
{
    NSString * strUUID = (NSString *)[PTKeyChainStore load:kKeyChainStore];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        // 生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        strUUID =  [strUUID stringByReplacingOccurrencesOfString:@"-" withString:@""];
        //将该uuid保存到keychain
        [PTKeyChainStore save:kKeyChainStore data:strUUID];
    }
    return strUUID;
    
}
@end
