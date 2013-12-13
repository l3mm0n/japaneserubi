//
//  Word.h
//  Japanese Rubi
//
//  Created by Sarah Lemmon on 12/12/13.
//  Copyright (c) 2013 Sarah Lemmon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject

@property (strong, nonatomic) NSString *surface;
@property (strong, nonatomic) NSString *furigana;
@property (strong, nonatomic) NSString *roman;

@end
