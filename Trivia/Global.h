//
//  Global.h
//  Onyx Connect
//
//  Created by lion on 12/30/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>

@class ViewController;

@interface Global : NSObject

+(Global *)sharedGlobal;

@property (nonatomic) NSMutableArray *arrQuestion;
@property (nonatomic) NSMutableArray *arrSelectedQuestion;
@property (nonatomic) int nQuestionCount;
@property (nonatomic) int nSuccessCount;
@property (nonatomic) AVAudioPlayer *audioPlayer;

@property (nonatomic) NSString *strTimeOutTitle;
@property (nonatomic) NSString *strTimeOutQuestionNum;


@end
