//
//  Plant.h
//  植物大战僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface Plant : UIImageView
/** 花费太阳数 */
@property (nonatomic)int costSunCount;
/** 植物血量 */
@property (nonatomic)int HP;
/** 代理属性 */
@property (nonatomic, weak)ViewController *delegate;
/** 植物名 */
@property (nonatomic, copy)NSString *plantImageName;
/** 植物自身做动画 */
-(void)initAnimations;
/** 发射子弹或产生太阳 */
-(void)beginFire;
@end

