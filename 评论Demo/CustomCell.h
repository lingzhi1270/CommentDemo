//
//  CustomCell.h
//  评论Demo
//
//  Created by lingzhi on 16/9/22.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CommontCellDelegate <NSObject>



- (void)changeTableviewContentOffset:(float)inputViewHight cellFrame:(CGRect)frame;
- (void)hideKeyboard:(float)inputViewHight;

@end
@interface CustomCell : UITableViewCell

@property (nonatomic,assign)id<CommontCellDelegate>delegate;

@property (nonatomic,strong)UIImageView *headImg;
@property (nonatomic,strong)UILabel *nameLabel;

@property (nonatomic,strong)UIButton *repleyBtn;
@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic,strong)UIView *alphaView;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UITextView *textView;

@end
