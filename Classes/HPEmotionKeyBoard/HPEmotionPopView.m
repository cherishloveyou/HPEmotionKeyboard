//
//  HPEmotionPopView.m
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/18.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "HPEmotionPopView.h"
#import "HPEmotionView.h"
#import "UIView+hp.h"

@interface HPEmotionPopView ()

@property (weak, nonatomic) IBOutlet HPEmotionView *emotionView;


@end

@implementation HPEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HPEmotionView" owner:nil options:nil] lastObject];
}


- (void)showFromEmotionView:(HPEmotionView *)fromEmotionView
{
    if (fromEmotionView == nil) return;
    
    // 1.显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    // 2.添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3.设置位置
    CGFloat centerX = fromEmotionView.hp_centerX;
    CGFloat centerY = fromEmotionView.hp_centerY - self.hp_height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);

    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
    
        [UIView animateWithDuration:0.02 animations:^{
            self.hp_y = self.hp_y - 5;
        }];
}

- (void)dismiss
{
    [self removeFromSuperview];
}


/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用这个方法）
 *
 *  @param rect 控件的bounds
 */
- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}

@end




