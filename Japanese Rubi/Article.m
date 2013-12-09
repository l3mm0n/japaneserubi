//
//  Article.m
//  Japanese Rubi
//
//  Created by Sarah Lemmon on 11/20/13.
//  Copyright (c) 2013 Sarah Lemmon. All rights reserved.
//

#import "Article.h"

@implementation Article

@synthesize title;
@synthesize content;

-(id)init {
    title = @"";
    content = @"";

    return self;
}

#pragma mark - Setters

//return an error message, or an empty string if it's okay
- (void)setContent:(NSString *)contentInput {
    if (contentInput == nil || [contentInput length] <= 0) {
        NSLog(@"You forgot to add some content.");
    }
    
    content = contentInput;
    
//    return @"";
}

//return an error message, or an empty string if it's okay
- (void)setTitle:(NSString *)titleInput {
    if (titleInput == nil || [titleInput length] <= 0) {
//        return @"You forgot to add the title.";
    }
    
    title = titleInput;
    
//    return @"";
}

#pragma mark - Rubi API call

- (NSString *)getRubi {
    NSLog(@"Sentence: %@", self.content);
    NSString *appID = @"dj0zaiZpPTdhTW5OZGFyODZDcCZzPWNvbnN1bWVyc2VjcmV0Jng9Y2Q-";
    NSString *urlString = [NSString stringWithFormat:@"http://jlp.yahooapis.jp/FuriganaService/V1/furigana?appid=%@&sentence=%@",appID,self.content];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
//    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"GET"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *str = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"Data String: %@", str);
    
    return @"";
}

@end
