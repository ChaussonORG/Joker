//
//  JKWorkCommentCreatController.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkCommentCreatController.h"
#import "CHFaceBoard.h"
#import <CHProgressHUD/CHProgressHUD.h>
#import "JWStarView.h"
@interface JKWorkCommentCreatController ()<UITextViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIScrollView *mainScrollView;

@property (nonatomic , strong) UILabel * pointLabel;

@property (nonatomic , strong) JWStarView *starView;

@property (nonatomic , strong) UILabel * pointWordLabel;

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

@implementation JKWorkCommentCreatController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.viewModel = [[JKWorkCommentCreatVM alloc]init];
        
    }
    return self;
}
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{
    
    
    
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
    
    self.mainScrollView = [[UIScrollView alloc]init];
    self.mainScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:self.mainScrollView];
    
    
    self.pointLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 50)/2, 25, 45, 45)];
    self.pointLabel.numberOfLines = 1;
    self.pointLabel.userInteractionEnabled = YES;
    self.pointLabel.textAlignment = NSTextAlignmentCenter;
    self.pointLabel.font = [JKStyleConfiguration MasterFont];
    self.pointLabel.text = @"0";
    [self.mainScrollView addSubview:self.pointLabel];
 
    UILabel *fenLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.pointLabel.frame.origin.x + self.pointLabel.frame.size.width , 40, 50, 20)];
    fenLabel.font = [JKStyleConfiguration titleFont];
    fenLabel.text = @"分";
    [self.mainScrollView addSubview:fenLabel];
    
    
    @weakify(self)
    self.starView =[[JWStarView alloc]initWithFrame:CGRectMake(100 , self.pointLabel.frame.origin.y + self.pointLabel.frame.size.height + 5, ScreenWidth - 200, 30) numberOfStars:5 rateStyle:HalfStar finish:^(CGFloat currentScore) {
        @strongify(self)
        
        if (self.viewModel.score) {
            self.viewModel.score = [NSString stringWithFormat:@"%d",(int)(currentScore*2)];
        }
        NSString *commentWord;
        switch ([self.viewModel.score integerValue]) {
            case 10:
                commentWord = @"完美神作";
                break;
                
            case 9:
                commentWord = @"佳作";
                break;
                
            case 8:
                commentWord = @"佳作";
                break;
                
            case 7:
                commentWord = @"还可以，值得推荐";
                break;
                
            case 6:
                commentWord = @"及格";
                break;
                
            case 5:
                commentWord = @"浪费时间";
                break;
                
            case 4:
                commentWord = @"浪费时间";
                break;
                
            case 3:
                commentWord = @"生理不适";
                break;
                
            case 2:
                commentWord = @"生理不适";
                break;
            case 1:
                commentWord = @"生理不适";
                break;
                
            case 0:
                commentWord = @"这是一坨屎";
                break;
            default:
                break;
        }
        self.pointWordLabel.text = commentWord;
        self.pointLabel.text = [NSString stringWithFormat:@"%ld",[self.viewModel.score integerValue]];
        NSLog(@"star2----%f",currentScore);
    }];
    
    [self.view addSubview:self.starView];
    
    self.pointWordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.starView.frame.origin.y + self.starView.frame.size.height + 20 , ScreenWidth, 20)];
    self.pointWordLabel.font = [JKStyleConfiguration titleFont];
    //    self.pointWordLabel.text = @"这是一坨屎";
    self.pointWordLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.mainScrollView addSubview:self.pointWordLabel];
    
    self.pointLabel.text = [NSString stringWithFormat:@"%ld",[self.viewModel.score integerValue]];
    
    self.starView.currentScore = [self.viewModel.score floatValue]/2;
    
    
    NSString *commentWord;
    switch ([self.viewModel.score integerValue]) {
        case 10:
            commentWord = @"完美神作";
            break;
            
        case 9:
            commentWord = @"佳作";
            break;
            
        case 8:
            commentWord = @"佳作";
            break;
            
        case 7:
            commentWord = @"还可以，值得推荐";
            break;
            
        case 6:
            commentWord = @"及格";
            break;
            
        case 5:
            commentWord = @"浪费时间";
            break;
            
        case 4:
            commentWord = @"浪费时间";
            break;
            
        case 3:
            commentWord = @"生理不适";
            break;
            
        case 2:
            commentWord = @"生理不适";
            break;
        case 1:
            commentWord = @"生理不适";
            break;
            
        case 0:
            commentWord = @"这是一坨屎";
            break;
        default:
            break;
    }
     self.pointWordLabel.text = commentWord;
 
    
    
    self.titleTextView = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width - 40, 70)];
    self.titleTextView.numberOfLines = 1;
    self.titleTextView.userInteractionEnabled = YES;
    self.titleTextView.font = [JKStyleConfiguration hugeFont];
//    [self.view addSubview:self.titleTextView];
    self.titleTextView.text = self.viewModel.titleStr;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [JKStyleConfiguration lineColor];
    lineView.frame = CGRectMake(20, self.pointWordLabel.frame.origin.y + self.pointWordLabel.frame.size.height + 35, ScreenWidth - 40, 1);
    [self.mainScrollView addSubview:lineView];
    
    self.contentView = [[UITextView alloc]initWithFrame:CGRectMake(20,  lineView.frame.size.height +  lineView.frame.origin.y + 1, self.view.frame.size.width - 40, ScreenHeight - self.titleTextView.frame.size.height - self.titleTextView.frame.origin.y - 50 - 64 - 280 )];
    self.contentView.userInteractionEnabled = YES;
    //    self.contentView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    [self.mainScrollView addSubview:self.contentView];
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
    if (self.contentView.text.length > 0 ) {
        
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
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(handleGesture:)];
    
    if (self.contentView.text.length > 0 ) {
        [self.nextBtn setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
        self.nextBtn.layer.borderColor = [JKStyleConfiguration blackColor].CGColor;
        self.nextBtn.enabled = YES;
        

    }
    else{
        [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
        
        self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
        self.nextBtn.enabled = NO;
    }
}

- (void)handleGesture:(UIGestureRecognizer *)gest{
    
    
    
    
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
   
    self.navigationController.navigationBarHidden = NO;
    
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    
    [super viewDidAppear:animated];
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
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
    
    if (self.contentView.text.length > 0 ) {
        
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
