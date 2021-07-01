//
//  SSBoxModel.h
//  OPenGLESDemo
//
//  Created by wangjian on 2021/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSBoxScaleRatioBlock)(CGFloat ratio);

@interface SSBoxModel : NSObject

///上面4个点
@property(nonatomic,assign) CGPoint y0;
@property(nonatomic, assign) CGPoint y1;
@property(nonatomic, assign) CGPoint y2;
@property(nonatomic, assign) CGPoint y3;

///下面4个点
@property(nonatomic, assign) CGPoint z0;
@property(nonatomic, assign) CGPoint z1;
@property(nonatomic, assign) CGPoint z2;
@property(nonatomic, assign) CGPoint z3;

@property (nonatomic, copy) SSBoxScaleRatioBlock ratioBlock;



-(void)movePoin:(CGPoint )point;

-(void)updateL:(CGFloat )L w:(CGFloat)w h:(CGFloat)h canvas:(CGRect)canvas;

-(void)updateNewL:(CGFloat )L w:(CGFloat)w h:(CGFloat)h canvas:(CGRect)canvas;

@end

NS_ASSUME_NONNULL_END
