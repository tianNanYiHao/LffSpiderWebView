//
//  SpiderWebView.h
//  LffSpiderWebView
//
//  Created by tianNanYiHao on 2017/7/20.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SpiderWebItemType){
    SpiderWebPower = 0,    //力量
    SpiderWebAgile,        //敏捷
    SpiderWebWisdom,       //智慧
    SpiderWebEnergy,       //精力
    SpiderWebSpeed,        //速度
    SpiderWebLucky         //幸运
};


@interface SpiderWebView : UIView





/**
 类方法实例化

 @param frame frame
 @return 实例返回
 */
+(instancetype)createSpideWebViewWith:(CGRect)frame;




/**
 设置六项Value

 @param value value (范围0-1)
 @param type 对应项(0-5)
 */
- (void)spiderWebViewChangeValue:(CGFloat)value type:(SpiderWebItemType)type;
@end
