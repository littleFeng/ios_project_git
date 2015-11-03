//
//  ViewController.m
//  LSProgressViewDemo
//
//  Created by fenglishuai on 15/11/3.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "ViewController.h"
#import "LSProgressView.h"


@interface ViewController ()

@property(nonatomic,strong) LSProgressView * progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _progressView=[[LSProgressView alloc]initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-100, 25)];
    _progressView.trackColor=[UIColor grayColor];
    _progressView.tinkColor=[UIColor blueColor];
    _progressView.progressTextColor=[UIColor blackColor];
    [self.view addSubview:_progressView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    
    CGFloat progress=[_numberField.text floatValue]/100.0f;
    if(progress>1.0f)
        return;
    
    [_progressView setProgress:progress animated:YES];
    
    
}
@end
