//
//  UIImage+HP.h
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/18.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HP)
/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;
@end
