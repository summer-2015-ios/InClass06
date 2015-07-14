//
//  NewsItem.m
//  InClass06
//
//  Created by student on 7/14/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

-(instancetype) initWithName: (NSString*) name Url:(NSString*) url{
    self = [super init];
    if(self){
        self.name = name;
        self.url = url;
    }
    return self;
}
@end
