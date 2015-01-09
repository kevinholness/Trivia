//
//  QuestionViewController.m
//  Trivia
//
//  Created by Kevin Holness on 2015-01-07.
//  Copyright (c) 2015 Kevin Holness. All rights reserved.
//

#import "QuestionViewController.h"
#import "Global.h"
#import "Define.h"
#import "SuccessViewController.h"
#import "TimeOutViewController.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tblPossibleAnswer.delegate = self;
    self.tblPossibleAnswer.dataSource = self;
    
    m_dictCurrentQuestion = [[NSMutableDictionary alloc] init];
    m_arrPossibleAnswers = [[NSMutableArray alloc] init];
    

}
-(void)viewWillAppear:(BOOL)animated{
    
    NSInteger nTemp = [[NSUserDefaults standardUserDefaults] integerForKey:TOTALGAMEPLAYED];
    [[NSUserDefaults standardUserDefaults] setInteger:nTemp + 1 forKey:TOTALGAMEPLAYED];
    
    //play intro music
    if (![[NSUserDefaults standardUserDefaults] boolForKey:SOUND]){
        NSString *pewPewPath = [[NSBundle mainBundle]
                            pathForResource:@"Questionlist" ofType:@"wav"];
        NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
        [Global sharedGlobal].audioPlayer = [[AVAudioPlayer alloc]
                                         initWithContentsOfURL:pewPewURL error:nil];
        [[Global sharedGlobal].audioPlayer prepareToPlay];
        [[Global sharedGlobal].audioPlayer play];
    }
    
    
    [self getRandomQuestion];
    
    [self showQuestion];
    
    m_nCurrentQuestionIndex = 0 ;
}

-(void)showQuestion{
    
    self.imgTimer.image = nil;
    
    self.tblPossibleAnswer.allowsSelection = YES;
    
    
    m_dictCurrentQuestion = [Global sharedGlobal].arrSelectedQuestion[m_nCurrentQuestionIndex];
    
    self.lblQuestionTitle.text = m_dictCurrentQuestion[@"question"];
    
    m_strCorrectAnswer = m_dictCurrentQuestion[@"correct_answer"];
    m_arrPossibleAnswers = m_dictCurrentQuestion[@"possible_answers"];
    
    [self.tblPossibleAnswer reloadData];
    
    
    m_timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector:@selector(onTimer:)
                                                userInfo: nil repeats:YES];
    m_nSecond = 0;
    
}
-(void)onTimer:(NSTimer *)timer {
    
    m_nSecond++;
    
    if (m_nSecond == 6){
        
        [timer invalidate];
        timer = nil;
        
        [self performSelector:@selector(showTimeOutScreen:) withObject:TIMEOUTPARAMETER afterDelay:1.0];
        
        
    }else{
        
        self.imgTimer.image = [UIImage imageNamed:[NSString stringWithFormat:@"timer%d",m_nSecond]];
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return m_arrPossibleAnswers.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    cell.textLabel.text = m_arrPossibleAnswers[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:25.0f];
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *bgColorView = [[UIView alloc] init];
    
    self.tblPossibleAnswer.allowsSelection = NO;
    
    [m_timer invalidate];
    m_timer = nil;
    
    
    if ([m_arrPossibleAnswers[indexPath.row] isEqualToString:m_strCorrectAnswer]){
        
        //answered correctly
        
        bgColorView.backgroundColor = BLUECELLCOLOR;
        [cell setSelectedBackgroundView:bgColorView];
        
        
        //set high score
        
        int nCurrentHighScore = (int)[[NSUserDefaults standardUserDefaults] integerForKey:HIGHESTSCORE];
        if ( nCurrentHighScore < (m_nCurrentQuestionIndex + 1)){
            [[NSUserDefaults standardUserDefaults] setInteger:m_nCurrentQuestionIndex + 1 forKey:HIGHESTSCORE];
        }
        
        
        
        if (m_nCurrentQuestionIndex == 29){   //  is 29?
            
            NSInteger nTemp = [[NSUserDefaults standardUserDefaults] integerForKey:TIMESCOMPLETED];
            [[NSUserDefaults standardUserDefaults] setInteger:nTemp + 1 forKey:TIMESCOMPLETED];
            
            [Global sharedGlobal].nSuccessCount++;
            
            if ([Global sharedGlobal].nSuccessCount == 2){
                NSInteger nTemp = [[NSUserDefaults standardUserDefaults] integerForKey:WON2INAROW];
                [[NSUserDefaults standardUserDefaults] setInteger:nTemp + 1 forKey:WON2INAROW];
            }
            if ([Global sharedGlobal].nSuccessCount == 3){
                NSInteger nTemp = [[NSUserDefaults standardUserDefaults] integerForKey:WON3INAROW];
                [[NSUserDefaults standardUserDefaults] setInteger:nTemp + 1 forKey:WON3INAROW];
            }
            
            SuccessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SuccessViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            [self performSelector:@selector(showNextScreen) withObject:nil afterDelay:1.0];
            
        }
        
        //play correct answer music
        if (![[NSUserDefaults standardUserDefaults] boolForKey:SOUND]){
            NSString *pewPewPath = [[NSBundle mainBundle]
                                pathForResource:@"CorrectAnswer" ofType:@"wav"];
            NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
            [Global sharedGlobal].audioPlayer = [[AVAudioPlayer alloc]
                                             initWithContentsOfURL:pewPewURL error:nil];
            [[Global sharedGlobal].audioPlayer prepareToPlay];
            [[Global sharedGlobal].audioPlayer play];
        }
        
    }else{
        
        //answered wrongly
        
        [Global sharedGlobal].nSuccessCount = 0;
        
        bgColorView.backgroundColor = REDCELLCOLOR;
        [cell setSelectedBackgroundView:bgColorView];
        
        for (int i = 0; i < m_arrPossibleAnswers.count; i++){
            if ([m_arrPossibleAnswers[i] isEqualToString:m_strCorrectAnswer]){
                
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                
                cell.backgroundColor = BLUECELLCOLOR;
                
            }
            
        }
        
        [self performSelector:@selector(showTimeOutScreen:) withObject:WRONGANSWERPARAMETER afterDelay:1.0];
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:SOUND]){
            NSString *pewPewPath = [[NSBundle mainBundle]
                                pathForResource:@"IncorrectAnswer" ofType:@"wav"];
            NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
            [Global sharedGlobal].audioPlayer = [[AVAudioPlayer alloc]
                                             initWithContentsOfURL:pewPewURL error:nil];
            [[Global sharedGlobal].audioPlayer prepareToPlay];
            [[Global sharedGlobal].audioPlayer play];
        }
        
    }
    
}

-(void) showNextScreen{
    
    self.viewNextLevel.hidden = NO;
    self.lblCurrentQuestion.text = [NSString stringWithFormat:@"%d/30",m_nCurrentQuestionIndex+1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)nextAction:(id)sender {
    
    self.viewNextLevel.hidden = YES;
    
    m_nCurrentQuestionIndex++;
    
    [self showQuestion];
    
}

-(void) showTimeOutScreen:(NSString *) selection{
    
    TimeOutViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TimeOutViewController"];
    
    if ([selection isEqualToString:WRONGANSWERPARAMETER]){
        
        [Global sharedGlobal].strTimeOutTitle = WRONGANSWERSTRING;
        [Global sharedGlobal].strTimeOutQuestionNum = [NSString stringWithFormat:@"Level %d/30",m_nCurrentQuestionIndex + 1];
        
    }else{

        [Global sharedGlobal].strTimeOutTitle = TIMEOUTSTRING;
        [Global sharedGlobal].strTimeOutQuestionNum = [NSString stringWithFormat:@"Level %d/30",m_nCurrentQuestionIndex + 1];
        
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void) getRandomQuestion {
    
    int nLevel1QuestionCount = 0;
    int nLevel2QuestionCount = 0;
    
    
    NSMutableArray *arrSelectedQuestion = [[NSMutableArray alloc] init];
    
    while(1)
    {
        int index = arc4random_uniform((int)[Global sharedGlobal].arrQuestion.count);
        
        NSMutableDictionary *dictQuestion = [[NSMutableDictionary alloc] init];
        
        dictQuestion = [Global sharedGlobal].arrQuestion[index];
        
        if ([dictQuestion[@"difficulty"] intValue] == 1 ){
            
            if ((nLevel1QuestionCount + 1) <= 25){
                
                [arrSelectedQuestion addObject:dictQuestion];
                nLevel1QuestionCount++;
                
            }
            
        }else{
            
            if ((nLevel2QuestionCount + 1) <= 5){
                
                [arrSelectedQuestion addObject:dictQuestion];
                nLevel2QuestionCount++;
                
            }
            
        }
        
        if ((nLevel1QuestionCount + nLevel2QuestionCount) == 30){
            break;
        }
        
    }
    
    [Global sharedGlobal].arrSelectedQuestion = arrSelectedQuestion;
}

- (void)returnToRoot {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToViewController:self animated:NO];
}

@end
