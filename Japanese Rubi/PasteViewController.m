//
//  PasteViewController.m
//  Japanese Rubi
//
//  Created by Sarah Lemmon on 11/20/13.
//  Copyright (c) 2013 Sarah Lemmon. All rights reserved.
//

#import "PasteViewController.h"
#import "Article.h"
#import "ReadViewController.h"

@interface PasteViewController ()
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) Article *article;
@end

@implementation PasteViewController

//this was needed because iOS was trying to push everything down
//because of the status bar and the navigation bar
- (BOOL) automaticallyAdjustsScrollViewInsets {
    return NO;
}

#pragma mark - Actions
- (void) readArticle {
    
    //Verify the content is valid
    if ([self.content text] == nil || [[self.content text] length] <= 0) {
        NSLog(@"You must add the content of the article");
    }
//    if ([self.title text] == nil || [[self.content text] length] <=0) {
//        NSLog(@"You must add an Article Title");
//    }
    
    //save the title and the content
    self.article = [[Article alloc] init];
    [self.article setTitle:[self.titleField text]];
    [self.article setContent:[self.content text]];
    
    //set the API call for the Rubi
    [self.article getRubi]; //this saves the XML rubi output to the article file
    
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

#pragma mark - Transition

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self readArticle];
    ReadViewController *read = (ReadViewController *)segue.destinationViewController;
    read.article = self.article; //pass the article object to the next view
}

@end
