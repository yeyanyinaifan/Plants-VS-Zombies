//
//  ZombA.m
//  面向对象僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZombA.h"
#import "Pea.h"
@implementation ZombA
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zombImageName = @"zomb_0";
        self.speed = .5;
        self.oldSpeed = self.speed;
        self.HP = 4;
    }
    return self;
}
-(void)initAnimations{
    //得到整张图片
    UIImage *zombImage = [UIImage imageNamed:self.zombImageName];
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
//吃植物
- (void)eatingWithPlant:(id)plant{
    self.speed = 0;
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(eatAction:) userInfo:plant repeats:YES];
}
//吃植物的方法
- (void)eatAction:(NSTimer *)timer{
    Plant *plant = timer.userInfo;
    
    plant.HP--;
    if (self.HP <= 0) {
        [timer invalidate];
    }
    if (plant.HP<=0) {
        [plant removeFromSuperview];
        if ([plant isKindOfClass:[Pea class]]) {
            Pea *pea = (Pea *)plant;
            for (UIImageView *bulletIV in pea.bullets) {
                [bulletIV removeFromSuperview];
            }
            [pea.bullets removeAllObjects];
        }
        [plant.delegate.plants removeObject:plant];
        //让timer停止
        [timer invalidate];
        //僵尸继续走
        self.speed = self.oldSpeed;    
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
