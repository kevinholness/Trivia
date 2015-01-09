//
//  Global.m
//  Onyx Connect
//
//  Created by lion on 12/30/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import "Global.h"

@implementation Global

static Global *_Global;

+(Global *)sharedGlobal
{
    if (!_Global){
        _Global=[[Global alloc] init];
    }
    return _Global;
}
-(id) init
{
    self=[super init];
    if (self){
        
        self.arrQuestion = [[NSMutableArray alloc] init];
        self.arrSelectedQuestion = [[NSMutableArray alloc] init];
        self.nSuccessCount = 0;
        self.audioPlayer = [[AVAudioPlayer alloc] init];
    }
    return self;
}
@end
