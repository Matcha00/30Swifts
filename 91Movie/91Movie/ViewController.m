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
#import "CHNavigationDropdownMenu.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource,CHNavigationDropdownMenuDelegate,CHNavigationDropdownMenuDataSource>
@property (weak, nonatomic) IBOutlet UITableView *chTableview;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.chTableview registerNib:[UINib nibWithNibName:@"CHTableViewCell" bundle:nil] forCellReuseIdentifier:@"chhhh"];
    [self setUpData];
    
    self.page = 1;
    
    CHNavigationDropdownMenu *test = [[CHNavigationDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:test];
    test.delegate = self;
    test.dataSource = self;
}

#pragma mark - NavigationDropdownMenu DataSource

- (NSArray<NSString *> *)titleArrayForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu {
    return @[@"所有", @"大胸", @"翘臀", @"黑丝", @"美腿", @"清新", @"杂烩"];
}

- (UIImage *)arrowImageForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu {
    return [UIImage imageNamed:@"Arrow"];
}

- (CGFloat)arrowPaddingForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu {
    return 8.0;
}

- (BOOL)keepCellSelectionForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu {
    return NO;
}
#pragma mark - NavigationDropdownMenu Delegate

- (void)navigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu didSelectTitleAtIndex:(NSUInteger)index {
    
}

- (void)setUpData
{
    self.chTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(upNewData)];
    [self.chTableview.mj_header beginRefreshing];
    
    self.chTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
}

- (void)moreLoad
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        self.page++;
        NSString *url91 = [NSString stringWithFormat:@"%@%lu",@"http://91porn.com/video.php?category=rf&page=",self.page];
        
        
        
        
        
        
        [[CHNetWorking shareManager]getUrl:url91 withBlock:^(NSData *data, NSError *error) {
            
            
            if (data) {
                
                TFHpple *xpathHtml = [[TFHpple alloc]initWithHTMLData:data encoding:@"utf-8"];
                //搜索所有img
                NSArray *imgArray = [xpathHtml searchWithXPathQuery:@"//img"];
                //搜索所有span
                NSArray *dataArray = [xpathHtml searchWithXPathQuery:@"//span"];
                //搜索所有的a
                NSArray *urlArray = [xpathHtml searchWithXPathQuery:@"//a"];
                
                NSMutableArray *imageMutableArray = [[NSMutableArray alloc]init];
                NSMutableArray *urlMutableArray = [[NSMutableArray alloc]init];
                NSMutableArray *titleMutableArray = [[NSMutableArray alloc]init];
                NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                
                
                
                //获取span中含有title标签span
                for (TFHppleElement *element in dataArray) {
                    if ([[element objectForKey:@"class"] isEqualToString:@"title"]) {
                        
                        NSLog(@"%@", element.text);
                        
                        [titleMutableArray addObject:element.text];
                        
                    }
                }
                //*[@id="videobox"]/table/tbody/tr/td/div[1]/div[1]/a/img
                //获取所有img下有title key 节点
                for (TFHppleElement *imgEle in imgArray) {
                    if ([imgEle objectForKey:@"title"]) {
                        
                        //[array2 addObject:[imgEle objectForKey:@"src"]];
                        
                        NSLog(@"%@", [imgEle objectForKey:@"src"]);
                        [imageMutableArray addObject:[imgEle objectForKey:@"src"]];
                        
                    }
                }
                //获取所有a下有title key 节点
                for (TFHppleElement *element in urlArray) {
                    
                    if ([element objectForKey:@"title"]) {
                        NSLog(@"%@", [element objectForKey:@"href"]);
                        [urlMutableArray addObject:[element objectForKey:@"href"]];
                    }
                }
                
                for (NSUInteger i = 0; i < imageMutableArray.count; i++) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    
                    [dic setObject:titleMutableArray[i] forKey:@"title"];
                    [dic setObject:imageMutableArray[i] forKey:@"imageUrl"];
                    [dic setObject:urlMutableArray[i + 1] forKey:@"showUrl"];
                    
                    [modelArray addObject:dic];
                }
                
                
                
                
                
                
                
                
                
                
                self.array = [CHPronModel mj_objectArrayWithKeyValuesArray:modelArray];
                if (_array) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.chTableview.mj_footer endRefreshing];
                        [_chTableview reloadData];
                    });
                }
                
            } else {
                self.page--;
            }
            
            
            
        }]; 
        
    });
    
   
}

- (void)upNewData
{
    
    
    //[self.chTableview.mj_footer endRefreshing];
    NSString *url91 = [NSString stringWithFormat:@"%@%lu",@"http://91porn.com/video.php?category=rf&page=",self.page];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        [[CHNetWorking shareManager]getUrl:url91 withBlock:^(NSData *data, NSError *error) {
            
            
            
            
            TFHpple *xpathHtml = [[TFHpple alloc]initWithHTMLData:data encoding:@"utf-8"];
            //搜索所有img
            NSArray *imgArray = [xpathHtml searchWithXPathQuery:@"//img"];
            //搜索所有span
            NSArray *dataArray = [xpathHtml searchWithXPathQuery:@"//span"];
            //搜索所有的a
            NSArray *urlArray = [xpathHtml searchWithXPathQuery:@"//a"];
            
            NSMutableArray *imageMutableArray = [[NSMutableArray alloc]init];
            NSMutableArray *urlMutableArray = [[NSMutableArray alloc]init];
            NSMutableArray *titleMutableArray = [[NSMutableArray alloc]init];
            NSMutableArray *modelArray = [[NSMutableArray alloc]init];
            
            
            
            //获取span中含有title标签span
            for (TFHppleElement *element in dataArray) {
                if ([[element objectForKey:@"class"] isEqualToString:@"title"]) {
                    
                    NSLog(@"%@", element.text);
                    
                    [titleMutableArray addObject:element.text];
                    
                }
            }
            //*[@id="videobox"]/table/tbody/tr/td/div[1]/div[1]/a/img
            //获取所有img下有title key 节点
            for (TFHppleElement *imgEle in imgArray) {
                if ([imgEle objectForKey:@"title"]) {
                    
                    //[array2 addObject:[imgEle objectForKey:@"src"]];
                    
                    NSLog(@"%@", [imgEle objectForKey:@"src"]);
                    [imageMutableArray addObject:[imgEle objectForKey:@"src"]];
                    
                }
            }
            //获取所有a下有title key 节点
            for (TFHppleElement *element in urlArray) {
                
                if ([element objectForKey:@"title"]) {
                    NSLog(@"%@", [element objectForKey:@"href"]);
                    [urlMutableArray addObject:[element objectForKey:@"href"]];
                }
            }
            
            for (NSUInteger i = 0; i < imageMutableArray.count; i++) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                
                [dic setObject:titleMutableArray[i] forKey:@"title"];
                [dic setObject:imageMutableArray[i] forKey:@"imageUrl"];
                [dic setObject:urlMutableArray[i + 1] forKey:@"showUrl"];
                
                [modelArray addObject:dic];
            }
            
            
            
            
            
            
            
            
            
            
            self.array = [CHPronModel mj_objectArrayWithKeyValuesArray:modelArray];
            if (_array) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.chTableview.mj_header endRefreshing];
                    [_chTableview reloadData];
                });
            }
            
            //[[NSURLCache sharedURLCache] removeAllCachedResponses];
            
            
            
            
            
        }];
        
    });
    
    
    
    
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
