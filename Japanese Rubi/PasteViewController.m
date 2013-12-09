//
//  PasteViewController.m
//  Japanese Rubi
//
//  Created by Sarah Lemmon on 11/20/13.
//  Copyright (c) 2013 Sarah Lemmon. All rights reserved.
//

#import "PasteViewController.h"
#import "Article.h"

@interface PasteViewController ()
@property (strong, nonatomic) IBOutlet UITextView *content;
@property (strong, nonatomic) IBOutlet UITextField *title;
@property (strong, nonatomic) Article *article;
@end

@implementation PasteViewController

#pragma mark - Actions
- (IBAction)readArticle:(UIBarButtonItem *)sender {
    
    //Verify the content is valid
    if ([self.content text] == nil || [[self.content text] length] <= 0) {
        NSLog(@"You must add the content of the article");
    }
//    if ([self.title text] == nil || [[self.content text] length] <=0) {
//        NSLog(@"You must add an Article Title");
//    }
    
    //save the title and the content
    self.article = [[Article alloc] init];
    [self.article setTitle:[self.title text]];
    [self.article setContent:[self.content text]];
    
    //set the API call for the Rubi
    [self.article getRubi];
    
}

#pragma mark - Controller Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
