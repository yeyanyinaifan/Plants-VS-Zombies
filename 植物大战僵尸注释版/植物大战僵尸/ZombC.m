//
//  ZombC.m
//  面向对象僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZombC.h"

@implementation ZombC
//重写父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zombImageName = @"zomb_2";
        self.speed = 2;
        self.oldSpeed = self.speed;
        self.HP = 12;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
