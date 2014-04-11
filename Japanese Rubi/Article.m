//
//  Article.m
//  Japanese Rubi
//
//  Created by Sarah Lemmon on 11/20/13.
//  Copyright (c) 2013 Sarah Lemmon. All rights reserved.
//

#import "Article.h"
#import "Word.h"

@implementation Article

@synthesize title;
@synthesize content;

-(id)init {
    title = @"";
    content = @"";
    self.words = [[NSMutableArray alloc] init];

    return self;
}

#pragma mark - Setters

//return an error message, or an empty string if it's okay
- (void)setContent:(NSString *)contentInput {
    if (contentInput == nil || [contentInput length] <= 0) {
        NSLog(@"You forgot to add some content.");
    }
    
    content = contentInput;
}

//return an error message, or an empty string if it's okay
- (void)setTitle:(NSString *)titleInput {
    if (titleInput == nil || [titleInput length] <= 0) {
//        return @"You forgot to add the title.";
    }
    
    title = titleInput;
    
//    return @"";
}

#pragma mark - Rubi

//gets and saves the Rubi for the content the user entered
- (void)getRubi {
    
    // 1. Send the content to the API
    NSString *appID = @"dj0zaiZpPTdhTW5OZGFyODZDcCZzPWNvbnN1bWVyc2VjcmV0Jng9Y2Q-";
    NSString *urlString = [NSString stringWithFormat:@"http://jlp.yahooapis.jp/FuriganaService/V1/furigana?appid=%@&sentence=%@",appID,self.content];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2. Save the returned data as a String.
    // I cannot just use the data element because I need to use the UTF-8 encoding
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *xmlstring = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    // 3. Parse the XML string using the library TBXML
    NSError *error;
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:xmlstring error:&error];
    
    if (error) {
        NSLog(@"%@ %@", [error localizedDescription], [error userInfo]);
    } else {

        // 4. Save Each Word in the XML tree as a Word Object and put it in an array to search for later.
        
        //traverse the XML tree down to the word element
        TBXMLElement *root = tbxml.rootXMLElement;
        TBXMLElement *result = [TBXML childElementNamed:@"Result" parentElement:root];
        TBXMLElement *wordList = [TBXML childElementNamed:@"WordList" parentElement:result];
        TBXMLElement *wordElement = [TBXML childElementNamed:@"Word" parentElement:wordList];
        
        do {
            [self saveNewWord:wordElement];
            
            //search for a sub-word list. If one exists, add it to the array of words
            //these sub words will all overlap, but it will give the user more flexibility in valid ranges to look up
            TBXMLElement *subWordListElement = [TBXML childElementNamed:@"SubWordList" parentElement:wordElement];
            
            if (subWordListElement) {
                TBXMLElement *subWordElement = [TBXML childElementNamed:@"SubWord" parentElement:subWordListElement];
                do {
                    [self saveNewWord:subWordElement];
                } while ((subWordElement = subWordElement->nextSibling));
            }
        } while ((wordElement = wordElement->nextSibling));

    }

}

//saves a word element to the array of word objects
- (Word *) saveNewWord:(TBXMLElement*)wordElement {
    
    //get word element's sub elements
    TBXMLElement *wordElementSurface = [TBXML childElementNamed:@"Surface" parentElement:wordElement];
    TBXMLElement *wordElementFurigana = [TBXML childElementNamed:@"Furigana" parentElement:wordElement];
    TBXMLElement *wordElementRoman = [TBXML childElementNamed:@"Roman" parentElement:wordElement];
    
    if (wordElementSurface == nil || wordElementFurigana == nil || wordElementRoman == nil) {
        return nil; //do not save a word. This sometimes happens with spacing or punctuation.
    }
    
    //save them to the word object
    Word *word = [[Word alloc] init];
    word.surface = [TBXML textForElement:wordElementSurface];
    word.furigana = [TBXML textForElement:wordElementFurigana];
    word.roman = [TBXML textForElement:wordElementRoman];
    
    //save to the array of words in the article
    [self.words addObject:word];
    
    return word; //return the word just in case they want to do something else to it.
}

//returns the rubi for the input, if available
- (NSString *) lookupRubi:(NSString *)lookupString {
    
    //verify that the input is okay
    if (![lookupString length]) {
        NSLog(@"Article: LookupRubi: invalid input");
        return nil;
    }
    
    //look for a corresponding word in the word list
    for (Word *word in self.words) {
        if ([lookupString isEqualToString:word.surface]) {
            return word.furigana;
        }
    }
    
    return NSLocalizedString(@"(no rubi found)", nil);
}

//returns the romanji for the input, if available
- (NSString *) lookupRoman:(NSString *)lookupString {
    
    //verify that the input is okay
    if (![lookupString length]) {
        NSLog(@"Article: LookupRubi: invalid input");
        return nil;
    }
    
    //look for a corresponding word in the word list
    for (Word *word in self.words) {
        if ([lookupString isEqualToString:word.surface]) {
            return word.roman;
        }
    }
    
    return NSLocalizedString(@"(no romanji found)",nil);
    
}

@end
