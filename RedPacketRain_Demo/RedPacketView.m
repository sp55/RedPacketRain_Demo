//
//  RedPacketView.m
//  RedPacketRain_Demo
//
//  Created by admin on 2016/10/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RedPacketView.h"


@interface RedPacketView ()
@property (nonatomic,copy) void(^removedBlock)();

@end

@implementation RedPacketView

- (void)awakeFromNib
{
    [super awakeFromNib];
}
+ (RedPacketView *)loadRedEnvelopeView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"RedPacketView" owner:nil options:nil] firstObject];
}

+ (RedPacketView *)loadRedEnvelopeViewWithRemoveBlock:(void(^)())removeBlock
{
    RedPacketView *redEnvelopeView = [RedPacketView loadRedEnvelopeView];
    UIView *rootControllerView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    redEnvelopeView.frame = rootControllerView.frame;
    [rootControllerView addSubview:redEnvelopeView];
    redEnvelopeView.removedBlock = removeBlock;
    return redEnvelopeView;
}

#pragma mark - 领取红包
- (IBAction)getRedEnvelope:(id)sender {
    _removedBlock();
    [self removeFromSuperview];
}
#pragma mark - 放弃领取红包
- (IBAction)CancelRedEnvelop:(id)sender {
    _removedBlock();
    [self removeFromSuperview];
    
}

@end
