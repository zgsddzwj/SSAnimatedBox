//
//  SSBoxView.h
//  OPenGLESDemo
//
//  Created by wangjian on 2021/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSBoxView : UIView

-(void)initBoxModelLength:(CGFloat)l width:(CGFloat)w height:(CGFloat)h;

-(void)updateL:(CGFloat )L w:(CGFloat)w h:(CGFloat)h;

//重置图片
- (void)resetImage;
@end

NS_ASSUME_NONNULL_END
