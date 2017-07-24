//
//  ViewController.m
//  LffSpiderWebView
//
//  Created by tianNanYiHao on 2017/7/20.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SpiderWebView.h"

@interface ViewController ()
{
    
    SpiderWebView *sipView;
    
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    sipView = [[SpiderWebView alloc] initWithFrame:CGRectMake(0, 50, 200, 200)];
    sipView.center = CGPointMake(self.view.frame.size.width/2, 64+100-20);
    [self.view addSubview:sipView];
    
}




/*
 slider minValue 设置为 0.1
 */

//力量
- (IBAction)pointZero:(UISlider *)sender {
    
    NSLog(@"//力量 :%f",sender.value);
    
    [sipView spiderWebViewChangeValue:sender.value type:SpiderWebPower];
    
}
//敏捷
- (IBAction)pointOne:(UISlider *)sender {
    
    NSLog(@"//敏捷 :%f",sender.value);
    [sipView spiderWebViewChangeValue:sender.value type:SpiderWebAgile];
}
//智慧
- (IBAction)pointTwo:(UISlider *)sender {
    
    NSLog(@"//智慧 :%f",sender.value);
    [sipView spiderWebViewChangeValue:sender.value type:SpiderWebWisdom];
}
//精力
- (IBAction)pointThree:(UISlider *)sender {
    
    NSLog(@"//精力 :%f",sender.value);
    [sipView spiderWebViewChangeValue:sender.value type:SpiderWebEnergy];
}
//速度
- (IBAction)pointFour:(UISlider *)sender {
    
    NSLog(@"//速度 :%f",sender.value);
    [sipView spiderWebViewChangeValue:sender.value type:SpiderWebSpeed];
}
//幸运
- (IBAction)pointFive:(UISlider *)sender {
    
    NSLog(@"//幸运 :%f",sender.value);
    [sipView spiderWebViewChangeValue:sender.value type:SpiderWebLucky];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
