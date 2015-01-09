//
//  TimeOutViewController.h
//  Trivia
//
//  Created by Kevin Holness on 2015-01-07.
//  Copyright (c) 2015 Kevin Holness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeOutViewController : UIViewController

{
    
}

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblShowLevel;

- (IBAction)playagainAction:(id)sender;
- (IBAction)shareAction:(id)sender;
- (IBAction)homeAction:(id)sender;

@end
