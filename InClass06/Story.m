//
//  Story.m
//  InClass06
//
//  Created by student on 7/14/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "Story.h"

@implementation Story
-(NSString *)description{
    return [NSString stringWithFormat:@"%@, %@", self.title, self.pubDate];
}
@end
