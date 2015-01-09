//
//  QuestionViewController.h
//  Trivia
//
//  Created by Kevin Holness on 2015-01-07.
//  Copyright (c) 2015 Kevin Holness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    
    int m_nCurrentQuestionIndex;
    
    NSString *m_strCorrectAnswer;
    
    NSMutableDictionary *m_dictCurrentQuestion;
    NSMutableArray *m_arrPossibleAnswers;
    
    NSTimer *m_timer;
    int m_nSecond;
    
}

- (void)returnToRoot;


@property (weak, nonatomic) IBOutlet UIImageView *imgTimer;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblPossibleAnswer;


@property (weak, nonatomic) IBOutlet UIView *viewNextLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentQuestion;
- (IBAction)nextAction:(id)sender;


@end
