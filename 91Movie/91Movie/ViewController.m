//
//  ViewController.m
//  91Movie
//
//  Created by 陈欢 on 2018/3/25.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "ViewController.h"
#import <TFHpple.h>
#import "CHNetWorking.h"
#import "CHTableViewCell.h"
#import <MJExtension.h>
#import "CHPronModel.h"
#import "CHVIdeoViewController.h"
#import <MJRefresh.h>
#import <Ono.h>
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *chTableview;

@property (nonatomic, copy) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   /// [self setUpData];
    [self test];
    
//
//    NSString *url91 = @"http://91.91p18.space";
//
//    [self.chTableview registerNib:[UINib nibWithNibName:@"CHTableViewCell" bundle:nil] forCellReuseIdentifier:@"chhhh"];
//
//    [[CHNetWorking shareManager]getUrl:url91 withBlock:^(NSData *data, NSError *error) {
//
//
//
//
//        NSMutableArray * array = [NSMutableArray array];
//        NSMutableArray * array1 = [NSMutableArray array];
//        NSMutableArray * array2 = [NSMutableArray array];
//        NSMutableArray * array3 = [NSMutableArray array];
//
//        TFHpple *xpathHtml = [[TFHpple alloc]initWithHTMLData:data];
//
//        NSArray *urlArray = [xpathHtml searchWithXPathQuery:@"//div[@id='tab-featured']"];
//
//        TFHppleElement *element = [urlArray objectAtIndex:0];
//
//        NSArray *hhhh = [element childrenWithTagName:@"p"];
//
//        NSArray *imgArray = [xpathHtml searchWithXPathQuery:@"//img"];
//
//        NSArray *dataArray = [xpathHtml searchWithXPathQuery:@"//span"];
//
//
//
//
//
//
//
//                for (TFHppleElement *element in dataArray) {
//                    if ([[element objectForKey:@"class"] isEqualToString:@"title"]) {
//
//                        [array1 addObject:element.text];
//
//                    }
//                }
//
//
//                for (TFHppleElement *imgEle in imgArray) {
//                    if ([[imgEle objectForKey:@"class"] isEqualToString:@"moduleFeaturedThumb"]) {
//
//                        [array2 addObject:[imgEle objectForKey:@"src"]];
//
//                    }
//                }
////
////
////
//                for (TFHppleElement *urlEle in hhhh) {
//                    //*[@id="tab-featured"]/p[1]/a[1]
//
//                    NSArray *urlArray = [urlEle childrenWithTagName:@"a"];
//
//                    TFHppleElement *urlString = urlArray.firstObject;
//                    [array3 addObject:[urlString objectForKey:@"href"]];
//                    //NSLog(@"%@", [urlString objectForKey:@"href"]);
//                    //[dic setObject:[urlString objectForKey:@"href"] forKey:@"showUrl"];
//                    //[array addObject:dic];
//                }
//        for (int i = 0; i< hhhh.count; i++) {
//
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//
//            [dic setObject:array1[i] forKey:@"title"];
//            [dic setObject:array2[i] forKey:@"imageUrl"];
//            [dic setObject:array3[i] forKey:@"showUrl"];
//            [array addObject:dic];
//
//        }
//
//
//
//
//
//
//
//
//
//
//        self.array = [CHPronModel mj_objectArrayWithKeyValuesArray:array];
//        if (_array) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_chTableview reloadData];
//            });
//        }
//
//        //[[NSURLCache sharedURLCache] removeAllCachedResponses];
//
//
//
//
//
//    }];
    
//    NSMutableArray * arrayName = [NSMutableArray array];
//    
//    NSMutableArray * array = [NSMutableArray array];
//    
//    //[array removeAllObjects];
//    
////    for (int i = 0; i< 10; i++) {
////        
////        NSString * str = [NSString stringWithFormat:@"name%i",i];
////        
////        [arrayName addObject:str];
////        
////    }
//    
//    
//    // 方式一 在for循环内初始化字典dict，每次循环都初始化一个新字典，并在循环内加入数组，数组存了10个不同的字典
//    
//    for (int i = 0; i< 10; i++) {
//        
//        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//        
//        NSString * value = [NSString stringWithFormat:@"Female%04i.JPG",i];
//        
//        //NSString * key = arrayName[i];
//        
//        [dict setObject:value forKey:@"key"];
//        
//        [array addObject:dict];
//        
//    }
//    
//    
//    
//    NSLog(@"%@*************",array);
//    
//    
//    
//    // 方式二 在for循环外初始化字典dict，再循环外初始化可变字典，在循环内每次循环在字典内添加键值对，将存有十个键值对的一个字典赋给数组
//    
//    NSMutableArray * array2 = [NSMutableArray array];
//    
//    NSMutableDictionary * dict2 = [NSMutableDictionary dictionary];
//    
//    for (int i = 0; i< 10; i++) {
//        
//        
//        
//        NSString * value = [NSString stringWithFormat:@"Female%04i.JPG",i];
//        
//        //NSString * key = arrayName[i];
//        
//        [dict2 setObject:value forKey:@"key"];
//        
//        
//        
//    }
//    
//    [array2 addObject:dict2];
//    
//    NSLog(@"%@____________",array2);
    
    
    
}


- (void)test
{
     NSString *url91 = @"http://91.91p18.space/index.php";
    
    [[CHNetWorking shareManager]getUrl:url91 withBlock:^(NSData *data, NSError *error) {
        
        
        ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:data error:&error];
        NSString * olPath = @"//title";
        
        
        //ONOXMLElement * olELement = [document chil];
            NSLog(@"%@", document);
        //}
        
//        //NSString *currectString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        //NSData *gggg = [data dataUsingEncoding:NSUTF8StringEncoding]
//        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//            NSString *postHtmlStr = [[NSString alloc] initWithData:data encoding:gbkEncoding];
//
//             NSString *uft8HtmlStr = [postHtmlStr stringByReplacingOccurrencesOfString:@"<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=gb2312\">" withString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];
//             NSData *utf8HtmlData = [uft8HtmlStr dataUsingEncoding:NSUTF8StringEncoding];
//
//        TFHpple *videobox = [[TFHpple alloc]initWithHTMLData:utf8HtmlData];
//        //*[@id="videobox"] //*[@id="videobox"]/table/tbody/tr/td/div[1] //*[@id="videobox"]/table/tbody/tr/td/div[17]/a/span
//       // NSArray *videoAll = [videobox searchWithXPathQuery:@"//span"];
//        //TFHppleElement *element = [videoAll ];
//        NSLog(@"%@",uft8HtmlStr);
//        NSArray *dataArray = [videobox searchWithXPathQuery:@"//div"];
//
//        for (TFHppleElement *element in dataArray) {
//                                if ([[element objectForKey:@"class"] isEqualToString:@"listchannel"]) {
//
//                                    //[array1 addObject:element.text];
//                                   NSLog(@"%@",element.raw);
//
//                                }
//                            }
        
        
        
        
        
        
        
       
        
    }];
}


- (void)setUpData
{
    self.chTableview.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(upNewData)];
    [self.chTableview.mj_header beginRefreshing];
}

- (void)upNewData
{
    
    
    [self.chTableview.mj_footer endRefreshing];
    NSString *url91 = @"";
    
    [self.chTableview registerNib:[UINib nibWithNibName:@"CHTableViewCell" bundle:nil] forCellReuseIdentifier:@"chhhh"];
    
    [[CHNetWorking shareManager]getUrl:url91 withBlock:^(NSData *data, NSError *error) {
        
        
        
        
        NSMutableArray * array = [NSMutableArray array];
        NSMutableArray * array1 = [NSMutableArray array];
        NSMutableArray * array2 = [NSMutableArray array];
        NSMutableArray * array3 = [NSMutableArray array];
        
        TFHpple *xpathHtml = [[TFHpple alloc]initWithHTMLData:data];
        
        NSArray *urlArray = [xpathHtml searchWithXPathQuery:@"//div[@id='tab-featured']"];
        
        TFHppleElement *element = [urlArray objectAtIndex:0];
        
        NSArray *hhhh = [element childrenWithTagName:@"p"];
        
        NSArray *imgArray = [xpathHtml searchWithXPathQuery:@"//img"];
        
        NSArray *dataArray = [xpathHtml searchWithXPathQuery:@"//span"];
        
        
        
        
        
        
        
        for (TFHppleElement *element in dataArray) {
            if ([[element objectForKey:@"class"] isEqualToString:@"title"]) {
                
                [array1 addObject:element.text];
                
            }
        }
        
        
        for (TFHppleElement *imgEle in imgArray) {
            if ([[imgEle objectForKey:@"class"] isEqualToString:@"moduleFeaturedThumb"]) {
                
                [array2 addObject:[imgEle objectForKey:@"src"]];
                
            }
        }
        //
        //
        //
        for (TFHppleElement *urlEle in hhhh) {
            //*[@id="tab-featured"]/p[1]/a[1]
            
            NSArray *urlArray = [urlEle childrenWithTagName:@"a"];
            
            TFHppleElement *urlString = urlArray.firstObject;
            [array3 addObject:[urlString objectForKey:@"href"]];
            //NSLog(@"%@", [urlString objectForKey:@"href"]);
            //[dic setObject:[urlString objectForKey:@"href"] forKey:@"showUrl"];
            //[array addObject:dic];
        }
        for (int i = 0; i< hhhh.count; i++) {
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            
            [dic setObject:array1[i] forKey:@"title"];
            [dic setObject:array2[i] forKey:@"imageUrl"];
            [dic setObject:array3[i] forKey:@"showUrl"];
            [array addObject:dic];
            
        }
        
        
        
        
        
        
        
        
        
        
        self.array = [CHPronModel mj_objectArrayWithKeyValuesArray:array];
        if (_array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_chTableview reloadData];
            });
        }
        
        //[[NSURLCache sharedURLCache] removeAllCachedResponses];
        
        
        
        
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chhhh" forIndexPath:indexPath];
    cell.pron = self.array[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CHVIdeoViewController *video = [[CHVIdeoViewController alloc]init];
    video.pron = _array[indexPath.row];
    [self presentViewController:video animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
