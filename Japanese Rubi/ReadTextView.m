//
//  ReadTextView.m
//  Japanese Rubi
//
//  Created by Sarah Lemmon on 12/12/13.
//  Copyright (c) 2013 Sarah Lemmon. All rights reserved.
//

#import "ReadTextView.h"

@implementation ReadTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //initializations
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:)) {
        if (self.selectedRange.length > 0) {
            return YES;
        }
    }
    return NO;
}

@end
