//
//  ZombA.h
//  面向对象僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plant.h"

@interface ZombA : UIImageView
/** 僵尸名称 */
@property (nonatomic, copy)NSString *zombImageName;
/** 僵尸速度 */
@property (nonatomic) float speed;
/** 僵尸原始速度 */
@property (nonatomic) float oldSpeed;
/** 僵尸血量 */
@property (nonatomic) int HP;
/** 僵尸自身的动画 */
- (void)initAnimations;
/** 僵尸吃植物的方法 */
- (void)eatingWithPlant:(id)plant;
@end
