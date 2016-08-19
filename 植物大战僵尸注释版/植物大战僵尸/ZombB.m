//
//  ZombB.m
//  面向对象僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZombB.h"

@implementation ZombB
//重写父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zombImageName = @"zomb_1";
        self.speed = 1;
        self.oldSpeed = self.speed;
        self.HP = 7;
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
