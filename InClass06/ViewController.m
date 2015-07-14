//
//  ViewController.m
//  InClass06
//
//  Created by student on 7/14/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "ViewController.h"
#import "NewsItem.h"
#import "StoriesViewController.h"

@interface ViewController () <UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray* newsItems;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsItems = [[NSMutableArray alloc] init];
    self.tableView = (UITableView*)[self.view viewWithTag:1000];
    [self loadNewsItems];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void) loadNewsItems{
    NewsItem* item = [[NewsItem alloc] initWithName:@"Top Stories" Url:@"http://feeds.bbci.co.uk/news/rss.xml"];
    self.newsItems[0] = item;
    item = [[NewsItem alloc] initWithName:@"World" Url:@"http://feeds.bbci.co.uk/news/world/rss.xml"];
    self.newsItems[1] = item;
    item = [[NewsItem alloc] initWithName:@"UK" Url:@"http://feeds.bbci.co.uk/news/uk/rss.xml"];
    self.newsItems[2] = item;
    item = [[NewsItem alloc] initWithName:@"Business" Url:@"http://feeds.bbci.co.uk/news/business/rss.xml"];
    self.newsItems[3] = item;
    item = [[NewsItem alloc] initWithName:@"Politics" Url:@"http://feeds.bbci.co.uk/news/politics/rss.xml"];
    self.newsItems[4] = item;
    item = [[NewsItem alloc] initWithName:@"Health" Url:@"http://feeds.bbci.co.uk/news/health/rss.xml"];
    self.newsItems[5] = item;
    item = [[NewsItem alloc] initWithName:@"Education" Url:@"http://feeds.bbci.co.uk/news/education/rss.xml"];
    self.newsItems[6] = item;
    item = [[NewsItem alloc] initWithName:@"Science and Environment" Url:@"http://feeds.bbci.co.uk/news/science_and_environment/rss.xml"];
    self.newsItems[7] = item;
    item = [[NewsItem alloc] initWithName:@"Technology" Url:@"http://feeds.bbci.co.uk/news/technology/rss.xml"];
    self.newsItems[8] = item;
    item = [[NewsItem alloc] initWithName:@"Entertainment and Arts" Url:@"http://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml"];
    self.newsItems[9] = item;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setNewsItems:(NSMutableArray *)newsItems{
    _newsItems = newsItems;
    [self.tableView reloadData];
}
# pragma mark - UITableViewDataSource implementation
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsItems.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    if(!cell){
        
    }
    cell.textLabel.text = [(NewsItem*)self.newsItems[indexPath.row] name];
   return cell;
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    StoriesViewController* vc = [segue destinationViewController];
    UITableViewCell* cell = (UITableViewCell*) sender;
    long row = [self.tableView indexPathForCell:cell].row;
    vc.url = [(NewsItem*)self.newsItems[row] url];
}
@end
