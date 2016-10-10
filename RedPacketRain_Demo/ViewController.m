//
//  ViewController.m
//  RedPacketRain_Demo
//
//  Created by admin on 2016/10/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "ViewController.h"

#define hb_name         @"hb"
#define kImg_Width            40
#define kImg_X                arc4random()%(int)(Main_Screen_Width - kImg_Width)
#define kImg_Alpha            1
#define kPlus_Height            Main_Screen_Height/25


//#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
//#define IMAGE_WIDTH            arc4random()%20 + 15
#import "UConstants.h"

#import "RedPacketView.h"

@interface ViewController ()
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSTimer  *timer;//定时器
@property (nonatomic,strong) NSMutableArray *array;//数组
@property (nonatomic,strong) NSMutableArray * arrayImage;//图片数组
@property (nonatomic,strong) NSMutableArray * imagesArray;//



@property (nonatomic,strong) RedPacketView *redEnvelopeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array=[NSMutableArray array];
    _arrayImage=[NSMutableArray array];
    _imagesArray = [NSMutableArray array];

    //手势
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:self.tapGesture];
    
    //50个
    for (int i = 0; i < 50; ++ i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:ImageNamed(hb_name)];
        float x = kImg_Width;
        imageView.frame = CGRectMake(kImg_X, -50, x, x+10);
        imageView.alpha = kImg_Alpha;
        [_array addObject:imageView.layer];//layer层
        [_arrayImage addObject:imageView];//图片
        [self.view addSubview:imageView];
        [_imagesArray addObject:imageView];//图片
    }
    //制造红包雨
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(makeRedPacketRain) userInfo:nil repeats:YES];
}
#pragma mark - 制造红包雨
static int i = 0;
- (void)makeRedPacketRain
{
    i = i + 1; //累加
    if ([_imagesArray count] > 0) {
        UIImageView *imageView = [_imagesArray objectAtIndex:0];
        imageView.tag = i;
        [_imagesArray removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
    
}
//下雨
- (void)snowFall:(UIImageView *)aImageView
{
    //CGAffineTransform transform=         CGAffineTransformMakeRotation(M_PI/2);
    [UIView beginAnimations:[NSString stringWithFormat:@"%li",(long)aImageView.tag] context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, Main_Screen_Height, aImageView.frame.size.width, aImageView.frame.size.height);
    //aImageView.transform=transform;
    [UIView commitAnimations];
}

- (void)addImage
{
}

#pragma mark - 红包离开屏幕回收，重置frame
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:[animationID intValue]];
    if ([_imagesArray containsObject:imageView]) {
        return;
    }
    if (!imageView) {
        return;
    }
    float x = kImg_Width;
    imageView.frame = CGRectMake(kImg_X, -50, x, x+10);
    [_imagesArray addObject:imageView];
}



-(void)click:(UITapGestureRecognizer *)tapGesture {
    CGPoint touchPoint = [tapGesture locationInView:self.view];

    if (_redEnvelopeView) {
        return;
    }
    for (UIImageView * imgView in _arrayImage) {

        if ([imgView.layer.presentationLayer hitTest:touchPoint]) {
            [imgView.layer removeAllAnimations];
            [self animationDidStop:[NSString stringWithFormat:@"%li",(long)imgView.tag] finished:nil context:nil];
            RedPacketView *redEnvelopeView = [RedPacketView loadRedEnvelopeViewWithRemoveBlock:^{
                _redEnvelopeView = nil;
            }];
            redEnvelopeView.amountLabel.text = [NSString stringWithFormat:@"%d",arc4random()%(int)(500)];
            _redEnvelopeView = redEnvelopeView;
            
            return;
        }
    }
}


@end
