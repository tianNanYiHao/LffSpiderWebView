//
//  SpiderWebView.m
//  LffSpiderWebView
//
//  Created by tianNanYiHao on 2017/7/20.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SpiderWebView.h"


#define StrokeColor RGBA(180, 180, 180, 1).CGColor


//注意,此处一定要为float cos/sin 求正余弦均错误
#define radian(degress) (M_PI * (degress/180.f))

#define  itemScaleLineLenth(value,count) (value * radius)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
@interface SpiderWebView ()
{

    //保存的frame
    CGRect rectSize;
    //前景网状View
    UIView *spiderWebView;
    //前景网状layer
    CAShapeLayer *spiderWebLayer;
    //中心点
    CGPoint centrePoint;
    //半径
    CGFloat radius;
    //边宽
    CGFloat strokeLineWith;

    //前景网状Layer路径
    UIBezierPath *path;
    
    //背景图 顺时针 六个点
    CGPoint point0;
    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
    CGPoint point4;
    CGPoint point5;
}

/**
 前景网状layer所显示的最小阀值数组 固定值(0.1)
 */
@property (nonatomic, strong)NSArray *itemArray;
@end


@implementation SpiderWebView

#pragma mark - 实例化
//类方法实例化
+ (instancetype)createSpideWebViewWith:(CGRect)frame{
    
    SpiderWebView *spiderView = [[SpiderWebView alloc] initWithFrame:frame];
    return spiderView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        //1初始化属性
        [self setInfo:frame];

        //2创建蜘蛛网背景layer
        [self buildBackgroundSpiderLayer];
        
        //3创建网状View 及 layer
        [self buildForwardsSpiderView];
        
    }return self;
    
}

/**
 属性初始化赋值
 */
- (void)setInfo:(CGRect)frame{
    rectSize = frame;
    strokeLineWith = 1.0f;
    _itemArray = @[@0.1,@0.1,@0.1,@0.1,@0.1,@0.1];
    radius = frame.size.height/2 - strokeLineWith;
    centrePoint = CGPointMake(frame.size.width/2, frame.size.height/2);
    path = [UIBezierPath bezierPath];
    
}

/**
 绘制背景
 */
- (void)buildBackgroundSpiderLayer{
    for (int i = ((int)_itemArray.count-1); i>0; i--) {
        CAShapeLayer *backGroundSpiderLayer = [CAShapeLayer layer];
        backGroundSpiderLayer.frame = CGRectMake(0, 0, rectSize.size.width, rectSize.size.height);
        [self.layer addSublayer:backGroundSpiderLayer];
        [self backgroundSpiderLayer:backGroundSpiderLayer value:(i*0.2f) count:i];
    }
    self.backgroundColor = [UIColor whiteColor];
}

/**
 绘制前景
 */
- (void)buildForwardsSpiderView{
    
    spiderWebView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rectSize.size.width, rectSize.size.height)];
    spiderWebView.alpha = 0.6f;
    [self addSubview:spiderWebView];
    
    spiderWebLayer = [CAShapeLayer layer];
    spiderWebLayer.frame = CGRectMake(0, 0, rectSize.size.width, rectSize.size.height);
    [spiderWebView.layer addSublayer:spiderWebLayer];
    
    //初始的spiderLayer
    //(目的: 计算出 point0 - 1 的初始值)
    for (int i = 0; i<_itemArray.count; i++) {
        [self spiderWebViewChangeValue:[_itemArray[i] floatValue] type:i];
    }
    
    
}

#pragma mark -  背景SpiderLayer绘制方法
- (void)backgroundSpiderLayer:(CAShapeLayer*)layer value:(CGFloat)value count:(int)count{
    
    /*
     sin(弧度)=对边/斜边
     cos(弧度)=邻边/斜边
     所用到的三角形均为直角, C = 90 = > cline
     A = 30 = > a
     B = 60 = > b
     */
    
    CGFloat realRadius = strokeLineWith + radius;
    
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    CGPoint pointD;
    CGPoint pointE;
    CGPoint pointF;
    
    //pointA
    CGFloat point0X = realRadius;
    CGFloat point0Y = realRadius - itemScaleLineLenth(value,nil);
    pointA = CGPointMake(point0X, point0Y);

    //pointB
    CGFloat alina1 = itemScaleLineLenth(value,nil) *sin(radian(30.f));
    CGFloat blina1 = itemScaleLineLenth(value,nil) *cos(radian(30.f));
    CGFloat point1X = realRadius + blina1;
    CGFloat point1Y = realRadius - alina1;
    pointB = CGPointMake(point1X, point1Y);
    
    //pointC
    CGFloat alina2 = itemScaleLineLenth(value,nil) *sin(radian(30.f));
    CGFloat blina2 = itemScaleLineLenth(value,nil) *cos(radian(30.f));
    CGFloat point2X = realRadius + blina2;
    CGFloat point2Y = realRadius + alina2;
    pointC = CGPointMake(point2X, point2Y);

    //pointD
    CGFloat point3X = realRadius;
    CGFloat point3Y = realRadius + itemScaleLineLenth(value,nil);
    pointD = CGPointMake(point3X, point3Y);
    
    //pointE
    CGFloat alina4 = itemScaleLineLenth(value,nil) *sin(radian(30.f));
    CGFloat blina4 = itemScaleLineLenth(value,nil) *cos(radian(30.f));
    CGFloat point4X = realRadius - blina4;
    CGFloat point4Y = realRadius + alina4;
    pointE = CGPointMake(point4X, point4Y);
    
    //pointF
    CGFloat alina5 = itemScaleLineLenth(value,nil) *sin(radian(30.f));
    CGFloat blina5 = itemScaleLineLenth(value,nil) *cos(radian(30.f));
    CGFloat point5X = realRadius - blina5;
    CGFloat point5Y = realRadius - alina5;
    pointF = CGPointMake(point5X, point5Y);
    
    //绘制网状路径
    UIBezierPath *backGroundSpiderLayerPath = [UIBezierPath bezierPath];
    [backGroundSpiderLayerPath moveToPoint:pointA];
    [backGroundSpiderLayerPath addLineToPoint:pointB];
    [backGroundSpiderLayerPath addLineToPoint:pointC];
    [backGroundSpiderLayerPath addLineToPoint:pointD];
    [backGroundSpiderLayerPath addLineToPoint:pointE];
    [backGroundSpiderLayerPath addLineToPoint:pointF];
    [backGroundSpiderLayerPath closePath];
    
    layer.path = backGroundSpiderLayerPath.CGPath;
    layer.strokeColor = StrokeColor;
    if (count%2 == 0) {
        layer.fillColor = RGBA(216, 216, 216, 1).CGColor;
    }
    if (count%2 == 1) {
        layer.fillColor = RGBA(255, 255, 255, 1).CGColor;
    }
    layer.lineWidth = 0.8f;
    
    //绘制line
    //pointA-D
    [self addLineWihtpointStart:pointA pointEnd:pointD inLayer:layer];
    //pointE-B
    [self addLineWihtpointStart:pointE pointEnd:pointB inLayer:layer];
    //pointF-C
    [self addLineWihtpointStart:pointF pointEnd:pointC inLayer:layer];
    

}

/**
 绘制线段

 @param pointStart 起点
 @param pointEnd 重点
 @param layer 加载的layer
 */
- (void)addLineWihtpointStart:(CGPoint)pointStart pointEnd:(CGPoint)pointEnd inLayer:(CAShapeLayer*)layer{
    
    UIBezierPath *lineStartEndPaht = [UIBezierPath bezierPath];
    [lineStartEndPaht moveToPoint:pointStart];
    [lineStartEndPaht addLineToPoint:pointEnd];
    [lineStartEndPaht closePath];
    CAShapeLayer *lineStartEndlayer = [CAShapeLayer layer];
    lineStartEndlayer.path = lineStartEndPaht.CGPath;
    lineStartEndlayer.lineWidth = 0.8f;
    lineStartEndlayer.fillColor = [UIColor clearColor].CGColor;
    lineStartEndlayer.strokeColor = StrokeColor;
    [layer addSublayer:lineStartEndlayer];

}


#pragma mark -  前景SpiderLayer绘制方法
- (void)spiderWebViewChangeValue:(CGFloat)value type:(SpiderWebItemType)type{
    
    [path removeAllPoints];
    
    /*
     sin(弧度)=对边/斜边
     cos(弧度)=邻边/斜边
     所用到的三角形均为直角, C = 90 = > cline
     A = 30 = > a
     B = 60 = > b
     */
    
    CGFloat realRadius = strokeLineWith + radius;
    
    if (type == SpiderWebPower) {
        //point0
        CGFloat point0X = realRadius;
        CGFloat point0Y = realRadius - itemScaleLineLenth(value,0);
        point0 = CGPointMake(point0X, point0Y);
        
    }
    
    if (type == SpiderWebAgile) {
        //point1
        CGFloat alina1 = itemScaleLineLenth(value,1) *sin(radian(30.f));
        CGFloat blina1 = itemScaleLineLenth(value,1) *cos(radian(30.f));
        CGFloat point1X = realRadius + blina1;
        CGFloat point1Y = realRadius - alina1;
        point1 = CGPointMake(point1X, point1Y);
    }

    if (type == SpiderWebWisdom) {
        //point2
        CGFloat alina2 = itemScaleLineLenth(value,2) *sin(radian(30.f));
        CGFloat blina2 = itemScaleLineLenth(value,2) *cos(radian(30.f));
        CGFloat point2X = realRadius + blina2;
        CGFloat point2Y = realRadius + alina2;
        point2 = CGPointMake(point2X, point2Y);
    }

    
    if (type == SpiderWebEnergy) {
        //point3
        CGFloat point3X = realRadius;
        CGFloat point3Y = realRadius + itemScaleLineLenth(value,3);
        point3 = CGPointMake(point3X, point3Y);
    }

    
    if (type == SpiderWebSpeed) {
        //point4
        CGFloat alina4 = itemScaleLineLenth(value,4) *sin(radian(30.f));
        CGFloat blina4 = itemScaleLineLenth(value,4) *cos(radian(30.f));
        CGFloat point4X = realRadius - blina4;
        CGFloat point4Y = realRadius + alina4;
        point4 = CGPointMake(point4X, point4Y);
    }

    if (type == SpiderWebLucky) {
        //point5
        CGFloat alina5 = itemScaleLineLenth(value,5) *sin(radian(30.f));
        CGFloat blina5 = itemScaleLineLenth(value,5) *cos(radian(30.f));
        CGFloat point5X = realRadius - blina5;
        CGFloat point5Y = realRadius - alina5;
        point5 = CGPointMake(point5X, point5Y);
    }

    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path closePath];
    
    spiderWebLayer.path = path.CGPath;
    spiderWebLayer.strokeColor = RGBA(140, 144, 157, 1).CGColor;
    spiderWebLayer.fillColor = RGBA(29, 204, 140, 1).CGColor;
    spiderWebLayer.lineWidth = 1.f;
}



//path必须在drawRect方法执行 否则报错
/*
 <Error>: CGContextRestoreGState: invalid context 0x0. If you want to see the backtrace, please set CG_CONTEXT_SHOW_BACKTRACE environmental variable.
 */
-(void)drawRect:(CGRect)rect{
//    [path stroke];
//    [path fill];
}


@end
