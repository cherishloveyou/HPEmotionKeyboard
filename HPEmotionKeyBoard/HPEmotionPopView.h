//
//  HPEmotionPopView.h
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/18.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HPEmotionView;

@interface HPEmotionPopView : UIView

+ (instancetype)popView;

/**
 *  显示表情弹出控件
 *
 *  @param emotionView 从哪个表情上面弹出
 */
- (void)showFromEmotionView:(HPEmotionView *)fromEmotionView;
- (void)dismiss;
@end
