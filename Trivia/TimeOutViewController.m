//
//  TimeOutViewController.m
//  Trivia
//
//  Created by Kevin Holness on 2015-01-07.
//  Copyright (c) 2015 Kevin Holness. All rights reserved.
//

#import "TimeOutViewController.h"
#import "Global.h"

@interface TimeOutViewController ()

@end

@implementation TimeOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.lblTitle.text = [Global sharedGlobal].strTimeOutTitle;
    self.lblShowLevel.text = [Global sharedGlobal].strTimeOutQuestionNum;
    
}

- (IBAction)playagainAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)shareAction:(id)sender {
    
    NSString *textToShare = @"";
    NSURL *myWebsite = [NSURL URLWithString:@""];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
}

- (IBAction)homeAction:(id)sender {
    
    UIViewController *root = [self.navigationController.viewControllers objectAtIndex:0];
    [root performSelector:@selector(returnToRoot)];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
