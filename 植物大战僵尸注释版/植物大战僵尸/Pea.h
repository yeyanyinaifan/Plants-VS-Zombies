//
//  Pea.h
//  植物大战僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Plant.h"

@interface Pea : Plant
/** 子弹属性 */
@property (nonatomic, strong)NSMutableArray *bullets;
/** 植物名称 */
@property (nonatomic, copy)NSString *bulletImageName;
@end
