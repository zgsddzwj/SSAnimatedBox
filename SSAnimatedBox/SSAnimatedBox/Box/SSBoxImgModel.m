//
//  SSBoxImgModel.m
//  OPenGLESDemo
//
//  Created by wangjian on 2021/6/30.
//

#import "SSBoxImgModel.h"

@implementation SSBoxImgModel

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        if (image) {
            self.image      = image;
            self.imgWidth   = image.size.width;
            self.imgHeight  = image.size.height;
        }
    }
    return self;
}

@end
