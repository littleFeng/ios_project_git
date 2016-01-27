//
//  JRInputTextField.h
//  Demo
//
//  Created by fenglishuai on 15/12/14.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRInputTextField : UITextField
@property (nonatomic, strong) UIFont * floatingLabelFont ;
@property (nonatomic, strong) UIColor * floatingLabelTextColor;
@property (nonatomic, strong) UIColor * floatingLabelActiveTextColor;
@property (nonatomic, assign) NSInteger animateEvenIfNotFirstResponder;
@property (nonatomic, strong) NSString * floatingLabelText;

@end
