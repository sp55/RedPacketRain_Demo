//
//  RedPacketView.h
//  RedPacketRain_Demo
//
//  Created by admin on 2016/10/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedPacketView : UIView

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;


+ (RedPacketView *)loadRedEnvelopeView;
+ (RedPacketView *)loadRedEnvelopeViewWithRemoveBlock:(void(^)())removeBlock;

@end
