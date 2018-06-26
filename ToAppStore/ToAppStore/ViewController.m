//
//  ViewController.m
//  ToAppStore
//
//  Created by 马海平 on 2018/6/22.
//  Copyright © 2018年 马海平. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>
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
    [button2 setTitle:@"跳转到AppStore" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor blueColor];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(goToAppstoreWay:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 2;
    [self.view addSubview:button2];
    
    
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
        
        
//        [[UIApplication sharedApplication] openURL:
//         [NSURL URLWithString:urlStr8]];
         [SKStoreReviewController requestReview];
         
    }else{
        //第二中方法  应用内跳转
        //1:导入StoreKit.framework,控制器里面添加框架#import <StoreKit/StoreKit.h>
        //2:实现代理SKStoreProductViewControllerDelegate
        SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
        storeProductViewContorller.delegate = self;
        //        ViewController *viewc = [[ViewController alloc]init];
        //        __weak typeof(viewc) weakViewController = viewc;
        
        //加载一个新的视图展示
        [storeProductViewContorller loadProductWithParameters:
         //appId
         @{SKStoreProductParameterITunesItemIdentifier : @"588287777"} completionBlock:^(BOOL result, NSError *error) {
             //回调
             if(error){
                 NSLog(@"错误%@",error);
             }else{
                 //AS应用界面
                 [self presentViewController:storeProductViewContorller animated:YES completion:nil];
             }
         }];
    }
    
    
    
}
#pragma mark - 评分取消按钮监听
//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
