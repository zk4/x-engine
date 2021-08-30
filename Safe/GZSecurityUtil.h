//
//  WYSecurityUtil.h
//  WuYan
//
//  Created by 吕冬剑 on 2017/4/13.
//  Copyright © 2017年 LvDvJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GZManageInterface.h"
static NSString *const RSAKEY = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCZV7zw10PK0LeyOi7BmO7fGjXq/8HRkyVBKbBbj/40KD1qpD48RMYiOZCrCmqtM4CuGnes4BjLCKuvnPbPhDuNOLK9ggcRuTzp8ThGpQC6+JZiYtsuxWBRQ0dgsj38Fk7ZI25/A4+MbTbpNzR85zsdesz6+yoIc8g5LlAmrwm3twIDAQAB";

@interface GZSecurityUtil : NSObject


/**
 *  加密方法
 *
 *  @param str   需要加密的字符串
 *  @param path  '.der'格式的公钥文件路径
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;

/**
 *  解密方法
 *
 *  @param str       需要解密的字符串
 *  @param path      '.p12'格式的私钥文件路径
 *  @param password  私钥文件密码
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;

/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)privKey;
/**
 *  编码方法
 *
 *  @param str     需要编码的字符串
 */
+ (NSString *)base64EncodedString:(NSString *)str;

/**
 *  解码方法
 *
 *  @param str     需要解码的字符串
 */
+ (NSString *)base64DecodedString:(NSString *)str;

/**
 *  md5方法
 *
 *  @param input     需要处理的字符串
 *  @return md5大写数值
 */
+ (NSString *)md5HexDigest:(NSString*)input;

/**
 *  DES编码
 *
 *  @param text     需要编码的字符串
 *  @param key      秘钥
 */
+(NSString*)encryptWithDES:(NSString*)text andKey:(NSString*)key;

/**
 *  md5方法
 *
 *  @param text     需要解码的字符串
 *  @param key      秘钥
 */
+(NSString*)decryptWithDES:(NSString*)text andKey:(NSString*)key;

/*
 文件MD5
 */
+ (NSString *)getFileMD5StrFromPath:(NSString *)path;

@end
