//
//  JKTopicCreateController.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/5.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicCreateController.h"
#import "HHTUserEditModel.h"
#import "SDBaseResponse.h"
#import "CHFaceBoard.h"
#import <CHProgressHUD/CHProgressHUD.h>

#import "CHImagePicker.h"
#define MARGIN 20.0
@interface JKTopicCreateController ()<UITextViewDelegate,CHFaceBoardDelegate,RefreshSendBtnStatusDelegate>

@property (nonatomic , strong) UITextView * titleTextView;

@property (nonatomic , strong) UITextView *contentView;

@property (nonatomic , strong) UIView *bottomView;

@property (nonatomic , strong) UIButton *emojiBtn;

@property (nonatomic , strong) UIButton *imageBtn;

@property (nonatomic , strong) UIButton *aboutBtn;

@property (nonatomic , strong) NSMutableArray <JKTopicCreateModel *>*dataSource;

@property (nonatomic , strong) UILabel *titlePlaceholder;

@property (nonatomic , strong) UILabel *contentPlaceholder;

@property (nonatomic , strong) UIButton *nextBtn;


@property (nonatomic, strong) NSMutableArray  *photos;

@property (nonatomic, strong) NSMutableArray  *photoUrls;

@property (nonatomic , strong)CHFaceBoard *faceView;

/**
 * 索引数组 －>编辑时记录图片location
 * 1. 添加图片时，要记录该图片的location
 * 2. 删除图片时，通过location与该数组判断得出删除的是哪张照片
 */
@property (nonatomic, strong) NSMutableArray *locations;

@property (nonatomic , assign) NSInteger uploadImageIndex;
@end

@implementation JKTopicCreateController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.viewModel = [[JKTopicCreateVM alloc]init];
        self.viewModel.delegate = self;
        
    }
    return self;
}
- (void)refreshSendBtn{
    
    if (self.contentView.text.length > 0 && self.titleTextView.text.length > 0 && ![self.viewModel.relateWorkName isEqualToString:@"关联作品"]) {
        
        [self.nextBtn setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
        self.nextBtn.layer.borderColor = [JKStyleConfiguration blackColor].CGColor;
        
    }
    else{
        
        [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
        
        self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
        
    }
    
}
- (NSMutableArray *)photoUrls{
    if (!_photoUrls) {
        _photoUrls = [NSMutableArray array];
    }
    return _photoUrls;
}

- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (NSMutableArray *)locations{
    if (!_locations) {
        _locations = [NSMutableArray array];
    }
    return _locations;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"创建话题";
    
    self.dataSource = [NSMutableArray array];
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.titleTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width - 40, 70)];
    self.titleTextView.userInteractionEnabled = YES;
    self.titleTextView.delegate = self;
    self.titleTextView.font = [JKStyleConfiguration hugeFont];
    [self.view addSubview:self.titleTextView];
    
    self.titlePlaceholder = [[UILabel alloc] init];
    self.titlePlaceholder.textColor = [JKStyleConfiguration ccccccColor];
    self.titlePlaceholder.text = @"请输入话题标题";
    self.titlePlaceholder.font = [JKStyleConfiguration hugeFont];
    self.titlePlaceholder.frame = CGRectMake(10, 30, 150, 20);
    [self.titleTextView addSubview:self.titlePlaceholder];
    
    
    @weakify(self);
    [self.titleTextView.rac_textSignal subscribeNext:^(NSString *content){
        @strongify(self);
        self.titlePlaceholder.hidden = (content && content.length > 0);
        
        CGRect textViewFrame = self.titleTextView.frame;
        CGSize textSize = [self.titleTextView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 100.0f)];
        if (textSize.height > 70) {//3行了  两行52 三行70
            while (textSize.height > 70) {
                self.titleTextView.text = [self.titleTextView.text substringToIndex:[self.titleTextView.text length]-1];
                textSize = [self.titleTextView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 100.0f)];
            }
            
        }
        
        if (self.contentView.text.length > 0 && self.titleTextView.text.length > 0 && ![self.viewModel.relateWorkName isEqualToString:@"关联作品"]) {
            
            [self.nextBtn setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
            self.nextBtn.layer.borderColor = [JKStyleConfiguration blackColor].CGColor;
            
        }
        else{
            
            [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
            
            self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
            
        }

    }];
    
    
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
    
    self.contentPlaceholder = [[UILabel alloc] init];
    self.contentPlaceholder.textColor = [JKStyleConfiguration ccccccColor];
    self.contentPlaceholder.text = @"请输入内容...";
    self.contentPlaceholder.font = [JKStyleConfiguration titleFont];
    self.contentPlaceholder.frame = CGRectMake(10, 30, 100, 20);
    [self.contentView addSubview:self.contentPlaceholder];
    
    
    
    
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
    self.emojiBtn.frame = CGRectMake(15, 11, 30, 30);
    [self.emojiBtn setImage:[UIImage imageNamed:@"biaoqing"] forState:UIControlStateNormal];
    [self.bottomView addSubview:self.emojiBtn];
    [self.emojiBtn addTarget:self action:@selector(clickEmojiBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageBtn.frame = CGRectMake(self.emojiBtn.frame.origin.x + self.emojiBtn.frame.size.width + 31, 11, 30, 30);

    [self.imageBtn setImage:[UIImage imageNamed:@"tupian"] forState:UIControlStateNormal];
    [self.imageBtn addTarget:self action:@selector(clickImageBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.imageBtn];
    
   
    
    self.aboutBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.aboutBtn.frame = CGRectMake(ScreenWidth - 150 - 10, 15, 130, 22);
//    [self.aboutBtn setTitle:@"关联作品 >" forState:UIControlStateNormal];
 
    [self.aboutBtn setTitleColor:[JKStyleConfiguration blueKeywordColor] forState:UIControlStateNormal];
    self.aboutBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    self.aboutBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.aboutBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.bottomView addSubview:self.aboutBtn];
    [self.aboutBtn addTarget:self action:@selector(clickAboutBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *arrow = [UIButton buttonWithType:UIButtonTypeCustom];
    arrow.frame = CGRectMake(self.aboutBtn.frame.origin.x + self.aboutBtn.frame.size.width, 15, 20, 22);
   
    [arrow setImage:[UIImage imageNamed:@"guanlian"] forState:UIControlStateNormal];
    
    [arrow addTarget:self action:@selector(clickAboutBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:arrow];

     self.faceView = [[CHFaceBoard alloc]init];
    self.faceView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 258);
//    self.faceView.hidden = YES;
    self.faceView.delegate = self;
    self.faceView.sendBtn.hidden = YES;
//    [self.view addSubview:self.faceView];
    
    [self binding];
}
- (void)binding{
    @weakify(self);
    [RACObserve(self, viewModel.relateWorkName) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        [self.aboutBtn setTitle:[NSString stringWithFormat:@"%@",x] forState:UIControlStateNormal];

    }];
    
    
}
- (void)clickAboutBtn{
    
    [self.viewModel goToRelate];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
    self.navigationItem.rightBarButtonItem = [self customRightButton];
    
    [self refreshSendBtn];
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
    
    self.uploadImageIndex = 0;
    [self uploadImageWithIndex: self.uploadImageIndex];
    
    
    
    
}

- (void)uploadImageWithIndex:(NSInteger)index{
    
    if (index == self.photos.count) {
        [self postToServer];
    }
    else{
        
        UIImage *image = self.photos[index];
        
        @weakify(self)
        [HHTUserEditModel updateAvatarBuy:image success:^(SDBaseResponse *userInfo) {
            @strongify(self);
            
            NSArray *array = (NSArray *)userInfo.data;
            
            NSDictionary *data = [array objectAtIndex:0];
            
            NSString *imageUrl = [data objectForKey:@"url"];
            
            [self.photoUrls addObject:imageUrl];
            
            self.uploadImageIndex++;
            [self uploadImageWithIndex:self.uploadImageIndex];
            
        } failed:^{
            
        }];
        
    }
    
    
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
//    [UIView animateWithDuration:0.3f animations:^{
//        
//        // 更改输入框的位置
//        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(50));
//            make.left.right.offset(0);
//            make.bottom.equalTo(self.view.mas_bottom).offset(-(258));
//        }];
//        
//        
////        [self.faceView mas_remakeConstraints:^(MASConstraintMaker *make) {
////            make.height.equalTo(@(216));
////            make.left.right.offset(0);
////            make.bottom.equalTo(self.view.mas_bottom);
////        }];
//    
//    }];

   
 
}

- (void)clickImageBtn{
    
    self.contentPlaceholder.hidden = YES;
    [self.contentView resignFirstResponder];

    [CHImagePicker show:YES picker:self completion:^(UIImage *image) {
        
        
        [self setAttributeStringWithImage:(UIImage *)image];
        
        [self.contentView becomeFirstResponder];
        
        
        
    }];
    
    
} 
/** 发送数据到服务器*/
- (void)postToServer{
    NSLog(@"\n\n------------------");
    // 1. 发送带有图片标志的纯文本到服务器
    NSString *textString = [self textStringWithSymbol:@"[图片]" attributeString:self.contentView.attributedText];
    NSLog(@"发送带有图片标志的纯文本到服务器, 纯文本内容为:%@", textString);
    
    
    NSArray *arr = [textString componentsSeparatedByString:@"[图片]"];
    
    self.dataSource = [NSMutableArray array];
    for (int i = 0; i< arr.count ;i++ ) {
        
        NSString *str = arr[i];
        
        JKTopicCreateModel *model = [[JKTopicCreateModel alloc]init];
        
        model.dataType = JKTopicDataCharacter;
        
        model.content = str;
        
        [self.dataSource addObject:model];
        
        if (_photos.count  >= (i + 1)) {
            JKTopicCreateModel *modelImage = [[JKTopicCreateModel alloc]init];
            
            modelImage.dataType = JKTopicDataImage;
            
            modelImage.image = _photoUrls[i];
            
            [self.dataSource addObject:modelImage];
        }

    }
    // 2. 发送图片数据到服务器
    NSLog(@"发送图片到图片服务器....");
    
    if (self.titleTextView.text.length == 0) {
        
        [CHProgressHUD showPlainText:@"请输入话题标题"];
        
        return;
    }
    
    if (self.contentView.text.length == 0) {
        
        [CHProgressHUD showPlainText:@"请输入话题内容"];
        
        return;
    }
    
    [self.viewModel createTopicWithTitle:self.titleTextView.text data:self.dataSource];
}

/**
 * 将纯文本中带有图片标志的文本替换为富文本
 * symbol: 图片标志
 * string: 后台返回的纯文本
 * images: 已经保存到本地的图片 -> 网络图片先download到沙盒才能控制size
 */
- (NSAttributedString *)replaceSymbolStringWithSymbol:(NSString *)symbol string:(NSString *)string images:(NSArray *)images{
    
    string = [self stringInsertString:@"\n" frontString:@"[图片]" inString:string];
    // 取出所有图片标志的索引
    NSArray *ranges = [self rangeOfSymbolString:symbol inString:string];
    
#warning Tips 可以先将后台返回的纯文字转成富文本再赋值给textView.attributeText, 或者先其他方式
    
    NSMutableParagraphStyle *paragraStyle = [[NSMutableParagraphStyle alloc] init];
    paragraStyle.lineSpacing = 4.0;
    
    self.contentView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSParagraphStyleAttributeName:paragraStyle,NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    // 只有mutable类型的富文本才能进行编辑
    NSMutableAttributedString *attributeString = [self.contentView.attributedText mutableCopy];
    
#warning Tips about size: 和后台约定好，自己算或者后台给，一般只需要比例即可，可以下载好图片后，利用图片等size计算宽高比.
    
#warning Tips about base: 因为将图片标志替换为图片之后，attributeString的长度回发生变化，所以需要用base进行修正
    
    int base = 0;
    for(int i=0; i < ranges.count; i++){
        NSRange range = NSRangeFromString(ranges[i]);
        // 这里替换图片
        UIImage *image = images[i];
        CGFloat rate = image.size.width / image.size.height;
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = image;
        attach.bounds = CGRectMake(0, 10, self.contentView.frame.size.width - MARGIN, (self.contentView.frame.size.width - MARGIN) / rate);
        [attributeString replaceCharactersInRange:NSMakeRange(range.location + base, range.length) withAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
        base -= (symbol.length - 1);
    }
    
    return attributeString;
}

/** 插入字符串*/
- (NSString *)stringInsertString:(NSString *)insertString frontString:(NSString *)frontString inString:(NSString *)inString{
    NSArray *ranges = [self rangeOfSymbolString:frontString inString:inString];
    NSMutableString *mutableString = [inString mutableCopy];
    NSUInteger base = 0;
    for (NSString *rangeString in ranges) {
        NSRange range = NSRangeFromString(rangeString);
        [mutableString insertString:insertString atIndex:range.location + base];
        base += insertString.length;
    }
    return [mutableString copy];
}

/** 删除字符串*/
- (NSString *)stringDeleteString:(NSString *)deleteString frontString:(NSString *)frontString inString:(NSString *)inString{
    NSArray *ranges = [self rangeOfSymbolString:frontString inString:inString];
    NSMutableString *mutableString = [inString mutableCopy];
    NSUInteger base = 0;
    for (NSString *rangeString in ranges) {
        NSRange range = NSRangeFromString(rangeString);
        [mutableString deleteCharactersInRange:NSMakeRange(range.location - deleteString.length + base, deleteString.length)];
        base -= deleteString.length;
    }
    return [mutableString copy];
}

/** 将图片插入到富文本中*/
- (void)setAttributeStringWithImage:(UIImage *)image{
    // 1. 保存图片与图片的location
    
    if (self.locations.count == 0) {
        [self.photos addObject:image];
        [self.locations addObject:@(self.contentView.selectedRange.location)];
//        [self.photoUrls addObject:imageUrl];
    }
    else{
        NSInteger lastIndex = [[self.locations lastObject] integerValue];
        if (self.contentView.selectedRange.location > lastIndex) {
            
            [self.photos addObject:image];
            [self.locations addObject:@(self.contentView.selectedRange.location)];
//            [self.photoUrls addObject:imageUrl];
        }
        else{
            NSInteger insertIndex = 0;
            
            for (int i = 0; i < self.locations.count; i++) {
                
                NSInteger currentIndex =[self.locations [i]integerValue] ;
                if (i > 0) {
                    
                    NSInteger frontIndex = [self.locations[i-1]integerValue];
                
                    if (self.contentView.selectedRange.location >frontIndex && self.contentView.selectedRange.location <= currentIndex) {
                        [self.photos insertObject:image atIndex:i];
//                        [self.photoUrls insertObject:imageUrl atIndex:i];
                        [self.locations insertObject:@(self.contentView.selectedRange.location) atIndex:i];
                        
                        insertIndex = i;
                        break;
                    }
                }
                else{
                    
                    if (self.contentView.selectedRange.location <= currentIndex) {
                        [self.photos insertObject:image atIndex:i];
//                        [self.photoUrls insertObject:imageUrl atIndex:i];
                        [self.locations insertObject:@(self.contentView.selectedRange.location) atIndex:i];
                       
                        
                         insertIndex = i;
                        
                        break;
                    }
                }
                
            }
            
            for (int i = 0; i < self.locations.count; i++) {
                
                if (i > insertIndex) {
                    
                    NSInteger currentIndex2 = [self.locations[i] integerValue];
                    
                    [self.locations replaceObjectAtIndex:i withObject:@(currentIndex2 + 1)];
                    
                }
            }
            
        }
        
       
        
    }
    
    // 2. 将图片插入到富文本中
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    CGFloat imageRate = image.size.width / image.size.height;
    attach.bounds = CGRectMake(0, 10, self.contentView.frame.size.width - MARGIN, (self.contentView.frame.size.width - MARGIN) / imageRate);
//    attach.bounds = CGRectMake(0, 10, self.contentView.frame.size.width - MARGIN, (self.contentView.frame.size.width - MARGIN) / 5*4);
    NSAttributedString *imageAttr = [NSAttributedString attributedStringWithAttachment:attach];
    //    [mutableAttr replaceCharactersInRange:range withAttributedString:imageAttr];
    NSMutableAttributedString *mutableAttr = [self.contentView.attributedText mutableCopy];
    [mutableAttr insertAttributedString:imageAttr atIndex:self.contentView.selectedRange.location];
    
    [mutableAttr addAttribute:NSFontAttributeName value:[JKStyleConfiguration titleFont] range:NSMakeRange(0, mutableAttr.length)];
    
    self.contentView.attributedText = mutableAttr;
}

/** 将富文本转换为带有图片标志的纯文本*/
- (NSString *)textStringWithSymbol:(NSString *)symbol attributeString:(NSAttributedString *)attributeString{
    NSString *string = attributeString.string;
    string = [self stringDeleteString:@"\n" frontString:@"[图片]" inString:string];
    //最终纯文本
    NSMutableString *textString = [NSMutableString stringWithString:string];
    //替换下标的偏移量
    __block NSUInteger base = 0;
    
    //遍历
    [attributeString enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, attributeString.length)
                                options:0
                             usingBlock:^(id value, NSRange range, BOOL *stop) {
                                 //检查类型是否是自定义NSTextAttachment类
                                 if (value && [value isKindOfClass:[NSTextAttachment class]]) {
                                     //替换
                                     [textString replaceCharactersInRange:NSMakeRange(range.location + base, range.length) withString:symbol];
                                     //增加偏移量
                                     base += (symbol.length - 1);
                                 }
                             }];
    
    return textString;
}

#pragma mark - commonly used
/** 统计文本中所有图片资源标志的range*/
- (NSArray *)rangeOfSymbolString:(NSString *)symbol inString:(NSString *)string {
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString *string1 = [string stringByAppendingString:symbol];
    NSString *temp;
    for (int i = 0; i < string.length; i ++) {
        temp = [string1 substringWithRange:NSMakeRange(i, symbol.length)];
        if ([temp isEqualToString:symbol]) {
            NSRange range = {i, symbol.length};
            [rangeArray addObject:NSStringFromRange(range)];
        }
    }
    return rangeArray;
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
        
        
//        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.bottomView.mas_top);
//            make.right.equalTo(@(-20));
//            make.left.equalTo(@(20));
//            make.top.equalTo(self.titleTextView.mas_bottom).offset(1);
//            
//        }];
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
//        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.bottomView.mas_top);
//            make.right.equalTo(@(-20));
//            make.left.equalTo(@(20));
//            make.top.equalTo(self.titleTextView.mas_bottom).offset(1);
//            
//        }];
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
    
    if (self.contentView.text.length > 0 && self.titleTextView.text.length > 0 && ![self.viewModel.relateWorkName isEqualToString:@"关联作品"]) {
        
        [self.nextBtn setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
        self.nextBtn.layer.borderColor = [JKStyleConfiguration blackColor].CGColor;

    }
    else{
        
        [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
    
        self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;

    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@""]) {
        
        NSString *textString = [self textStringWithSymbol:@"`" attributeString:self.contentView.attributedText];
        
        NSMutableArray *iarr = [NSMutableArray array];
        for (int i = 0 ; i < textString.length; i ++) {
            NSString *charactor = [textString substringWithRange:NSMakeRange(i, 1)];
            if ([charactor isEqualToString:@"`"] ) {
                
                [iarr addObject:@(i)];
                
               
            }
        }
        
        for (int j = 0; j < iarr.count; j++) {
            
            NSInteger index = [iarr[j] integerValue];
            
            if (index == range.location) {
                
                [_locations removeObjectAtIndex:j];
                [_photos removeObjectAtIndex:j];
                
            }
            
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
