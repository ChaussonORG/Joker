//
//  JKTimelineListViewController.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTimelineListViewController.h"
#import "YJSliderView.h"
@interface JKTimelineListViewController ()<YJSliderViewDelegate>
@property (nonatomic, strong) YJSliderView *sliderView;


@end

@implementation JKTimelineListViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.viewModel = [[JKTimelineListVM alloc]init];
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];

    
    
    self.sliderView = [[YJSliderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.sliderView.delegate = self;
    
    [self.view addSubview:self.sliderView];
    
       // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    self.navigationController.navigationBarHidden = NO;
    
}
- (NSInteger)numberOfItemsInYJSliderView:(YJSliderView *)sliderView {
    return self.viewModel.titleArrays.count;
}

- (UIView *)yj_SliderView:(YJSliderView *)sliderView viewForItemAtIndex:(NSInteger)index {
    //因为没有写重用的逻辑，建议在控制器中定义view的数组，在此处取出展示(注意在此处定义控制器传入它的view，view中的子视图最好使用约束进行布局)
    UIViewController *vc = self.viewModel.controllerArrays[index];
//    if (index == 0) {
//        vc.view.backgroundColor = [UIColor lightGrayColor];
//    } else if (index == 1) {
//        vc.view.backgroundColor = [UIColor yellowColor];
//    } else if (index == 2) {
//        vc.view.backgroundColor = [UIColor purpleColor];
//    } else {
//        vc.view.backgroundColor = [UIColor orangeColor];
//    }
    return vc.view;
}

- (NSString *)yj_SliderView:(YJSliderView *)sliderView titleForItemAtIndex:(NSInteger)index {
    return self.viewModel.titleArrays[index];
}

- (NSInteger)initialzeIndexForYJSliderView:(YJSliderView *)sliderView {
    return 0;
}

- (NSInteger)yj_SliderView:(YJSliderView *)sliderView redDotNumForItemAtIndex:(NSInteger)index {
    
    
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
