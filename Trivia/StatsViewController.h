//
//  StatsViewController.h
//  Trivia
//
//  Created by Kevin Holness on 2015-01-07.
//  Copyright (c) 2015 Kevin Holness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsViewController : UIViewController

{
    
}

@property (weak, nonatomic) IBOutlet UILabel *lblTotalGamesPlayed;
@property (weak, nonatomic) IBOutlet UILabel *lblHighestScore;
@property (weak, nonatomic) IBOutlet UILabel *lblTimesCompleted;
@property (weak, nonatomic) IBOutlet UILabel *lblWon2;
@property (weak, nonatomic) IBOutlet UILabel *lblWon3;


- (IBAction)ShareAction:(id)sender;
- (IBAction)backAction:(id)sender;





@end
