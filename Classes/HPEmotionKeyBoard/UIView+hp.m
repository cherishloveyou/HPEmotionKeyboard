//
//  UIView+HP.m
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/17.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "UIView+HP.h"

@implementation UIView (hp)



- (void)setHp_x:(CGFloat)hp_x
{
    CGRect frame = self.frame;
    frame.origin.x = hp_x;
    self.frame = frame;
}

- (CGFloat)hp_x
{
    return self.frame.origin.x;
}

- (void)setHp_y:(CGFloat)hp_y
{
    CGRect frame = self.frame;
    frame.origin.y = hp_y;
    self.frame = frame;
}

- (CGFloat)hp_y
{
    return self.frame.origin.y;
}

- (void)setHp_centerX:(CGFloat)hp_centerX
{
    CGPoint center = self.center;
    center.x = hp_centerX;
    self.center = center;
}

- (CGFloat)hp_centerX
{
    return self.center.x;
}

- (void)setHp_centerY:(CGFloat)hp_centerY
{
    CGPoint center = self.center;
    center.y = hp_centerY;
    self.center = center;
}

- (CGFloat)hp_centerY
{
    return self.center.y;
}

- (void)setHp_width:(CGFloat)hp_width
{
    CGRect frame = self.frame;
    frame.size.width = hp_width;
    self.frame = frame;
}

- (CGFloat)hp_width
{
    return self.frame.size.width;
}

- (void)setHp_height:(CGFloat)hp_height
{
    CGRect frame = self.frame;
    frame.size.height = hp_height;
    self.frame = frame;
}

- (CGFloat)hp_height
{
    return self.frame.size.height;
}

- (void)setHp_size:(CGSize)hp_size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = hp_size;
    self.frame = frame;
}

- (CGSize)hp_size
{
    return self.frame.size;
}



@end
