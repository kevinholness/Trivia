//
//  StatsViewController.m
//  Trivia
//
//  Created by Kevin Holness on 2015-01-07.
//  Copyright (c) 2015 Kevin Holness. All rights reserved.
//

#import "StatsViewController.h"
#import "Define.h"

@interface StatsViewController ()

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSInteger nTemp;
    
    nTemp = [[NSUserDefaults standardUserDefaults] integerForKey:TOTALGAMEPLAYED];
    self.lblTotalGamesPlayed.text = [NSString stringWithFormat:@"%d", (int)nTemp];
    
    //highest score
    
    nTemp = [[NSUserDefaults standardUserDefaults] integerForKey:HIGHESTSCORE];
    self.lblHighestScore.text = [NSString stringWithFormat:@"%d", (int)nTemp];
    
    nTemp = [[NSUserDefaults standardUserDefaults] integerForKey:TIMESCOMPLETED];
    self.lblTimesCompleted.text = [NSString stringWithFormat:@"%d", (int)nTemp];
    
    nTemp = [[NSUserDefaults standardUserDefaults] integerForKey:WON2INAROW];
    self.lblWon2.text = [NSString stringWithFormat:@"%d", (int)nTemp];
    
    nTemp = [[NSUserDefaults standardUserDefaults] integerForKey:WON3INAROW];
    self.lblWon3.text = [NSString stringWithFormat:@"%d", (int)nTemp];
    
}


- (IBAction)ShareAction:(id)sender {
    
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

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
