#ifndef __MJConst__M__
#define __MJConst__M__

#import <Foundation/Foundation.h>


int const HPEmotionMaxRows = 3;
int const HPEmotionMaxCols = 7;
int const HPEmotionMaxCountPerPage = (HPEmotionMaxRows * HPEmotionMaxCols - 1);
NSString *const HPEmotionDidSelectedNotification = @"HPEmotionDidSelectedNotification";
NSString *const HPEmotionDidDeletedNotification = @"HPEmotionDidDeletedNotification";
NSString *const HPSelectedEmotion = @"HPSelectedEmotion";

int const HPEmotionToolbarButtonMaxCount = 4;

#endif