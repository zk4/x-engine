//
//  GlobalReqInnerNetworkDetectorFilter.m
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE./

#import "GlobalReqInnerNetworkDetectorFilter.h"
#import <arpa/inet.h>
#include <netdb.h>
#include <sys/socket.h>
#import "XENativeContext.h"
#import "iToast.h"
@implementation GlobalReqInnerNetworkDetectorFilter

+(int)isInnerIP:(NSString *)hostName
{
    BOOL bValid = false;
    bool _isInnerIp = false;
    //NSString to char*
    const char *webSite = [hostName cStringUsingEncoding:NSASCIIStringEncoding];
    if (webSite == NULL) {
        return -1;
    }
    // Get host entry info for given host
    struct hostent *remoteHostEnt = gethostbyname(webSite);
    if (remoteHostEnt == NULL) {
        return -1;
    }
    // Get address info from host entry
    struct in_addr *remoteInAddr = (struct in_addr *) remoteHostEnt->h_addr_list[0];
    if (remoteInAddr == NULL) {
        return -1;
    }
    // Convert numeric addr to ASCII string
    char *sRemoteInAddr = inet_ntoa(*remoteInAddr);
    if (sRemoteInAddr == NULL) {
        return -1;
    }
    NSLog(@"sRemoteInAddr:%s", sRemoteInAddr);
    unsigned int ipNum = str2intIP(sRemoteInAddr);

    unsigned int aBegin = str2intIP("10.0.0.0");
    unsigned int aEnd = str2intIP("10.255.255.255");
    unsigned int bBegin = str2intIP("172.16.0.0");
    unsigned int bEnd = str2intIP("172.31.255.255");
    unsigned int cBegin = str2intIP("192.168.0.0");
    unsigned int cEnd = str2intIP("192.168.255.255");
    NSLog(@"ipNum:%u", ipNum);
    _isInnerIp = IsInner(ipNum, aBegin, aEnd) || IsInner(ipNum, bBegin, bEnd) || IsInner(ipNum, cBegin, cEnd);
    if(_isInnerIp)  //( (a_ip>>24 == 0xa) || (a_ip>>16 == 0xc0a8) || (a_ip>>22 == 0x2b0) )
    {
        bValid = 1;//内网
    }else{
        bValid = 0;//外网
    }
    return bValid;
}
unsigned int str2intIP(char* strip) //return int ip
{
    unsigned int intIP;
    if(!(intIP = inet_addr(strip)))
    {
        perror("inet_addr failed./n");
        return -1;
    }
    return ntohl(intIP);
}

bool IsInner(unsigned int userIp, unsigned int begin, unsigned int end)
{
    return (userIp >= begin) && (userIp <= end);
}
+ (instancetype)sharedInstance {
    static GlobalReqInnerNetworkDetectorFilter * ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[GlobalReqInnerNetworkDetectorFilter alloc] init];
    });
    return ins;
}
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)response chain:(id<iKOFilterChain>) chain {
    
    if([GlobalReqInnerNetworkDetectorFilter isInnerIP:request.URL.host]){
        NSString* msg = [NSString stringWithFormat:@"%@ 解析到了内网地址",request.URL.absoluteString];
        [XENP(iToast) toast:msg];
    }
    [chain doFilter:session request:request response:response];
}


- (nonnull NSString *)name {
    return @"内网地址探测 filter";
}
@end
