//
//  ViewController.h
//  植物大战僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
/** 已创建的植物数组 */
@property (nonatomic, strong)NSMutableArray *plants;
//添加太阳数
-(void)addSunCount:(int)count;
@end

