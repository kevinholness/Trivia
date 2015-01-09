//
//  HomeViewController.m
//  Trivia
//
//  Created by Kevin Holness on 2015-01-06.
//  Copyright (c) 2015 Kevin Holness. All rights reserved.
//

#import "HomeViewController.h"
#import "Global.h"
#import "Define.h"
#import "QuestionViewController.h"

#import <AVFoundation/AVAudioPlayer.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.btnStart.enabled = NO;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:@"http://ec2-54-149-167-238.us-west-2.compute.amazonaws.com:8888/questions_json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [Global sharedGlobal].arrQuestion = responseObject[@"questions"];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.btnStart.enabled = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:SOUND]){
        NSString *pewPewPath = [[NSBundle mainBundle]
                            pathForResource:@"Introtogame" ofType:@"wav"];
        NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
        [Global sharedGlobal].audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:pewPewURL error:nil];
        [[Global sharedGlobal].audioPlayer prepareToPlay];
        [[Global sharedGlobal].audioPlayer play];
        
        [self.btnSound setBackgroundImage:[UIImage imageNamed:@"sound_on"] forState:UIControlStateNormal];
    }else{
        [self.btnSound setBackgroundImage:[UIImage imageNamed:@"sound_off"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)startAction:(id)sender {
    
    QuestionViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (IBAction)soundAction:(id)sender {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:SOUND]){
        
        [self.btnSound setBackgroundImage:[UIImage imageNamed:@"sound_off"] forState:UIControlStateNormal];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SOUND];
        
        [[Global sharedGlobal].audioPlayer stop];
        
    }else{
        
        [self.btnSound setBackgroundImage:[UIImage imageNamed:@"sound_on"] forState:UIControlStateNormal];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SOUND];
        
    }
    
}

- (void)returnToRoot {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
