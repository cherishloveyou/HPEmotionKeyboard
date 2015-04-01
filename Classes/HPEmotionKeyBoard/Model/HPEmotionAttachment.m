//
//  HPEmotionAttachment.m
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/18.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "HPEmotionAttachment.h"
#import "HPEmotion.h"

@implementation HPEmotionAttachment

- (void)setEmotion:(HPEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", emotion.png]];
}

@end
