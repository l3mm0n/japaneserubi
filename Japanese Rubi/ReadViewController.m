//
//  ReadViewController.m
//  Japanese Rubi
//
//  Created by Sarah Lemmon on 11/20/13.
//  Copyright (c) 2013 Sarah Lemmon. All rights reserved.
//

#import "ReadViewController.h"
#import "RubiController.h"

@interface ReadViewController ()
@property (strong, nonatomic) IBOutlet UITextView *content;
@property (strong, nonatomic) IBOutlet UILabel *pronunciationLabel;

@end

@implementation ReadViewController

//this was needed because iOS was trying to push everything down
//because of the status bar and the navigation bar
- (BOOL) automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.article = [[Article alloc] init];
    }
    return self;
}

#pragma mark - Helpers
//returns the text that is currently selected in the content textview
- (NSString *) getSelectedText {
    UITextRange *selectedRange = [self.content selectedTextRange];
    return [self.content textInRange:selectedRange];
}

//show the rubi for the selected text
- (void) rubi:(id)sender {
    NSString *rubi = [self.article lookupRubi:[self getSelectedText]];
    [self.pronunciationLabel setText:rubi];
}

//show the romanji for the selected text
- (void) roman:(id)sender {
    NSString *roman = [self.article lookupRoman:[self getSelectedText]];
    [self.pronunciationLabel setText:roman];
}


#pragma mark - Edit Menu
- (void)menuWillBeShown:(NSNotification *)notification {
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO]; // Don't show the default menu controller
}

#pragma mark - Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self.article title];
    self.content.text = [self.article content];
    
    //preload the Rubi Menu Item to the sharedMenuController
    UIMenuItem *menuRubi = [[UIMenuItem alloc] initWithTitle:@"Rubi" action:@selector(rubi:)];
    UIMenuItem *menuRoman = [[UIMenuItem alloc] initWithTitle:@"Romanji" action:@selector(roman:)];
    NSArray *menuItems = [[NSArray alloc] initWithObjects:menuRubi, menuRoman, nil];
    [[UIMenuController sharedMenuController] setMenuItems:menuItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
