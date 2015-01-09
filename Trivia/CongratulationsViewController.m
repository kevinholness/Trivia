//
//  CongratulationViewController.m
//  Trivia
//
//  Created by Kevin Holness on 2015-01-07.
//  Copyright (c) 2015 Kevin Holness. All rights reserved.
//

#import "CongratulationsViewController.h"

@interface CongratulationsViewController ()

@end

@implementation CongratulationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)playAction:(id)sender {
    
    UIViewController *root = [self.navigationController.viewControllers objectAtIndex:1];
    [root performSelector:@selector(returnToRoot)];
    
}

- (IBAction)homeAction:(id)sender {
    
    UIViewController *root = [self.navigationController.viewControllers objectAtIndex:0];
    [root performSelector:@selector(returnToRoot)];
    
}
@end
