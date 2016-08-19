//
//  ViewController.m
//  植物大战僵尸
//
//  Created by tarena on 16/7/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "Pea.h"
#import "IcePea.h"
#import "SunFlower.h"
#import "Nut.h"
#import "ZombA.h"
#import "ZombB.h"
#import "ZombC.h"
#import "ZombD.h"

@interface ViewController ()
/** 植物坑的数组 */
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *boxes;
/** 植物的视图数组（各个种类） */
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *plantIVs;
/** 收集的太阳数 */
@property (weak, nonatomic) IBOutlet UILabel *sunCountLabel;
/** 拖拽着的植物 */
@property (nonatomic, strong)Plant *dragPlant;
/** 已创建的僵尸数组 */
@property (nonatomic, strong)NSMutableArray *zombs;
/** 僵尸数 */
@property (nonatomic)int zombCount;
/** 铲子 */
@property (nonatomic, strong)UIImageView *shovelIV;

@end

@implementation ViewController
//创建铲子铲花  注意要吧ImageView的交互打开
- (IBAction)panAction:(UIPanGestureRecognizer *)sender {
    //得到用户触摸屏幕的点
    CGPoint p = [sender locationInView:self.view];
    switch ((int)sender.state) {
        case UIGestureRecognizerStateBegan: {
            self.shovelIV = [[UIImageView alloc]initWithFrame:sender.view.frame];
            self.shovelIV.image = [UIImage imageNamed:@"shovel"];
            [self.view addSubview:self.shovelIV];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            self.shovelIV.center = p;
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.shovelIV removeFromSuperview];
            //判断在哪个坑里松手
            for (UIView *box in self.boxes) {
                if (CGRectContainsPoint(box.frame, p)) {
                    if (box.subviews.count==1) {
                        Plant *plant = [box.subviews lastObject];
                        [plant removeFromSuperview];
                        //把植物从界面中删除的时候如果是射手类型 把界面中的子弹也删除
                        //如果是射手类型
                        if ([plant isKindOfClass:[Pea class]]) {
                            Pea *pea = (Pea *)plant;
                            for (UIImageView *bulletIV in pea.bullets) {
                                [bulletIV removeFromSuperview];
                            }
                            [pea.bullets removeAllObjects];
                        }
                        [self.plants removeObject:plant];
                    }
                    break;
                }
            }
            break;
        }
    }
}

//修改太阳数的方法
-(void)addSunCount:(int)count{
    self.sunCountLabel.text = @(self.sunCountLabel.text.intValue+count).stringValue;
}
//初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    //创建僵尸和植物数组
    self.zombs = [NSMutableArray array];
    self.plants = [NSMutableArray array];
    //开启timer去移动子弹 和 僵尸
    [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
    [self performSelector:@selector(begainAddZombAction) withObject:nil afterDelay:20];
}
//开始添加僵尸
-(void)begainAddZombAction{
    //开启添加僵尸的timer
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addZomb) userInfo:nil repeats:YES];
}
//开始添加僵尸的方法
-(void)addZomb{
    int type = self.zombCount/20;
    int line = arc4random()%5 + 1;
    ZombA *zomb = nil;
    switch (type) {
        case 0:
            zomb = [[ZombA alloc]initWithFrame:CGRectMake(667, line*60, 40, 60)];
            break;
        case 1:
            zomb = [[ZombB alloc]initWithFrame:CGRectMake(667, line*60, 40, 60)];
            break;
        case 2:
            zomb = [[ZombC alloc]initWithFrame:CGRectMake(667, line*60, 40, 60)];
            break;
        default:
            zomb = [[ZombD alloc]initWithFrame:CGRectMake(667, line*60, 40, 60)];
            break;
    }
    zomb.HP += self.zombCount/20;
    //做动画
    [zomb initAnimations];
    //用数组记录所有的僵尸 为了移动
    [self.zombs addObject:zomb];
    [self.view addSubview:zomb];
    self.zombCount++;
}
//移动子弹 僵尸 并僵尸和植物或子弹碰撞检测
-(void)moveAction{
    //遍历每一个植物
    for (Plant *plant in self.plants) {
        //找到射手类型 
//        isMemberOfClass 判断是否是一种类型 
//        isKindOfClass 判断是否是某种类型或者这种类型的子类型
        if ([plant isKindOfClass:[Pea class]]) {
            Pea *pea = (Pea *)plant;
            //遍历射手里面的子弹数组
            for (UIImageView *bulletIV in pea.bullets) {
                //移动子弹
                bulletIV.center = CGPointMake(bulletIV.center.x+4, bulletIV.center.y);
                //如果子弹出了界面 从界面和数组中删除
                if (bulletIV.center.x>self.view.bounds.size.width) {
                    //从界面中删除子弹
                    [bulletIV removeFromSuperview];
                    [pea.bullets removeObject:bulletIV];
                    break;
                }
            }
        }
    }
    //遍历每一个僵尸并移动
    for (ZombA *zomb in self.zombs) {
        zomb.center = CGPointMake(zomb.center.x-zomb.speed, zomb.center.y);
    }
    //碰撞检测
    for (ZombA *zomb in self.zombs) {
        //得到每一个子弹
        //遍历每一个植物
        for (Plant *plant in self.plants) {
            if ([plant isKindOfClass:[Pea class]]) {
                Pea *pea = (Pea *)plant;
                //遍历射手里面的子弹数组
                for (UIImageView *bulletIV in pea.bullets) {
                    
                    if (CGRectIntersectsRect(bulletIV.frame, zomb.frame)) {
                        
                        [bulletIV removeFromSuperview];
                        [pea.bullets removeObject:bulletIV];
                        //判断是不是寒冰射手
                        if ([pea isMemberOfClass:[IcePea class]]&&zomb.alpha == 1) {
                            zomb.speed *= 0.5;
                            zomb.alpha *= 0.8;
                        }
                        //僵尸减血
                        zomb.HP--;
                        if (zomb.HP<=0) {
                            [zomb removeFromSuperview];
                            [self.zombs removeObject:zomb];
                        }
                        return;
                    }
                }
            }
        }
    }
    //僵尸和植物碰撞
    for (ZombA *zomb in self.zombs) {
        for (Plant *plant in self.plants) {
            //判断僵尸和植物所在的坑是否碰撞
            if (CGRectContainsPoint(plant.superview.frame, zomb.center)&&zomb.speed!=0){
                [zomb eatingWithPlant:plant];
            }
        }
    }
    
}
//初始化   取出包含所有种类的植物的图  剪切  赋予图片
-(void)initUI{
    UIImage *plantImage = [UIImage imageNamed:@"seedpackets"];
    float w = plantImage.size.width/18;
    for (int i=0; i<4; i++) {
      //取出每一个植物图片
        UIImageView *plantIV = self.plantIVs[i];
        float x = 0;
        switch (i) {
            case 1:
                x = 2*w;
                break;
            case 2:
                x = 3*w;
                break;
            case 3:
                x = 5*w;
                break;
        }
        CGImageRef subImage = CGImageCreateWithImageInRect(plantImage.CGImage, CGRectMake(x, 0, w, plantImage.size.height));
        plantIV.image = [UIImage imageWithCGImage:subImage];
        CGImageRelease(subImage);
    }
}
//点击到植物图 创建植物
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self.view];
    //得到当前的阳光数量
    int currentSunCount = self.sunCountLabel.text.intValue;
    for (UIImageView *plantIV in self.plantIVs) {
        if (CGRectContainsPoint(plantIV.frame, p)) {
            switch (plantIV.tag) {
                case 0:
                    //如果钱不够 就什么都不做
                    if (currentSunCount<50) {
                        return;
                    }
                    self.dragPlant = [[SunFlower alloc]initWithFrame:plantIV.frame];
                    break;
                case 1:
                    //如果钱不够 就什么都不做
                    if (currentSunCount<100) {
                        return;
                    }
                    self.dragPlant = [[Pea alloc]initWithFrame:plantIV.frame];
                    break;
                case 2:
                    //如果钱不够 就什么都不做
                    if (currentSunCount<150) {
                        return;
                    }
                    self.dragPlant = [[IcePea alloc]initWithFrame:plantIV.frame];
                    break;
                case 3:
                    //如果钱不够 就什么都不做
                    if (currentSunCount<100) {
                        return;
                    }
                    self.dragPlant = [[Nut alloc]initWithFrame:plantIV.frame];
                    break;
            }
            self.dragPlant.delegate = self;
            //开始做动画
            [self.dragPlant initAnimations];
            [self.view addSubview:self.dragPlant];
        }
    }
}
//拖放植物
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self.view];
    self.dragPlant.center = p;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //如果正在拖拽着植物才做判断在哪一个坑里
    if (self.dragPlant) {
        for (UIView *box in self.boxes) {
            //判断在坑里松手 并且坑里没有任何植物的时候
            if (CGRectContainsPoint(box.frame, self.dragPlant.center)&&box.subviews.count==0) {
                [box addSubview:self.dragPlant];
                //显示到坑的中间位置
                self.dragPlant.center = CGPointMake(box.bounds.size.width/2, box.bounds.size.height/2);
                //让植物开火儿
                [self.dragPlant beginFire];
                //把植物保存
                [self.plants addObject:self.dragPlant];
                //花钱
                [self addSunCount:-self.dragPlant.costSunCount];
            }
        }
        //判断如果没有扔到坑里就删除
        if ([self.dragPlant.superview isEqual:self.view]) {
            [self.dragPlant removeFromSuperview];
        }
    }
    self.dragPlant = nil;
}

@end
