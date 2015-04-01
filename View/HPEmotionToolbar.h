//
//  HPEmotionToolbar.h
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/18.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HPEmotionToolbar;

typedef enum {
    HPEmotionTypeRecent, // 最近
    HPEmotionTypeDefault, // 默认
    HPEmotionTypeEmoji, // Emoji
    HPEmotionTypeLxh // 浪小花
} HPEmotionType;

@protocol HPEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(HPEmotionToolbar *)toolbar didSelectedButton:(HPEmotionType)emotionType;
@end

@interface HPEmotionToolbar : UIView
@property (nonatomic, weak) id<HPEmotionToolbarDelegate> delegate;
@end