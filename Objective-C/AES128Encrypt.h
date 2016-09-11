//
//  AES128Encrypt.h
//  jiayuan
//
//  Created by Herui on 7/5/14.
//  Copyright 2014 jiayuan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AES128Encrypt : NSObject

+ (NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;
+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

@end
