//
//  HPEmotionTextView.h
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/17.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "HPTextView.h"
@class HPEmotion;

@interface HPEmotionTextView : HPTextView
/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(HPEmotion *)emotion;

/**
 *  具体的文字内容
 */
- (NSString *)realText;
@end
