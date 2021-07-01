//
//  SSBoxModel.m
//  OPenGLESDemo
//
//  Created by wangjian on 2021/6/30.
//

#import "SSBoxModel.h"

@implementation SSBoxModel

-(void)movePoin:(CGPoint)point{
    
    self.y0 = CGPointMake(point.x + self.y0.x, self.y0.y+point.y);
    self.y1 = CGPointMake(point.x + self.y1.x, self.y1.y+point.y);
    self.y2 = CGPointMake(point.x + self.y2.x, self.y2.y+point.y);
    self.y3 = CGPointMake(point.x + self.y3.x, self.y3.y+point.y);
    
    self.z0 = CGPointMake(point.x + self.z0.x, self.z0.y+point.y);
    self.z1 = CGPointMake(point.x + self.z1.x, self.z1.y+point.y);
    self.z2 = CGPointMake(point.x + self.z2.x, self.z2.y+point.y);
    self.z3 = CGPointMake(point.x + self.z3.x, self.z3.y+point.y);
    
}

-(void)updateL:(CGFloat )L w:(CGFloat)w h:(CGFloat)h canvas:(CGRect)canvas {
    CGFloat geng = 0.707;//根号2
    
    self.y0 = CGPointMake(w*geng, 0); //newy0;
    self.y1 = CGPointMake(L + w *geng, 0);// newy1;
    self.y2 = CGPointMake(L, w * geng);// newy2;
    self.y3 = CGPointMake(0, w * geng);// newy3;
    self.z0 = CGPointMake( w * geng, h);// newz0;
    self.z1 = CGPointMake(L + w * geng, h) ;//newz1;
    self.z2 = CGPointMake(L, h + w * geng);// newz2;
    self.z3 = CGPointMake(0, h + w * geng);// newz3;

    //移动到画布左下角
    CGFloat bottomH = canvas.size.height - geng*w  - h;
    
    //向画布内移动（1，1）,避免显示不全
    self.y0 = CGPointMake(self.y0.x + 1, self.y0.y - 1 + bottomH);
    self.y1 = CGPointMake(self.y1.x + 1, self.y1.y - 1 + bottomH);
    self.y2 = CGPointMake(self.y2.x + 1, self.y2.y - 1 + bottomH);
    self.y3 = CGPointMake(self.y3.x + 1, self.y3.y - 1 + bottomH);
    self.z0 = CGPointMake(self.z0.x + 1, self.z0.y - 1 + bottomH);
    self.z1 = CGPointMake(self.z1.x + 1, self.z1.y - 1 + bottomH);
    self.z2 = CGPointMake(self.z2.x + 1, self.z2.y - 1 + bottomH);
    self.z3 = CGPointMake(self.z3.x + 1, self.z3.y - 1 + bottomH);
    
    
//    NSLog(@"canvas = %@",NSStringFromCGRect(canvas));
//    NSLog(@"y1 = %@",NSStringFromCGPoint(self.y1));
    
    if (self.y1.x > canvas.size.width || self.y1.y < 0) {
        //超出画布区域，实行缩放画布
        
        CGFloat ratioX = self.y1.x / canvas.size.width;
        CGFloat ratioY = (canvas.size.height - self.y1.y) / canvas.size.height;
        
        CGFloat ratio = MAX(ratioX, ratioY);
//        NSLog(@"ratio = %@",@(ratio));

        //画布缩小到 ratio
        if (self.ratioBlock) {
            self.ratioBlock(ratio);
        }
        
    }

}

-(void)updateNewL:(CGFloat )L w:(CGFloat)w h:(CGFloat)h canvas:(CGRect)canvas {
    CGFloat geng = 0.707;//根号2
    
    self.y0 = CGPointMake(w*geng, 0); //newy0;
    self.y1 = CGPointMake(L + w *geng, 0);// newy1;
    self.y2 = CGPointMake(L, w * geng);// newy2;
    self.y3 = CGPointMake(0, w * geng);// newy3;
    self.z0 = CGPointMake( w * geng, h);// newz0;
    self.z1 = CGPointMake(L + w * geng, h) ;//newz1;
    self.z2 = CGPointMake(L, h + w * geng);// newz2;
    self.z3 = CGPointMake(0, h + w * geng);// newz3;

    //移动到画布左下角
    CGFloat bottomH = canvas.size.height - geng*w  - h;
    
    //向画布内移动（1，1）,避免显示不全
    self.y0 = CGPointMake(self.y0.x + 1, self.y0.y - 1 + bottomH);
    self.y1 = CGPointMake(self.y1.x + 1, self.y1.y - 1 + bottomH);
    self.y2 = CGPointMake(self.y2.x + 1, self.y2.y - 1 + bottomH);
    self.y3 = CGPointMake(self.y3.x + 1, self.y3.y - 1 + bottomH);
    self.z0 = CGPointMake(self.z0.x + 1, self.z0.y - 1 + bottomH);
    self.z1 = CGPointMake(self.z1.x + 1, self.z1.y - 1 + bottomH);
    self.z2 = CGPointMake(self.z2.x + 1, self.z2.y - 1 + bottomH);
    self.z3 = CGPointMake(self.z3.x + 1, self.z3.y - 1 + bottomH);
    

}


@end
