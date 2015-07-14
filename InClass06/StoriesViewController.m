//
//  StoriesViewController.m
//  InClass06
//
//  Created by student on 7/14/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "StoriesViewController.h"
#import "Story.h"
#import "UIImageView+WebCache.h"
#import "StoryViewController.h"

@interface StoriesViewController () <NSXMLParserDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray* stories;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) Story* story;
@property (nonatomic, strong) NSString* element;
@property (nonatomic, strong) NSMutableDictionary* elementData;
@end

@implementation StoriesViewController

-(void)setStories:(NSMutableArray *)stories{
    _stories = stories;
   // [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = (UITableView*)[self.view viewWithTag:1000];
    self.stories = [[NSMutableArray alloc] init];
    [self fetchStories];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) fetchStories{
    NSURLRequest *request  = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.url]]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if(error){
                        NSLog(@"error : %@", error);
                        return ;
                    }
                    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
                    parser.delegate = self;
                    [parser parse];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //NSLog(@"%@", self.stories);
                        [self.tableView reloadData];
                    });
                    
            }] resume];
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"item"]){
        self.story = [[Story alloc] init];
    }
    if(self.story){
        if([elementName isEqualToString:@"media:thumbnail"]){
            if([attributeDict[@"width"] isEqualToString:@"66"]){
                self.story.thumbnailSmallUrl = attributeDict[@"url"];
            } else if([attributeDict[@"width"] isEqualToString:@"144"]){
                self.story.thumbnailLargeUrl = attributeDict[@"url"];

            }
        }
    }
    self.element = elementName;
   
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"item"]){
        [self.stories addObject:self.story];
        self.story = nil;
    }
    self.element = nil;
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(self.story){
        if([self.element isEqualToString:@"title"]){
            self.story.title = string;
        }else if([self.element isEqualToString:@"description"]){
            self.story.desc = string;
        }else if([self.element isEqualToString:@"pubdate"]){
            self.story.pubDate = string;
        }
    }
}

# pragma mark - UITableViewDataSource implementation
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stories.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"storyCell"];
    if(!cell){
        
    }
    UILabel* title = (UILabel*)[cell viewWithTag:2001];
    title.text = [(Story*)self.stories[indexPath.row] title];
    UIImageView* imageView = (UIImageView*)[cell viewWithTag:2000];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[(Story*)self.stories[indexPath.row] thumbnailSmallUrl]]
                 placeholderImage:[UIImage imageNamed:@"No_Image_Available"]];
    return cell;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    StoryViewController* vc = [segue destinationViewController];
    UITableViewCell* cell = (UITableViewCell*) sender;
    long row = [self.tableView indexPathForCell:cell].row;
    vc.story = (Story*)self.stories[row];
}

@end
