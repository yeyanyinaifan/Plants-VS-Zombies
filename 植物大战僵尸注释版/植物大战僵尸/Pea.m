//
//  Pea.m
//  植物大战僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Pea.h"

@implementation Pea
//重写父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.plantImageName = @"plant_2";
        self.bulletImageName = @"bullet_0";
        self.bullets = [NSMutableArray array];
        self.costSunCount = 100;
    }
    return self;
}
//开火
-(void)beginFire{
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addBulletAction) userInfo:nil repeats:YES];
}
//开火方式
-(void)addBulletAction{
    UIImageView *bulleIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.superview.center.x+15, self.superview.center.y-20, 15, 15)];
    bulleIV.image = [UIImage imageNamed:self.bulletImageName];
    [self.delegate.view addSubview:bulleIV];
    [self.bullets addObject:bulleIV];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
