//
//  CHNetWorking.m
//  91Movie
//
//  Created by 陈欢 on 2018/3/25.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "CHNetWorking.h"

@interface CHNetWorking()



@end

@implementation CHNetWorking


static CHNetWorking *shareManager = nil;

static dispatch_once_t onceToken;



+ (CHNetWorking *)shareManager
{
    dispatch_once(&onceToken, ^{
        
        shareManager = [[CHNetWorking alloc]init];
        
    });
    
    return shareManager;
}

- (void)getUrl:(NSString *)url withBlock:(void (^)(NSData *, NSError *))block
{
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];[[NSURLCache sharedURLCache] removeCachedResponseForRequest:req];

    
    [req setURL:[NSURL URLWithString:url]];
    [req setHTTPMethod:@"get"];
    
    

    
    NSArray *userAgentArray = @[@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1",@"Mozilla/5.0 (X11; CrOS i686 2268.111.0) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11",@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1092.0 Safari/536.6",@"Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6",@"",@"",@"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/19.77.34.5 Safari/537.1",@"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5",@"Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5",@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",@"Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",@"Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",@"Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",@"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",@"Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.0 Safari/536.3",@"",@"",@"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24",@"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"];
    
    NSInteger random1 = arc4random() % 256;
    NSInteger random2 = arc4random() % 256;
    NSInteger random3 = arc4random() % 256;
    NSString *dian = @".";
    
    NSString *iprandom0 = [NSString stringWithFormat:@"%ld",random1];
    NSString *iprandom1 = [NSString stringWithFormat:@"%ld",random2];
    NSString *iprandom2 = [NSString stringWithFormat:@"%ld",random3];
    
    
    NSString *ip1 = [iprandom0 stringByAppendingString:dian];
    
    NSString *ip2 = [iprandom1 stringByAppendingString:dian];
    
    NSString *ip3 = iprandom2;
    
    NSString *ip = [ip1 stringByAppendingFormat:@"%@%@",ip2,ip3];
    
    NSLog(@"%@---------------------",ip);

    NSInteger x = arc4random() % userAgentArray.count ;
    NSString *userAgent = userAgentArray[x];
    
    NSString *forwarded = ip;
    
    [req setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [req setValue:forwarded forHTTPHeaderField:@"X-Forwarded-For"];
    [req setValue:@"zh-CN,zh;q=0.8,en;q=0.6" forHTTPHeaderField:@"Accept-Language"];
    [req setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    //req.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:req completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        
        //拿到响应头信息
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        
        //4.解析拿到的响应数据
        //NSLog(@"%@\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],res.allHeaderFields);
        
        block(data,nil);
    }];
    
     //NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    
    //config.HTTPAdditionalHeaders = @{@"Accept": @"application/json",@"Accept-Language": @"en",@"User-Agent": userAgent,@"X-Forwarded-For":forwarded};
    
    
        [dataTask resume];
    
    
        
    
    
}

@end
