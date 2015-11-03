//
//  LSProgressView.m
//  Demo
//
//  Created by user on 15/10/12.
//  Copyright © 2015年 user. All rights reserved.
//

#import "LSProgressView.h"

@interface LSProgressView ()

@property(nonatomic,strong) UIView * progressBgView;

@property(nonatomic,strong) UIView * progressFroView;

@property(nonatomic,strong) UILabel * progressLabel;

@property(nonatomic,assign) CGFloat height;

@property(nonatomic,assign) CGFloat width;




@end


@implementation LSProgressView


-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        _width=CGRectGetWidth(self.frame);
        _height=CGRectGetHeight(self.frame);
        [self setAutoresizesSubviews:YES];
        self.backgroundColor=[UIColor clearColor];
        [self drawUI];
    
    }
    return self;
}

-(void)drawUI
{
    _progressBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    [_progressBgView autoresizingMask];
    if(_trackColor)
        _progressBgView.backgroundColor=_trackColor;
    else
        _progressBgView.backgroundColor=[UIColor grayColor];
    _progressBgView.layer.cornerRadius=_height*0.5f;
    [_progressBgView.layer masksToBounds];
    [self addSubview:_progressBgView];
    
    
    _progressFroView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, _height)];
    [_progressFroView autoresizingMask];
    if(_tinkColor )
    _progressFroView.backgroundColor=_tinkColor;
    else
    _progressBgView.backgroundColor=[UIColor blueColor];
    [self addSubview:_progressFroView];
    
    UIFont   * font=[UIFont systemFontOfSize:12.0f];
    UIColor  * color=[UIColor blackColor];
    _progressLabel=[[UILabel alloc]init];
    _progressLabel.backgroundColor=[UIColor clearColor];
    _progressLabel.textAlignment=NSTextAlignmentCenter;
    _progressLabel.adjustsFontSizeToFitWidth=YES;
    _progressLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    _progressLabel.textColor=color;
    _progressLabel.font=font;
    [self addSubview:_progressLabel];
    
    [self bringSubviewToFront:_progressLabel];
    [self updateUI];
}

-(void)updateUI
{
    _progressBgView.layer.cornerRadius=_height*0.5f;
    [_progressBgView.layer masksToBounds];
}

#pragma mark--setMethods

-(void)setTrackColor:(UIColor *)trackColor
{
    _progressBgView.backgroundColor=trackColor;
}
-(void)setTinkColor:(UIColor *)tinkColor
{
    _progressFroView.backgroundColor=tinkColor;
}
-(void)setProgressTextColor:(UIColor *)progressTextColor
{
    _progressLabel.textColor=progressTextColor;
}
-(void)setProgress:(CGFloat)progress
{
    NSLog(@"%f",progress*_width);
    _progressFroView.frame=CGRectMake(0, 0, _width*progress, _height);
    UIBezierPath * maskPath;
    maskPath=[UIBezierPath bezierPathWithRoundedRect:_progressFroView.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft) cornerRadii:CGSizeMake(_width*progress, _height)];
    CAShapeLayer * maskLayer=[[CAShapeLayer alloc]init];
    maskLayer.frame=_progressFroView.bounds;
    maskLayer.path=maskPath.CGPath;
    _progressFroView.layer.mask=maskLayer;
    [self showProgressLabel:progress];

}
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    if(animated)
    {
        NSLog(@"%f",progress*_width);
        
        [UIView animateWithDuration:0.5f animations:^{
            _progressFroView.frame=CGRectMake(0, 0, _width*progress, _height);

        } completion:^(BOOL finished) {
            [self showProgressLabel:progress];
        }];
        UIBezierPath * maskPath;
        maskPath=[UIBezierPath bezierPathWithRoundedRect:_progressFroView.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft) cornerRadii:CGSizeMake(_width*progress, _height)];
        CAShapeLayer * maskLayer=[[CAShapeLayer alloc]init];
        maskLayer.frame=_progressFroView.bounds;
        maskLayer.path=maskPath.CGPath;
        _progressFroView.layer.mask=maskLayer;
    }
    else
        [self setProgress:progress]; 

}

-(void)showProgressLabel:(CGFloat)progress

{
    NSString * string=[NSString stringWithFormat:@"%.2f%@",progress*100.0f,@"%"];
    CGFloat w =progress>0.5f? _width*progress:_width*(1-progress);
    _progressLabel.frame=CGRectMake(0, 0, w, _height);
    _progressLabel.text=string;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if(self)
    {
        _width=CGRectGetWidth(frame);
        _height=CGRectGetHeight(frame);
        _progressBgView.frame=CGRectMake(0, 0, _width, _height);
        _progressFroView.frame=CGRectMake(0, 0, _width*_progress, _height);
        [self updateUI];
        [self setProgress:_progress];
    }
    
}
@end
