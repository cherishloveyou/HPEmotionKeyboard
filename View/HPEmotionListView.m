//
//  HPEmotionListView.m
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/18.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "HPEmotionListView.h"
#import "HPEmotionGridView.h"
#import "HPConst.h"
#import "UIView+hp.h"

@interface HPEmotionListView ()<UIScrollViewDelegate>

/** 显示所有表情的UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 显示页码的UIPageControl */
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HPEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        // 滚动条是UIScrollView的子控件
        // 隐藏滚动条，可以屏蔽多余的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        //        scrollView.backgroundColor = [UIColor redColor];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        //        pageControl.backgroundColor = [UIColor blueColor];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 设置总页数
    int totalPages = ((int)emotions.count + HPEmotionMaxCountPerPage - 1) / HPEmotionMaxCountPerPage;
    NSInteger currentGridViewCount = self.scrollView.subviews.count;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    
    // 决定scrollView显示多少页表情
    for (int i = 0; i<totalPages; i++) {
        // 获得i位置对应的HMEmotionGridView
        HPEmotionGridView *gridView = nil;
        if (i >= currentGridViewCount) { // 说明HMEmotionGridView的个数不够
            gridView = [[HPEmotionGridView alloc] init];
            //            gridView.backgroundColor = HMRandomColor;
            [self.scrollView addSubview:gridView];
        } else { // 说明HMEmotionGridView的个数足够，从self.scrollView.subviews中取出HMEmotionGridView
            gridView = self.scrollView.subviews[i];
        }
        
        // 给HMEmotionGridView设置表情数据
        int loc = i * HPEmotionMaxCountPerPage;
        int len = HPEmotionMaxCountPerPage;
        if (loc + len > emotions.count) { // 对越界进行判断处理
            len = emotions.count - loc;
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridView.emotions = gridViewEmotions;
        gridView.hidden = NO;
    }
    
//     隐藏后面的不需要用到的gridView
    for (int i = totalPages; i<currentGridViewCount; i++) {
        HPEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
    
    // 表情滚动到最前面
    self.scrollView.contentOffset = CGPointZero;
    
    //    HMLog(@"setEmotions---%d", self.scrollView.subviews.count);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.UIPageControl的frame
    self.pageControl.hp_width = self.hp_width;
    self.pageControl.hp_height = 35;
    self.pageControl.hp_y = self.hp_height - self.pageControl.hp_height;
    
    // 2.UIScrollView的frame
    self.scrollView.hp_width = self.hp_width;
    self.scrollView.hp_height = self.pageControl.hp_y;
    
    // 3.设置UIScrollView内部控件的尺寸
    NSInteger count = self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.hp_width;
    CGFloat gridH = self.scrollView.hp_height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
//        HMEmotionGridView *gridView = self.scrollView.subviews[i];
//        gridView.hp_width = gridW;
//        gridView.hp_height = gridH;
//        gridView.hp_x = i * gridW;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.hp_width + 0.5);
}

@end
