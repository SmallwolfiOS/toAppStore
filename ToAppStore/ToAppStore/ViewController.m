//
//  ViewController.m
//  ToAppStore
//
//  Created by 马海平 on 2018/6/22.
//  Copyright © 2018年 马海平. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>
#import "ViewController2.h"
#import "SKViewController.h"
@interface ViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    button.center = CGPointMake(self.view.center.x, 100);
    [button setTitle:@"跳转到AppStore" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToAppstoreWay:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    [self.view addSubview:button];
    
    
    UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    button2.center = CGPointMake(self.view.center.x, 200);
    [button2 setTitle:@"跳转到AppStore2" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor blueColor];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(goToAppstoreWay:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 2;
    [self.view addSubview:button2];
    
    UIButton * button3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    button3.center = CGPointMake(self.view.center.x, 300);
    [button3 setTitle:@"跳转到goToAntherVc" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor blueColor];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(goToAntherVc:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 3;
    [self.view addSubview:button3];
}
- (void)goToAppstoreWay:(UIButton *)btn{
    if (btn.tag == 1) {
        //第一种方法  直接跳转
        //以 itms-apps://或https:// 开头的应用详情页链接，跳转到AppStore
        NSString * urlStr = @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=588287777";
        NSString * urlStr2 = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=588287777";
        //itunes
        NSString * urlStr3 = @"itms://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=588287777";
//        NSString * urlStr4 = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=588287777";
        
        //同1
        NSString * urlStr5 = @"itms-apps://itunes.apple.com/cn/app/id588287777?mt=8";
        //评论
        NSString * urlStr6 = @"itms-apps://itunes.apple.com/cn/app/id588287777?mt=8&action=write-review";
        //同1，2
        NSString * urlStr7 = @"itms-apps://itunes.apple.com/app/id588287777";
        //无法连接
        NSString * urlStr8 = @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=588287777&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8";
        [btn setExclusiveTouch:YES];
        
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:urlStr2]];
        
        
        //直接跳转alert弹窗出现评分
       //  [SKStoreReviewController requestReview];
        
    }else{
        //第二中方法  应用内跳转
        //1:导入StoreKit.framework,控制器里面添加框架#import <StoreKit/StoreKit.h>
        //2:实现代理SKStoreProductViewControllerDelegate
        SKViewController *storeProductViewContorller = [[SKViewController alloc] init];
        storeProductViewContorller.delegate = self;
        //        ViewController *viewc = [[ViewController alloc]init];
        //        __weak typeof(viewc) weakViewController = viewc;
        
        //加载一个新的视图展示
        [self presentViewController:storeProductViewContorller animated:YES completion:nil];
        [storeProductViewContorller loadProductWithParameters:
         //appId
         @{SKStoreProductParameterITunesItemIdentifier : @"588287777"} completionBlock:^(BOOL result, NSError *error) {
             //回调
             if(error){
                 NSLog(@"错误%@",error);
             }else{
                 //AS应用界面
                 
                 //如果想像今日头条那样自定义这个弹出vc的大小，可以把view拿出来单独加载
                
//                 [self.view addSubview:storeProductViewContorller.view];
                 
                 //但是后来我发现最终效果并不是今日头条广告展现的拿那样，最终解决办法是子类化SKStoreProductViewController
                 
//               [storeProductViewContorller.view setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height- 100)];
                 
//               [self presentViewController:storeProductViewContorller animated:YES completion:nil];
             }
         }];
    }
}
- (void)goToAntherVc:(UIButton *)btn{
    ViewController2 * pushVC = [[ViewController2 alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:pushVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark - 评分取消按钮监听
//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    //如果想像今日头条那样自定义这个弹出vc的大小，可以把view拿出来单独加载
//    [viewController.view removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
