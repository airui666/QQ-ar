//
//  ViewController.m
//  QQ黏液效果ar
//
//  Created by Apple on 16/5/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "circleView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    circleView *circle=[[circleView alloc]initWithFrame:self.view.bounds];
    [circle setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:circle];
    
    NSLog(@"circle=========%@",circle.layer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)loadView
//{
//    [super loadView];
//    NSLog(@"%s",__func__);
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"%s",__func__);
//}
//
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//NSLog(@"%s",__func__);
//}
@end
