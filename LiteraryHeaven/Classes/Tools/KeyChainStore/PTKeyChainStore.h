//
//  PTKeyChainStore.h
//  PourOutAllTheWay
//
//  Created by SanW on 16/8/30.
//  Copyright © 2016年 ONON. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTKeyChainStore : NSObject
/**
 *  存储
 *
 *  @param service <#service description#>
 *  @param data    <#data description#>
 */
+ (void)save:(NSString *)service data:(id)data;
/**
 *  初始化
 *
 *  @param service <#service description#>
 *
 *  @return <#return value description#>
 */
+ (id)load:(NSString *)service;
/**
 *  删除
 *
 *  @param service <#service description#>
 */
+ (void)deleteKeyData:(NSString *)service;
/**
 *  获取设备UUID
 *
 *  @return <#return value description#>
 */
+ (NSString *)UUID;
@end
