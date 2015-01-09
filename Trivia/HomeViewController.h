//
//  HomeViewController.h
//  Trivia
//
//  Created by Kevin Holness on 2015-01-06.
//  Copyright (c) 2015 Kevin Holness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperationManager.h"
#import "Global.h"

@interface HomeViewController : UIViewController

{
    
    
}

- (void)returnToRoot;


@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIButton *btnSound;

- (IBAction)startAction:(id)sender;
- (IBAction)soundAction:(id)sender;


@end
