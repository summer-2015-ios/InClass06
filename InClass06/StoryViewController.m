//
//  StoryViewController.m
//  InClass06
//
//  Created by student on 7/14/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "StoryViewController.h"
#import "UIImageView+WebCache.h"

@interface StoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *pubDateView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descView;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.text = [self.story title];
    self.pubDateView.text = [self.story pubDate];
    self.descView.text = [self.story desc];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[self.story thumbnailLargeUrl]]
                      placeholderImage:[UIImage imageNamed:@"No_Image_Available"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
