//
//  HPComposeToobar.h
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/18.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HPComposeToolbarButtonType)
{
    HPComposeToolbarButtonTypeCamera, // 照相机
    HPComposeToolbarButtonTypePicture, // 相册
    HPComposeToolbarButtonTypeMention, // 提到@
    HPComposeToolbarButtonTypeTrend, // 话题
    HPComposeToolbarButtonTypeEmotion // 表情
};


@class HPComposeToolbar;

@protocol HPComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(HPComposeToolbar *)toolbar didClickedButton:(HPComposeToolbarButtonType)buttonType;

@end

@interface HPComposeToolbar : UIView
@property (nonatomic, weak) id<HPComposeToolbarDelegate> delegate;
/**
 *  设置某个按钮的图片
 *
 *  @param image      图片名
 *  @param buttonType 按钮类型
 */
- (void)setButtonImage:(NSString *)image buttonType:(HPComposeToolbarButtonType)buttonType;

/**
 *  是否要显示表情按钮
 */
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;


@end
