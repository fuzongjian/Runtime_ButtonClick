//
//  ViewController.m
//  Runtime_ButtonClick
//
//  Created by 陈舒澳 on 16/4/12.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+DoubleClick.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Runtime_ButtonClick;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark --- SB上拖得东西一样可以用此方法
    self.Runtime_ButtonClick.timeInterval = 2;
    // Do any additional setup after loading the view, typically from a nib.
    
    
#pragma mark --- 纯手写一样可以实现
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor grayColor];
    CGFloat x = CGRectGetMidX(self.view.frame) - 50;
    CGFloat y = CGRectGetMaxY(self.Runtime_ButtonClick.frame) + 10;
    button.timeInterval = 2;
    button.frame = CGRectMake(x, y, 100, 100);
    [button setTitle:@"测试专用" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)test{
    NSLog(@"好好学习，天天向上");
}
- (IBAction)Runtime_ButtonClicked:(id)sender {
    
    NSLog(@"好好学习，天天向上");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
