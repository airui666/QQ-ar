//
//  circleView.m
//  QQ黏液效果ar
//
//  Created by Apple on 16/5/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "circleView.h"
#import "dragView.h"
#import <POP.h>
@interface circleView()
{
//    dragView *dragV;
}
/** 拖拽圆圆心*/
@property (nonatomic ,assign) CGPoint dragCenter;

/**  固定圆圆心*/
@property (nonatomic ,assign) CGPoint stickCenter;

/**  固定圆半径*/
@property (nonatomic ,assign) CGFloat stickRadius;

/**  固定圆第一个点*/
@property (nonatomic ,assign) CGPoint stickPoint1;

/**  固定圆第二个点*/
@property (nonatomic ,assign) CGPoint stickPoint2;

/**  拖拽圆半径*/
@property (nonatomic ,assign) CGFloat dragRadius;

/**  拖拽圆第一个点*/
@property (nonatomic ,assign) CGPoint dragPoint1;

/**  拖拽圆第二个点*/
@property (nonatomic ,assign) CGPoint dragPoint2;

/**  控制点*/
@property (nonatomic ,assign) CGPoint controlPoint;
/** 记录是否是第一次绘制*/
@property (nonatomic, assign) BOOL first;
/** 能够拉伸的最远距离*/
@property (nonatomic, assign) double maxDistance;

/** 记录是否超出拉伸范围*/
@property (nonatomic, assign, getter=isOutOfRange) BOOL outOfRange;
/** 记录是否需要销毁所有绘图*/
@property (nonatomic, assign, getter=isDisapear) BOOL disapear;
@property(nonatomic,strong)    UIView *popview;

@end
@implementation circleView

static BOOL isfirst;
-(UIView *)popview
{
    if (!_popview) {
        _popview=[[UIView alloc]initWithFrame:CGRectMake(0, 0,40 ,40)];
        [_popview setBackgroundColor:[UIColor redColor]];
        _popview.center=CGPointMake(200, 200);
        _popview.layer.cornerRadius=20;
        [self addSubview:_popview];
    }
    return _popview;
}
-(void)drawRect:(CGRect)rect
{
    
    self.maxDistance=150.0;
    
    //判断是否超出范围   超出范围就不画贝赛尔曲线
    if ([self distance]==0.2) {
        self.outOfRange=YES;//超出范围
    }
    else
    {
        self.outOfRange=NO;//未超出范围
    }
    
    
    if (!isfirst) {
        
        self.dragCenter=CGPointMake(200, 200);
        isfirst=YES;
        self.dragRadius=20;

    }
   else
   {
       self.dragRadius=20*(1-[self distance]);
//       self.popview.alpha=1;


   }
    self.stickRadius=20*[self distance];
//    self.dragRadius=20;
    self.stickCenter=CGPointMake(200, 200);
    
//    self.stickPoint1=CGPointMake(250, 250);
//    self.stickPoint2=CGPointMake(250, 350);
    
//    self.dragPoint1=CGPointMake(50, 250);
//    self.dragPoint2=CGPointMake(50, 350);
    
    //两个圆心之间的距离 大三角斜边
    CGFloat radiusdistance=sqrt((self.stickCenter.x-self.dragCenter.x)*(self.stickCenter.x-self.dragCenter.x)+(self.stickCenter.y-self.dragCenter.y)*(self.stickCenter.y-self.dragCenter.y));
    //大三角邻边
    CGFloat linbian=self.stickCenter.x-self.dragCenter.x;
    //大三角对边
    CGFloat duibian=self.stickCenter.y-self.dragCenter.y;
    
    
    //拖拽圆的两个点
    self.dragPoint1=CGPointMake(duibian/radiusdistance*self.dragRadius+self.dragCenter.x, self.dragCenter.y-linbian/radiusdistance*self.dragRadius);
    
    self.dragPoint2=CGPointMake(self.dragCenter.x-duibian/radiusdistance*self.dragRadius, linbian/radiusdistance*self.dragRadius+self.dragCenter.y);
    //固定圆那两个点
    self.stickPoint1=CGPointMake(duibian/radiusdistance*self.stickRadius+self.stickCenter.x, self.stickCenter.y-linbian/radiusdistance*self.stickRadius);
    self.stickPoint2=CGPointMake(self.stickCenter.x-duibian/radiusdistance*self.stickRadius, linbian/radiusdistance*self.stickRadius+self.stickCenter.y);
    
    //拐点
    self.controlPoint=CGPointMake((self.stickCenter.x-self.dragCenter.x)/2+self.dragCenter.x, (self.stickCenter.y-self.dragCenter.y)/2+self.dragCenter.y);
    
    
    
    //画图－－－－－－－－－－－－－－－－－－－－－－
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    if (self.outOfRange) {
        
    }
    else
    {
        //固定圆
        CGContextAddArc(context, self.stickCenter.x, self.stickCenter.y, self.stickRadius, 0, 2*M_PI, 0);
        [[UIColor redColor]set];
        CGContextFillPath(context);
    }
    
    
    if (self.disapear) {
        
    }
    else
    {
        //拖拽圆
        CGContextAddArc(context, self.dragCenter.x,self.dragCenter.y, self.dragRadius, 0, 2*M_PI, 0);
        [[UIColor redColor]set];
        CGContextFillPath(context);


    }
    
    
    //范围圆
    CGContextAddArc(context, self.stickCenter.x, self.stickCenter.y ,self.maxDistance*(1-0.2), 0, 2*M_PI, 0);
    [[UIColor greenColor] set];
    CGContextStrokePath(context);
    
    
    if (self.outOfRange) {
        
    }
    else
    {
        //贝赛尔曲线
        CGContextMoveToPoint(context, self.stickPoint1.x, self.stickPoint1.y);
        //150  300
        CGContextAddQuadCurveToPoint(context, self.controlPoint.x, self.controlPoint.y, self.dragPoint1.x, self.dragPoint1.y);
        
        CGContextAddLineToPoint(context, self.dragPoint2.x, self.dragPoint2.y);
        CGContextAddQuadCurveToPoint(context, self.controlPoint.x, self.controlPoint.y, self.stickPoint2.x, self.stickPoint2.y);
        [[UIColor redColor]set];
        CGContextFillPath(context);
    }
    
    
    //－－－－－－－－－－－－－－－－－－－－－－－－－
    
    
}

-(CGFloat)distance
{
    //两个圆心的距离
    CGFloat radiusdistance=sqrt((self.stickCenter.x-self.dragCenter.x)*(self.stickCenter.x-self.dragCenter.x)+(self.stickCenter.y-self.dragCenter.y)*(self.stickCenter.y-self.dragCenter.y));
    //去最小的距离
    radiusdistance=MIN(radiusdistance, self.maxDistance);
    
    //计算比例
    CGFloat mm=radiusdistance/self.maxDistance;
    
    if ((1-mm)<0.2) {
        mm=0.2;
    }
    else
    {
        mm=1-mm;
    }
    
    NSLog(@"mm=====%f",mm);
    return mm;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    
    self.dragCenter=[touch locationInView:self];
    
    [self setNeedsDisplay];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    
    self.dragCenter=[touch locationInView:self];
    
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.outOfRange) {
    //超出范围
        NSLog(@"---------------");
        self.disapear=YES;
        [self setNeedsDisplay];
    }
    else
    {
//        self.dragCenter.x,self.dragCenter.y, self.dragRadius
        
        
        
        POPSpringAnimation *scale=[POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scale.toValue=[NSValue valueWithCGSize:CGSizeMake(1.2, 1.2)];
        scale.springSpeed=20;
        scale.springBounciness=20;
        [self.popview pop_addAnimation:scale forKey:nil];
        
        
        POPSpringAnimation *scale2=[POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scale2.toValue=[NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
        scale2.springSpeed=20;
        scale2.springBounciness=20;
        scale2.beginTime=CACurrentMediaTime()+0.1;
        [self.popview pop_addAnimation:scale2 forKey:nil];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.popview removeFromSuperview];
            self.popview=nil;
            NSLog(@"222222222222222");
        });
        
        
        
        
        self.disapear=NO;
        self.dragCenter=self.stickCenter;
        [self setNeedsDisplay];
        
    }

}



-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        NSLog(@"%s",__func__);
    }
    return self;
}





@end
