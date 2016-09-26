//
//  ViewController.m
//  评论Demo
//
//  Created by lingzhi on 16/9/22.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CommontCellDelegate>
@property (nonatomic,strong)UITableView *commentTab;


@end

@implementation ViewController

- (UITableView *)commentTab
{
    if (_commentTab == nil) {

        _commentTab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _commentTab.backgroundColor = [UIColor whiteColor];
        
//        [_commentTab registerClass:[CustomCell class] forCellReuseIdentifier:@"CustomCell"];
        
        
        _commentTab.delegate = self;
        _commentTab.dataSource = self;
        
        
        
    }
    return _commentTab;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.commentTab];
    
    
    
    
}

#pragma mark- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    

    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
    }
    cell.indexPath = indexPath;
    cell.repleyBtn.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- CommontCellDelegate
- (void)changeTableviewContentOffset:(float)inputViewHight cellFrame:(CGRect)frame
{
    
    [self.commentTab setContentSize:CGSizeMake(self.commentTab.contentSize.width, self.commentTab.contentSize.height+inputViewHight)];
    [self.commentTab setContentOffset:CGPointMake(0, frame.size.height+frame.origin.y+inputViewHight-self.view.frame.size.height-70)];

}

- (void)hideKeyboard:(float)inputViewHight
{
    
    
}


@end
