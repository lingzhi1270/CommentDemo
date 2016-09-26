//
//  CustomCell.m
//  评论Demo
//
//  Created by lingzhi on 16/9/22.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "CustomCell.h"
#import "ViewController.h"

@interface CustomCell()
{
    CGFloat keyboardH;
}

@end

@implementation CustomCell

#pragma mark- getter

- (UIView *)alphaView
{
    if (_alphaView == nil) {
        CGRect rect = [UIScreen mainScreen].bounds;
        _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect))];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardAction)];
        [_alphaView addGestureRecognizer:tap];
        _alphaView.backgroundColor = [UIColor clearColor];
//        _alphaView.alpha = 0.3;
    
        
    }
    return _alphaView;
}


- (UIView *)bgView
{
    if (_bgView == nil) {
     
        CGRect rect = [UIScreen mainScreen].bounds;
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(rect)-40, CGRectGetWidth(rect), 40)];
        _bgView.backgroundColor = [UIColor whiteColor];
        
    }
    return _bgView;
}

- (UITextView *)textView
{
    if (_textView == nil) {
        CGRect rect = [UIScreen mainScreen].bounds;
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, CGRectGetWidth(rect)-80, 30)];
        _textView.backgroundColor = [UIColor lightGrayColor];
        _textView.layer.cornerRadius = 6;
        _textView.layer.masksToBounds = YES;
    }
    return _textView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 30, 30)];
        headImageView.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
        [self.contentView addSubview:headImageView];
        self.headImg = headImageView;

     
        
        
        CGRect rect = [UIScreen mainScreen].bounds;
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CGRectGetWidth(rect)-40, 45, 20, 20);
        [btn setImage:[UIImage imageNamed:@"mobark_pl_replay"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"mobark_pl_replay_on"] forState:UIControlStateSelected];
      
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        self.repleyBtn = btn;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 160, 30)];
        nameLabel.backgroundColor = [UIColor lightGrayColor];
       
        
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        [self.alphaView addSubview:self.bgView];
        [self.bgView addSubview:self.textView];
        [[UIApplication sharedApplication].keyWindow addSubview:self.alphaView];
        self.alphaView.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        
    }
    return self;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    
    NSLog(@"%@",notification.userInfo);
    NSDictionary *dic = notification.userInfo;
    CGRect keyboardF = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    keyboardH = CGRectGetHeight(keyboardF);

    NSLog(@"%f",keyboardH);
    
    
    [UIView animateWithDuration:0.25 animations:^{
       
        CGRect rect = [UIScreen mainScreen].bounds;
        self.bgView.frame = CGRectMake(0, CGRectGetHeight(rect)-40-keyboardH, CGRectGetWidth(rect), 40);
        
        
    }];
    
    
    
}
- (void)btnAction
{

    [self.textView becomeFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        
        
        self.alphaView.hidden = NO;
        CGRect rect = [UIScreen mainScreen].bounds;
        self.bgView.frame = CGRectMake(0, CGRectGetHeight(rect)-40-keyboardH, CGRectGetWidth(rect), 40);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(changeTableviewContentOffset:cellFrame:)]) {
            [self.delegate changeTableviewContentOffset:CGRectGetHeight(rect)-40-keyboardH cellFrame:self.frame];
        }
        
    }];
    

}

- (void)hideKeyboardAction
{
    [self.textView resignFirstResponder];
     CGRect rect = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:0.25 animations:^{
       
         self.bgView.frame = CGRectMake(0, CGRectGetHeight(rect)-40, CGRectGetWidth(rect), 40);
        self.alphaView.hidden = YES;
        
    }];
    
    // 这里类似微信   键盘消失和输入框一起      该代理不需要
//    if (self.delegate &&[self.delegate respondsToSelector:@selector(hideKeyboard:)])
//    {
//        [self.delegate hideKeyboard:CGRectGetHeight(rect)-40];
//    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%ld",(long)self.indexPath.row];
}
@end
