//
//  HPEmotionKeyboard.m
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/18.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "HPEmotionKeyboard.h"
#import "HPEmotionTool.h"
#import "HPEmotionToolbar.h"
#import "HPEmotionListView.h"
#import "UIView+hp.h"

@interface HPEmotionKeyboard ()<HPEmotionToolbarDelegate>

@property (nonatomic, weak) HPEmotionToolbar *toollbar;

@property (nonatomic ,weak) HPEmotionListView *listView;

@end

@implementation HPEmotionKeyboard

+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        
        // 1.添加表情列表
        HPEmotionListView *listView = [[HPEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.添加表情工具条
        HPEmotionToolbar *toollbar = [[HPEmotionToolbar alloc] init];
        toollbar.delegate = self;
        [self addSubview:toollbar];
        self.toollbar = toollbar;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//     1.设置工具条的frame
    self.toollbar.hp_width = self.hp_width;
    self.toollbar.hp_height = 35;
    self.toollbar.hp_y = self.hp_height - self.toollbar.hp_height;
    
    // 2.设置表情列表的frame
    self.listView.hp_width = self.hp_width;
    self.listView.hp_height = self.toollbar.hp_y;
}

#pragma mark - HMEmotionToolbarDelegate
- (void)emotionToolbar:(HPEmotionToolbar *)toolbar didSelectedButton:(HPEmotionType)emotionType
{
    switch (emotionType) {
        case HPEmotionTypeDefault:// 默认
            self.listView.emotions = [HPEmotionTool defaultEmotions];
            break;
            
        case HPEmotionTypeEmoji: // Emoji
            self.listView.emotions = [HPEmotionTool emojiEmotions];
            break;
            
        case HPEmotionTypeLxh: // 浪小花
            self.listView.emotions = [HPEmotionTool lxhEmotions];
            break;
            
        case HPEmotionTypeRecent: // 最近
            self.listView.emotions = [HPEmotionTool recentEmotions];
            break;
    }
}


@end
