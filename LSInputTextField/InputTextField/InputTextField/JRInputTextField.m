//
//  JRInputTextField.m
//  Demo
//
//  Created by fenglishuai on 15/12/14.
//  Copyright © 2015年 user. All rights reserved.
//

#import "JRInputTextField.h"

@interface JRInputTextField ()

@property (nonatomic, strong, readonly) UILabel * floatingLabel;
@property (nonatomic, assign) CGFloat  floatingLabelY;

@end


@implementation JRInputTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
        if (self.placeholder) {
            self.placeholder = self.placeholder;
        }
    }
    return self;
}

- (void)commonInit
{
    _floatingLabel = [UILabel new];
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];
    
    _floatingLabel.font = [UIFont systemFontOfSize:12.0f];
    _floatingLabelTextColor = [UIColor grayColor];
    _animateEvenIfNotFirstResponder = NO;
}

#pragma mark -

- (UIColor *)getLabelActiveColor
{
    if (_floatingLabelActiveTextColor) {
        return _floatingLabelActiveTextColor;
    }
    else if ([self respondsToSelector:@selector(tintColor)]) {
        return [self performSelector:@selector(tintColor)];
    }
    return [UIColor blueColor];
}

- (void) setFloatingLabelFont:(UIFont *)floatingLabelFont
{
    _floatingLabelFont = floatingLabelFont;
    _floatingLabel.font = (_floatingLabelFont ? _floatingLabelFont : [UIFont systemFontOfSize:12.0f]);
    self.placeholder = self.placeholder;
}

- (void)showFloatingLabel:(BOOL)animated
{
    void (^showBlock)() = ^{
        _floatingLabel.alpha = 1.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          2.0f,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
    };
    
    if (animated || _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:^(BOOL finished) {
                             
                         }];
    }
    else {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated
{
    void (^hideBlock)() = ^{
        _floatingLabel.alpha = 0.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          _floatingLabel.font.lineHeight + _floatingLabelY,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
        
    };
    
    if (animated || _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:^(BOOL finished) {
                             self.placeholder = _floatingLabelText;
                             
                         }];
    }
    else {
        hideBlock();
    }
}

- (void)setLabelOriginForTextAlignment
{
    CGRect textRect = [self textRectForBounds:self.bounds];
    
    CGFloat originX = textRect.origin.x;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        originX = textRect.origin.x + (textRect.size.width/2) - (_floatingLabel.frame.size.width/2);
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
    }
    else 
    {
        originX= textRect.origin.x + 3.0f;
    }
    
    _floatingLabel.frame = CGRectMake(originX+2.0f, _floatingLabel.frame.origin.y,
                                      _floatingLabel.frame.size.width, _floatingLabel.frame.size.height);
}

-(void)setFloatingLabelText:(NSString *)floatingLabelText
{
    _floatingLabelText = floatingLabelText;
    _floatingLabel.text = floatingLabelText;
    [_floatingLabel sizeToFit];
    self.placeholder = floatingLabelText;
}


#pragma mark - UITextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], UIEdgeInsetsMake(ceilf(_floatingLabel.font.lineHeight+_floatingLabelY), 0.0f, 0.0f, 0.0f));
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect([super editingRectForBounds:bounds], UIEdgeInsetsMake(ceilf(_floatingLabel.font.lineHeight+_floatingLabelY), 0.0f, 0.0f, 0.0f));
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    rect = CGRectMake(rect.origin.x, rect.origin.y + (_floatingLabel.font.lineHeight * 0.5f) + (_floatingLabelY * 0.5f), rect.size.width, rect.size.height);
    return rect;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
     return  UIEdgeInsetsInsetRect([super placeholderRectForBounds:bounds], UIEdgeInsetsMake(0, 5.0f, 0, 0));
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.text&&self.text.length > 1)
        return;
    
    [self setLabelOriginForTextAlignment];
    
    if (self.floatingLabelFont) {
        _floatingLabel.font = self.floatingLabelFont;
    }
    BOOL firstResponder = self.isFirstResponder;
    _floatingLabel.textColor = (firstResponder ? self.getLabelActiveColor : self.floatingLabelTextColor);
    if (!firstResponder && (!self.text || self.text.length ==0 )) {
        [self hideFloatingLabel:YES];
    }
    else {
        self.placeholder= @"";
        [self showFloatingLabel:YES];
    }
}


#pragma mark - Accessibility

- (NSString *)accessibilityLabel
{
    NSString *accessibilityLabel;
    if ([self.text isEqualToString:@""] == NO) {
        accessibilityLabel = [self.floatingLabel accessibilityLabel];
    } else {
        accessibilityLabel = self.text;
    }
    return accessibilityLabel;
}

@end
