//
//  ViewController.m
//  headerView
//
//  Created by 朱明灿 on 17/2/21.
//  Copyright © 2017年 张佳强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * tableView;
@property(strong,nonatomic)UIView * headerView;
@property(strong,nonatomic)UIImageView * imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _headerView.frame.size.width, _headerView.frame.size.height)];
    _imageView.image = [UIImage imageNamed:@"op"];
    [_headerView addSubview:_imageView];
    _tableView.tableHeaderView = _headerView;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * iden = @"iden";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%i",indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
       if (offset>0) {
        CGRect frame = _imageView.frame;
        frame.origin.y = MAX(offset*0.5, 0);
        _imageView.frame = frame;
        _headerView.clipsToBounds = YES;
    }else{
        CGFloat delta = 0.0f;
        CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 240);
        delta = fabs(MIN(0.0f, offset));
        rect.origin.y -= delta;
        rect.size.height += delta;
        _imageView.frame = rect;
        _headerView.clipsToBounds = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
