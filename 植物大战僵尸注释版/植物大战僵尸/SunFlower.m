//
//  SunFlower.m
//  植物大战僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SunFlower.h"

@implementation SunFlower
//重写父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.plantImageName = @"plant_0";
        self.userInteractionEnabled = YES;
        self.costSunCount = 50;
    }
    return self;
}
//开火
-(void)beginFire{
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(addSunAction:) userInfo:nil repeats:YES];
    
}
//开火方式
-(void)addSunAction:(NSTimer *)timer{
    if (self.HP <= 0) {
        [timer invalidate];
    }
    UIButton *sunBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 30, 25, 25)];
    [sunBtn setImage:[UIImage imageNamed:@"sun"] forState:UIControlStateNormal];
    [sunBtn addTarget:self action:@selector(sunClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sunBtn];
    //3秒删除阳光
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeSunAction:) userInfo:sunBtn repeats:NO];
    
}
//删除太阳
-(void)removeSunAction:(NSTimer *)timer{
    UIButton *sunBtn = timer.userInfo;
//    [sunBtn removeFromSuperview];
    CGPoint oldP = CGPointMake(40, 22);
    CGPoint newP = [self.delegate.view convertPoint:oldP toView:self];
    [UIView animateWithDuration:.5 animations:^{
        sunBtn.center = newP;
    } completion:^(BOOL finished) {
        [sunBtn removeFromSuperview];
        [self.delegate addSunCount:25];
    }];
}
//点击太阳
-(void)sunClicked:(UIButton *)sunBtn{
    CGPoint oldP = CGPointMake(40, 22);
    CGPoint newP = [self.delegate.view convertPoint:oldP toView:self];
   [UIView animateWithDuration:.5 animations:^{
        sunBtn.center = newP;
   } completion:^(BOOL finished) {
       [sunBtn removeFromSuperview];
       [self.delegate addSunCount:25];
   }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
