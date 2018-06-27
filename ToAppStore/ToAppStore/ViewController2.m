//
//  ViewController2.m
//  ToAppStore
//
//  Created by 马海平 on 2018/6/27.
//  Copyright © 2018年 马海平. All rights reserved.
//

#import "ViewController2.h"
#import <MJRefresh.h>
@interface ViewController2 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIView * bgview;
@property (nonatomic,strong) UILabel * label;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.tableView];
    [self initRefresh];
}

- (void)initRefresh{
    __weak typeof (UITableView *)weaktb = self.tableView;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        sleep(5);
//        [self.tableView.mj_header endRefreshing];
        [self addSub: weaktb.mj_header];
//        [self.tableView setTransform:CGAffineTransformMakeTranslation(0, 54)];
        [self performSelector:@selector(rmo) withObject:nil afterDelay:5];
//        [self.tableView.mj_header performSelector:@selector(endRefreshing) withObject:nil afterDelay:5];
        
    }];
    
    
    
    self.tableView.mj_header = header;
    [self.tableView.mj_header addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];

//
//    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//    [self.tableView addObserver:self forKeyPath:MJRefreshKeyPathContentOffset options:options context:nil];//contentOffset属性
//    [self.tableView addObserver:self forKeyPath:MJRefreshKeyPathContentSize options:options context:nil];//contentSize属性
//    self.pan = self.tableView.panGestureRecognizer;
//    [self.pan addObserver:self forKeyPath:MJRefreshKeyPathPanState options:options context:nil];//UIPanGestureRecognizer 的state属性


}
-(void)addSub:(MJRefreshHeader * )header{
    
    _bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 54)];
    _bgview.backgroundColor = [[UIColor yellowColor]colorWithAlphaComponent:0.5];
    [header addSubview:_bgview];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _bgview.frame.size.width, _bgview.frame.size.height)];
    _label.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.5];
    _label.text = @"MJRefresh刷新";
    _label.textAlignment = NSTextAlignmentCenter;
    [_bgview addSubview:_label];
    [_bgview setTransform:CGAffineTransformMakeScale(0.3, 0.3)];
    [_label setTransform:CGAffineTransformMakeScale(0.3, 0.3)];
    [UIView animateWithDuration:0.3 animations:^{
        [self.bgview setTransform:CGAffineTransformIdentity];
        [self.label setTransform:CGAffineTransformIdentity];
        
    }];
    
}
- (void)rmo{
//    [self.tableView .mj_header endRefreshing];
    [self.bgview removeFromSuperview];
    [self.label removeFromSuperview];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"state"]) {
        
        
        NSLog(@"%ld",(long)self.tableView.mj_header.state);
//        if (self.tableView.mj_header.state ) {
//            <#statements#>
//        }
    }
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            self.tableView.estimatedRowHeight = 0;
            self.tableView.estimatedSectionFooterHeight = 0;
            self.tableView.estimatedSectionHeaderHeight = 0;
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld个Cell",(long)indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}




















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
