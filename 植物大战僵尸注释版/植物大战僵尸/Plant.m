//
//  Plant.m
//  植物大战僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Plant.h"

@implementation Plant
//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.HP = 30;
    }
    return self;
}
//剪切图片并做动画
-(void)initAnimations{
    //得到整张图片
    UIImage *zombImage = [UIImage imageNamed:self.plantImageName];
    float w = zombImage.size.width/8;
    NSMutableArray *images = [NSMutableArray array];
    for (int i=0; i<8; i++) {
        CGImageRef subImage = CGImageCreateWithImageInRect(zombImage.CGImage, CGRectMake(i*w, 0, w, zombImage.size.height));
        [images addObject:[UIImage imageWithCGImage:subImage]];
        CGImageRelease(subImage); 
    }
    //设置动画的图片
    [self setAnimationImages:images];
    [self setAnimationDuration:.7];
    [self setAnimationRepeatCount:0];
    [self startAnimating];
}
-(void)beginFire{
    
}

@end
