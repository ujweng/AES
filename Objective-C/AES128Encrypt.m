//
//  AES128Encrypt.m
//  jiayuan
//
//  Created by Herui on 7/5/14.
//  Copyright 2014 jiayuan. All rights reserved.
//

#import "AES128Encrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import "NSData+Base64.h"

@implementation AES128Encrypt



+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key
{
    NSData *resultData = nil;
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        // resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        resultData = [[NSData alloc] initWithBytes:buffer length:numBytesEncrypted];
    }
    free(buffer);
    // return [Base64 stringByEncodingData:resultData];
    return [self hexStringFromData:resultData];
}

+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key
{
    NSData *resultData = nil;
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // NSData *data = [Base64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    // encryptText = [self stringFromHexString:encryptText];
    NSData *data = [NSData dataFromBase64String:encryptText];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        // resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        resultData = [[NSData alloc] initWithBytes:buffer length:numBytesCrypted];
        
    }
    free(buffer);
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
    
    
}

// 普通字符串转换为十六进

+ (NSString *)hexStringFromData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0; i<[data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i] & 0xff]; //16进制数
        newHexStr = [newHexStr uppercaseString];
        
        if([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
        }
        
        hexStr = [hexStr stringByAppendingString:newHexStr];
       
    } 
    return hexStr; 
}



@end
