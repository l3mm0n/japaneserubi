//
//  Article.h
//  Japanese Rubi
//
//  Created by Sarah Lemmon on 11/20/13.
//  Copyright (c) 2013 Sarah Lemmon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface Article : NSObject

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *words;

-(void)getRubi;
-(NSString *)lookupRubi:(NSString *)lookupString;
-(NSString *)lookupRoman:(NSString *)lookupString;

@end
