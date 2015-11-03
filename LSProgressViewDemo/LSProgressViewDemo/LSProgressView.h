//
//  LSProgressView.h
//  Demo
//
//  Created by user on 15/10/12.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSProgressView : UIView

@property(nonatomic,strong) UIColor * trackColor;

@property(nonatomic,strong) UIColor * tinkColor;

@property(nonatomic,strong) UIColor * progressTextColor;

@property(nonatomic,assign) CGFloat progress;







-(id)initWithFrame:(CGRect)frame;
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
