//
//  SSBoxImgModel.h
//  OPenGLESDemo
//
//  Created by wangjian on 2021/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSBoxImgModel : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGPoint imgPosition;
@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat imgHeight;

- (instancetype)initWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
