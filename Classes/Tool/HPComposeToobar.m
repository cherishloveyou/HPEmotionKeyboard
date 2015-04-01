//
//  HPComposeToobar.m
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/18.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "HPComposeToobar.h"
#import "UIView+hp.h"

@interface HPComposeToolbar()
@property (nonatomic, weak) UIButton *emotionButton;
@end

@implementation HPComposeToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:247 green:247 blue:247 alpha:1];
        self.backgroundColor = [UIColor lightGrayColor];
        
        // 添加所有的子控件
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:HPComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:HPComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:HPComposeToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:HPComposeToolbarButtonTypeTrend];
        self.emotionButton = [self addButtonWithIcon:@"chat_bottom_smile_nor" highIcon:@"chat_bottom_smile_nor" tag:HPComposeToolbarButtonTypeEmotion];
    }
    return self;
}

- (void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton = showEmotionButton;
    if (showEmotionButton) { // 显示表情按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"release_btn_smile"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else { // 切换为键盘按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"release_btn_sys"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

/**
 *  添加一个按钮
 *
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (UIButton *)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(HPComposeToolbarButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
    return button;
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeTool:didClickedButton:)]) {
        [self.delegate composeTool:self didClickedButton:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat buttonW = self.hp_width / count;
    CGFloat buttonH = self.hp_height;
    for (int i = 0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.hp_y = 0;
        button.hp_width = buttonW;
        button.hp_height = buttonH;
        button.hp_x = i * buttonW;
    }
}

@end