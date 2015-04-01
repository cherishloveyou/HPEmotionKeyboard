//
//  HPTextView.m
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/17.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "HPTextView.h"
#import "UIView+hp.h"

@interface HPTextView ()

@property (nonatomic ,weak) UILabel *placehoderLb;

@end

@implementation HPTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 添加一个显示提醒文字的label（显示占位文字的label）
        UILabel *placehoderLb = [[UILabel alloc] init];
        placehoderLb.numberOfLines = 0;
        placehoderLb.backgroundColor = [UIColor clearColor];
        placehoderLb.font = [UIFont systemFontOfSize:14];
        [self addSubview:placehoderLb];
        self.placehoderLb = placehoderLb;
        
        // 设置默认的占位文字颜色
        self.placehoderColor = [UIColor lightGrayColor];
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        
        // 监听内部文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange
{
    // text属性：只包括普通的文本字符串
    // attributedText：包括了显示在textView里面的所有内容（表情、text）
    self.placehoderLb.hidden = self.hasText;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    
    self.placehoderLb.text = placehoder;
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    
    self.placehoderLb.textColor = placehoderColor;
}

//- (void)setPlacehoderFont:(UIFont *)placehoderFont
//{
//    _placehoderFont = placehoderFont;
//    
//    self.placehoderLb.font = placehoderFont;
//}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placehoderLb.font = font;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placehoderLb.hp_y = 8;
    
    self.placehoderLb.hp_x = 5;
    
    self.placehoderLb.hp_width = self.hp_width - 2 * self.placehoderLb.hp_x;
    
    CGSize maxPlacehoderSize = CGSizeMake(self.placehoderLb.hp_width, MAXFLOAT);
    NSDictionary *placehoderDict = @{NSFontAttributeName:self.placehoderLb.font};
    CGSize placehoderSize = [self.placehoder boundingRectWithSize:maxPlacehoderSize options:NSStringDrawingUsesLineFragmentOrigin attributes:placehoderDict context:nil].size;
    self.placehoderLb.hp_height = placehoderSize.height;
}



@end


















