

//
//  UIView+LayerClass.m
//  AboutDraw
//
//  Created by ZhangWei-SpaceHome on 2017/3/21.
//  Copyright © 2017年 zhangwei. All rights reserved.
//

#import "UIView+LayerClass.h"

@implementation UIView (LayerClass)
+(Class)layerClass
{
    return [CAReplicatorLayer class];
}
@end
