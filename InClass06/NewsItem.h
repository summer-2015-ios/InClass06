//
//  NewsItem.h
//  InClass06
//
//  Created by student on 7/14/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* url;
-(instancetype) initWithName: (NSString*) name Url:(NSString*) url;
@end
