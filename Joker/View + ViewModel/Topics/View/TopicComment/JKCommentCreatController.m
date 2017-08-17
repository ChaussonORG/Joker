//
//  JKCommentCreatController.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/8.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommentCreatController.h"
#import "CHFaceBoard.h"
#import <CHProgressHUD/CHProgressHUD.h>
@interface JKCommentCreatController ()<UITextViewDelegate,CHFaceBoardDelegate>

@property (nonatomic , strong) UILabel * titleTextView;

@property (nonatomic , strong) UITextView *contentView;

@property (nonatomic , strong) UIView *bottomView;

@property (nonatomic , strong) UIButton *emojiBtn;

@property (nonatomic , strong) UIButton *aboutBtn;

@property (nonatomic , strong) UILabel *contentPlaceholder;

@property (nonatomic , strong) UIButton *nextBtn;


@property (nonatomic, strong) NSMutableArray  *photos;

@property (nonatomic, strong) NSMutableArray  *photoUrls;

@property (nonatomic , strong)CHFaceBoard *faceView;

@property (nonatomic , assign) NSInteger restCharacter;

@end

@implementation JKCommentCreatController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.viewModel = [[JKCommentCreatVM alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"评论";

    self.navigationItem.rightBarButtonItem = [self customRightButton];
    
    self.restCharacter = 150;
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.titleTextView = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width - 40, 70)];
    self.titleTextView.numberOfLines = 1;
    self.titleTextView.userInteractionEnabled = YES;
    self.titleTextView.font = [JKStyleConfiguration hugeFont];
    [self.view addSubview:self.titleTextView];
    self.titleTextView.text = self.viewModel.titleStr;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [JKStyleConfiguration lineColor];
    lineView.frame = CGRectMake(20, self.titleTextView.frame.origin.y + self.titleTextView.frame.size.height, ScreenWidth - 40, 1);
    [self.view addSubview:lineView];
    
    self.contentView = [[UITextView alloc]initWithFrame:CGRectMake(20, self.titleTextView.frame.size.height + self.titleTextView.frame.origin.y + 1, self.view.frame.size.width - 40, ScreenHeight - self.titleTextView.frame.size.height - self.titleTextView.frame.origin.y - 50 - 64 - 280 )];
    self.contentView.userInteractionEnabled = YES;
    //    self.contentView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    [self.view addSubview:self.contentView];
    //    self.contentView.font = [JKStyleConfiguration titleFont];
    self.contentView.allowsEditingTextAttributes = YES;
    self.contentView.contentInset = UIEdgeInsetsMake(4, 4, 4, -4);
    self.contentView.backgroundColor = [JKStyleConfiguration whiteColor];
    self.contentView.delegate = self;
    self.contentView.font = [JKStyleConfiguration titleFont];
    self.contentView.text = self.viewModel.content;
    
    
    self.contentPlaceholder = [[UILabel alloc] init];
    self.contentPlaceholder.textColor = [JKStyleConfiguration ccccccColor];
    self.contentPlaceholder.text = @"请输入内容...";
    self.contentPlaceholder.font = [JKStyleConfiguration titleFont];
    self.contentPlaceholder.frame = CGRectMake(10, 30, 100, 20);
    [self.contentView addSubview:self.contentPlaceholder];
    if (self.contentView.text.length > 0) {
        self.contentPlaceholder.hidden = YES;
    }
    else{
        self.contentPlaceholder.hidden = NO;
    }
    if (self.contentView.text.length > 0 && self.titleTextView.text.length > 0) {
        
        [self.nextBtn setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
        self.nextBtn.layer.borderColor = [JKStyleConfiguration blackColor].CGColor;
        self.nextBtn.enabled = YES;
    }
    else{
        
        [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
        
        self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
        self.nextBtn.enabled = NO;
    }
    
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.frame = CGRectMake(0, ScreenHeight - 50 - 64 , ScreenWidth, 50);
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    
    UIView *bottomLineView = [[UIView alloc]init];
    bottomLineView.backgroundColor = [JKStyleConfiguration lineColor];
    bottomLineView.frame = CGRectMake(0, 0, ScreenWidth, 1);
    bottomLineView.backgroundColor = [JKStyleConfiguration lineColor];
    [self.bottomView  addSubview:bottomLineView];
    
    
    self.emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.emojiBtn.frame = CGRectMake(20, 15, 22, 22);
    [self.emojiBtn setImage:[UIImage imageNamed:@"biaoqing"] forState:UIControlStateNormal];
    [self.bottomView addSubview:self.emojiBtn];
    [self.emojiBtn addTarget:self action:@selector(clickEmojiBtn) forControlEvents:UIControlEventTouchUpInside];

    
     self.restCharacter = 150 - self.contentView.text.length;
    self.aboutBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.aboutBtn.frame = CGRectMake(ScreenWidth - 150 - 10, 15, 150, 22);
    [self.aboutBtn setTitle:[NSString stringWithFormat:@"%ld",self.restCharacter ] forState:UIControlStateNormal];
    [self.aboutBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
    self.aboutBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    self.aboutBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.aboutBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.bottomView addSubview:self.aboutBtn];
    self.aboutBtn.enabled = NO;
    
    
    self.faceView = [[CHFaceBoard alloc]init];
    self.faceView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 258);
    //    self.faceView.hidden = YES;
    self.faceView.delegate = self;
    self.faceView.sendBtn.hidden = YES;
    //    [self.view addSubview:self.faceView];
    
    [self binding];
}
- (void)binding{
//    @weakify(self);
//    [RACObserve(self, viewModel.relateWorkName) subscribeNext:^(NSString *x) {
//        @strongify(self);
//        
//        [self.aboutBtn setTitle:[NSString stringWithFormat:@"%@",x] forState:UIControlStateNormal];
//        
//    }];
//    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}

-(UIBarButtonItem*)customRightButton{
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame=CGRectMake(15, 15, 48,23);
    self.nextBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.nextBtn setAdjustsImageWhenHighlighted:NO];
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.userInteractionEnabled = YES;
    [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
    [self.nextBtn setTitle:@"发送" forState:UIControlStateNormal];
    self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
    self.nextBtn.layer.borderWidth = 1;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.nextBtn];
    
    return backItem;
    
    
}

- (void)clickNextBtn{
    

    [self.viewModel creatCommentWithContent:self.contentView.text];
    
    
}

- (void)clickEmojiBtn{
    
    if (self.contentView.inputView) {
        
        self.contentView.inputView = nil;
    }
    else{
        
        self.contentView.inputView = self.faceView;
    }
    
    [self.contentView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.contentView becomeFirstResponder];
    });

    
    
}
#pragma mark 键盘显示的监听方法
-(void)keyboardWillShow:(NSNotification *)notif
{
    
    // 获取键盘的位置和大小
    CGRect keyboardBounds;
    [[notif.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    if (keyboardBounds.size.height == 0) {
        return;
    }
    [UIView animateWithDuration:0.3f animations:^{
        
        // 更改输入框的位置
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(50));
            make.left.right.offset(0);
            make.bottom.equalTo(self.view.mas_bottom).offset(-(keyboardBounds.size.height));
        }];
        
    }];
    
}

#pragma mark 键盘隐藏的监听方法
-(void)keyboardWillHide:(NSNotification *) note
{
    
    
    [UIView animateWithDuration:0.3f animations:^{
        
        // 更改输入框的位置
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(50));
            make.left.right.offset(0);
            make.bottom.offset(0);
        }];
     
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    //    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.contentView.text.length > 0) {
        
        self.contentPlaceholder.hidden = YES;
    }else{
        self.contentPlaceholder.hidden = NO;
        
    }
    
    if (self.contentView.text.length > 0 && self.titleTextView.text.length > 0) {
        
        [self.nextBtn setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
        self.nextBtn.layer.borderColor = [JKStyleConfiguration blackColor].CGColor;
         self.nextBtn.enabled = YES;
    }
    else{
        
        [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
        
        self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
         self.nextBtn.enabled = NO;
    }
    
    self.restCharacter = 150 - self.contentView.text.length;
    
    [self.aboutBtn setTitle:[NSString stringWithFormat:@"%ld",self.restCharacter ] forState:UIControlStateNormal];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (self.contentView.text.length == 150) {
        
        if ([text isEqualToString:@""]) {
            
            return YES;
        }
        else{
            
            return NO;
        }
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clickFaceBoard:(NSString *)string{
    
    [self.contentView insertText:string];
    
}

- (void)cancelFaceMessage{
    
    
    [self.contentView deleteBackward];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
