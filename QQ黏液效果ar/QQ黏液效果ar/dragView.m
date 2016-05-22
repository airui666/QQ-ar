//
//  dragView.m
//  QQ黏液效果ar
//
//  Created by Apple on 16/5/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "dragView.h"

@implementation dragView

-(void)drawRect:(CGRect)rect
{
    
    CGContextRef ref=UIGraphicsGetCurrentContext();
    CGContextAddArc(ref, rect.size.width/2, rect.size.height/2, rect.size.width/2, 0, 2*M_PI, 0);
    [[UIColor redColor]set];
    CGContextFillPath(ref);
}

@end
