//
//  FaceView.m
//  TemplateConfigMaker
//
//  Created by guohao on 25/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "FaceView.h"

@interface FaceView()
@property (nonatomic,strong) NSArray* base21points;
@end

@implementation FaceView

- (instancetype)init{
    self = [super init];
    
   
    
    
    return self;
}

- (NSArray*)base21points{
    if (_base21points == nil) {
        
        _base21points = @[
                        // 左眉毛
                        [NSValue valueWithPoint:NSMakePoint(15, 181)],
                        [NSValue valueWithPoint:NSMakePoint(46, 188)],
                        [NSValue valueWithPoint:NSMakePoint(81, 181)],
                        //右眉毛
                        [NSValue valueWithPoint:NSMakePoint(133, 181)],
                        [NSValue valueWithPoint:NSMakePoint(166, 188)],
                        [NSValue valueWithPoint:NSMakePoint(197, 188)],
                        //左眼
                        [NSValue valueWithPoint:NSMakePoint(30, 157)],
                        [NSValue valueWithPoint:NSMakePoint(57, 160)],
                        [NSValue valueWithPoint:NSMakePoint(79, 150)],
                        //右眼
                        [NSValue valueWithPoint:NSMakePoint(139, 153)],
                        [NSValue valueWithPoint:NSMakePoint(161, 160)],
                        [NSValue valueWithPoint:NSMakePoint(186, 158)],
                        //鼻子
                        [NSValue valueWithPoint:NSMakePoint(80, 90)],
                        [NSValue valueWithPoint:NSMakePoint(106, 92)],
                        [NSValue valueWithPoint:NSMakePoint(133, 90)],
                        [NSValue valueWithPoint:NSMakePoint(105, 76)],
                        //嘴巴
                        [NSValue valueWithPoint:NSMakePoint(66, 51)],
                        [NSValue valueWithPoint:NSMakePoint(106, 58)],
                        [NSValue valueWithPoint:NSMakePoint(148, 52)],
                        [NSValue valueWithPoint:NSMakePoint(106, 44)],
                        [NSValue valueWithPoint:NSMakePoint(106, 25)]
                        ];
    }
    
    return _base21points;
}

- (void)drawRect:(NSRect)dirtyRect {
    
    // 左眉毛
    
    CGFloat r = dirtyRect.size.width/217.f;
    NSRect rect = NSRectFromCGRect(CGRectMake(15*r, 180*r, 6*r, 6*r));
    CGFloat l = 6*r;
   
    for (int i = 0; i < self.base21points.count; i++) {
        NSPoint pt = [self.base21points[i] pointValue];
        rect = NSRectFromCGRect(CGRectMake(pt.x*r, pt.y*r, l, l));
        [super drawRect:dirtyRect];
        [[NSColor redColor] set]; //设置颜色
        NSRectFill(rect);
    }
    
    
    
}

@end
