//
//  ViewController.m
//  HPemotionKeyBoard
//
//  Created by shaun on 15/3/17.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "HPEmotionViewController.h"
#import "HPEmotionTextView.h"
#import "HPTextView.h"
#import "HPEmotionKeyboard.h"
#import "UIView+hp.h"
#import "HPComposeToobar.h"
#import "HPEmotion.h"
#import "HPConst.h"

// 屏幕尺寸
#define HPScreenW [UIScreen mainScreen].bounds.size.width
#define HPSelectedEmotion @"HPSelectedEmotion"


@interface HPEmotionViewController ()<UITextViewDelegate,HPComposeToolbarDelegate>
@property (weak, nonatomic) IBOutlet HPEmotionTextView  *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLb;
@property (nonatomic ,strong) HPEmotionKeyboard *keyboard;
@property (nonatomic ,strong) HPComposeToolbar *toolbar;

/**
 *  是否正在切换键盘
 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;
@end

@implementation HPEmotionViewController

- (HPEmotionKeyboard *)kerboard
{
    if (!_keyboard) {
        self.keyboard = [HPEmotionKeyboard keyboard];
        self.keyboard.hp_width = HPScreenW;
        self.keyboard.hp_height = 216;
    }
    return _keyboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];

    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:HPEmotionDidSelectedNotification object:nil];
    // 监听删除按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:HPEmotionDidDeletedNotification object:nil];
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
}

- (void)setupTextView
{
    // 1.创建输入控件
    HPEmotionTextView *textView = [[HPEmotionTextView alloc] init];
    textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textView.frame = CGRectMake(0, 0, self.view.hp_width, 500);
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.设置提醒文字（占位文字）
    textView.placehoder = @"说点什么呢...";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:18];
    
    // 4.监听键盘
//     键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
//     键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// 添加工具条
- (void)setupToolbar
{
    // 1.创建
    HPComposeToolbar *toolbar = [[HPComposeToolbar alloc] init];
    
    toolbar.hp_width= self.view.hp_width;
    toolbar.delegate = self;
    toolbar.hp_height = 44;
    self.toolbar = toolbar;
    
    // 2.显示
    toolbar.hp_y = self.view.hp_height - toolbar.hp_height;
    [self.view addSubview:toolbar];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.isChangingKeyboard) return;
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  当textView的文字改变就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - HMComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(HPComposeToolbar *)toolbar didClickedButton:(HPComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case HPComposeToolbarButtonTypeCamera: // 照相机
            break;
            
        case HPComposeToolbarButtonTypePicture: // 相册
            break;
            
        case HPComposeToolbarButtonTypeEmotion: // 表情
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

/**
 *  打开表情
 */
- (void)openEmotion
{
    // 正在切换键盘
    self.changingKeyboard = YES;
    
    if (self.textView.inputView) { // 当前显示的是自定义键盘，切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情图片
        self.toolbar.showEmotionButton = YES;
    } else { // 当前显示的是系统自带的键盘，切换为自定义键盘
        // 如果临时更换了文本框的键盘，一定要重新打开键盘
        self.textView.inputView = self.kerboard;
        
        // 不显示表情图片
        self.toolbar.showEmotionButton = NO;
    }
    
    // 关闭键盘
    [self.textView resignFirstResponder];
    
    // 更换完毕完毕
    self.changingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.textView becomeFirstResponder];
    });
}

/**
 *  当表情选中的时候调用
 *
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    HPEmotion *emotion = note.userInfo[HPSelectedEmotion];
    
    // 1.拼接表情
    [self.textView appendEmotion:emotion];
    
    // 2.检测文字长度
    [self textViewDidChange:self.textView];
}

/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    // 往回删
    [self.textView deleteBackward];
}

@end




