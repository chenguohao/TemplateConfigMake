//
//  FaceView.m
//  TemplateConfigMaker
//
//  Created by guohao on 25/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "FaceView.h"
#import "LEOSprite.h"

@interface FaceView()
@property (nonatomic,strong) NSArray* base21Points;
@property NSPoint anchorPoint;
@end

@implementation FaceView

- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    self.anchorPoint = NSMakePoint(-1, -1);
   
    self.isShowBasePoints = YES;
    
    return self;
}

- (NSArray*)base21points{
    if (_base21Points == nil) {
        int n = -10;
        NSArray* array = @[ [NSValue valueWithPoint:NSMakePoint(197, 188)], //1
                           [NSValue valueWithPoint:NSMakePoint(166, 188)], //2
                           [NSValue valueWithPoint:NSMakePoint(133, 181)], //3
                           [NSValue valueWithPoint:NSMakePoint(81, 181)],  //4
                           [NSValue valueWithPoint:NSMakePoint(46, 188)],  //5
                           [NSValue valueWithPoint:NSMakePoint(15, 188)],  //6
                           [NSValue valueWithPoint:NSMakePoint(189, 151)], //7
                           [NSValue valueWithPoint:NSMakePoint(139, 148)], //8
                           [NSValue valueWithPoint:NSMakePoint(79, 148)],  //9
                           [NSValue valueWithPoint:NSMakePoint(26, 151)],  //10
                           [NSValue valueWithPoint:NSMakePoint(140, 90+n)],  //11
                            
                           [NSValue valueWithPoint:NSMakePoint(106, 76+n)],  //12
                           [NSValue valueWithPoint:NSMakePoint(73, 90+n)],   //13
                           [NSValue valueWithPoint:NSMakePoint(106, 48)],  //14
                           [NSValue valueWithPoint:NSMakePoint(106, 32)],  //15
                           [NSValue valueWithPoint:NSMakePoint(106, 18)],   //16
                           [NSValue valueWithPoint:NSMakePoint(161, 152)], //17
                           [NSValue valueWithPoint:NSMakePoint(55, 152)],  //18
                           
                           [NSValue valueWithPoint:NSMakePoint(106, 92+n)],  //19
                           [NSValue valueWithPoint:NSMakePoint(154, 45)],  //20
                           [NSValue valueWithPoint:NSMakePoint(60, 45)],   //21
                        ];
        
        NSMutableArray* marray = [NSMutableArray new];
        CGFloat r = self.frame.size.width/218.f;
        for (NSValue* value in array) {
            NSPoint point = [value pointValue];
            point.x *= r;
            point.y *= r;
            NSValue* newValue = [NSValue valueWithPoint:point];
            [marray addObject:newValue];
        }
        _base21Points = marray;
    }
    
    return _base21Points;
}


- (void)setAnchorPointWithType:(SpriteAnchorType)anchorType{
    self.anchorPoint = [self getPointWithAnchorType:anchorType];
    [self setNeedsDisplay:YES];
}

- (NSPoint)getPointWithAnchorType:(SpriteAnchorType)anchorType{
    NSPoint facePoint;
  
    NSInteger l = self.frame.size.width;
    
    switch (anchorType) {
        case SpriteAnchorTypeStatic:{
            facePoint = NSMakePoint(-1, -1);
        }
            break;
        case SpriteAnchorTypeEye://双眼
        {
            NSPoint leftEye = [_base21Points[17] pointValue];
            CGPoint rightEye = [_base21Points[16] pointValue];
            facePoint = NSMakePoint((leftEye.x + rightEye.x) / 2, (leftEye.y + rightEye.y) / 2);
        }
            break;
        case SpriteAnchorTypeMouth://嘴巴
        {
            
            facePoint = [_base21Points[14] pointValue];
        }
            break;
        case SpriteAnchorTypeEar://耳朵
        {
            facePoint = NSMakePoint( l / 2, l *2/ 3);
        }
            break;
        case SpriteAnchorTypeFace://全脸
        {
            facePoint = NSMakePoint( l/2,  l / 2);
        }
            break;
        case SpriteAnchorTypeTophead://头发，头顶
        {
            facePoint = NSMakePoint(l / 2, l);
            
        }
            break;
        case SpriteAnchorTypeTopBody://上半身
        {
            facePoint = NSMakePoint( l / 2, l);
        }
            break;
        case SpriteAnchorTypeNeck://脖子
        {
            facePoint = NSMakePoint(l / 2,  0);//衣服
        }
            break;
        case SpriteAnchorTypeLeftMouthSide://左嘴角
        {
            
            facePoint = [_base21Points[20] pointValue];
            
            
        }
            break;
        case SpriteAnchorTypeRightMouthSide://右嘴角
        {
            
            facePoint = [_base21Points[19] pointValue];
            
        }
            break;
        case SpriteAnchorTypeForehead://额头
        {
            NSPoint leftBrowCenter = [_base21Points[4] pointValue];
            NSPoint rightBrowCenter = [_base21Points[1] pointValue];
            NSPoint browCenter =  NSMakePoint((leftBrowCenter.x + rightBrowCenter.x) / 2, (leftBrowCenter.y + rightBrowCenter.y)/2);
            facePoint = CGPointMake(browCenter.x, (self.frame.size.height + browCenter.y)/ 2);
            
        }
            break;
        case SpriteAnchorTypeCheek://脸颊
        case SpriteAnchorTypeApexNose://鼻尖
        {
            
            facePoint = [_base21Points[18] pointValue];
            
        }
            break;
        case SpriteAnchorTypeEarLeft://左耳朵
        {
            facePoint = NSMakePoint(0, l*2 / 3);
            
        }
            break;
        case SpriteAnchorTypeEarRight://右耳朵
        {
            
            facePoint = CGPointMake(l, l*2 / 3);
            
        }
            break;
        case SpriteAnchorTypeLeftEyebrow://左眉毛
        {
            facePoint = [_base21Points[4] pointValue];
            
        }
            break;
        case SpriteAnchorTypeRightEyebrow://右眉毛
        {
            
            facePoint = [_base21Points[1] pointValue];
            
        }
            break;
        case SpriteAnchorTypeCenterEyebrow://眉心
        {
            CGPoint leftBrow = [_base21Points[4] pointValue];
            CGPoint rightBrow = [_base21Points[1] pointValue];
            facePoint = CGPointMake((leftBrow.x + rightBrow.x)/2, (leftBrow.y + rightBrow.y)/2);
        }
            break;
        case SpriteAnchorTypeEyeLeft://左眼睛
        {
            
            facePoint = [_base21Points[17] pointValue];
            
        }
            break;
        case SpriteAnchorTypeEyeRight://右眼睛
        {
            
            facePoint = [_base21Points[16] pointValue];
            
        }
            break;
        case SpriteAnchorTypeUpMouth://上嘴唇
        {
            facePoint = [_base21Points[13] pointValue];
            
        }
            break;
        case SpriteAnchorTypeLowerJaw://下巴
        {
            facePoint = NSMakePoint(l/2, 0);
            
        }
            break;
        case SpriteAnchorTypeNostril://鼻孔
        {
            facePoint = [_base21Points[11] pointValue];
            
        }
            break;
        case SpriteAnchorTypeDownMouth://下嘴唇
        {
            facePoint = [_base21Points[15] pointValue];
            
        }
            break;
        case SpriteAnchorTypeInLeftEyeSide://内眼角左
        case SpriteAnchorTypeInRightEyeSide://内眼角右
        case SpriteAnchorTypeOutLeftEyeSide://外眼角左
        case SpriteAnchorTypeOutRightEyeSide://外眼角右
        {
            
        }
            break;
        case SpriteAnchorTypeLeftCheek: // 左脸颊
        {
            facePoint = NSMakePoint([_base21Points[9] pointValue].x, [_base21Points[18] pointValue].y);
        }
            break;
        case SpriteAnchorTypeRightCheek: //右脸颊
        {
            facePoint = NSMakePoint([_base21Points[6] pointValue].x, [_base21Points[18] pointValue].y);
        }
            break;
    }
    return facePoint;
    
    
}

- (void)setIsShowBasePoints:(BOOL)isShowBasePoints{
    _isShowBasePoints = isShowBasePoints;
    [self setNeedsDisplay:YES];
}



- (void)drawRect:(NSRect)dirtyRect {
      [super drawRect:dirtyRect];

    CGFloat r = 1;
    CGFloat l = 4*r;
    NSRect rect = NSRectFromCGRect(CGRectMake(15*r, 180*r, l, l));
    
    CGFloat w = dirtyRect.size.width;
    //L top
    NSColor* lineColor = [NSColor purpleColor];
    rect = NSRectFromCGRect(CGRectMake(0, 0, w, 1));
    [lineColor set]; //设置颜色
    NSRectFill(rect);
    
    
    // bottom
    rect = NSRectFromCGRect(CGRectMake(0, w-1, w, 1));
    [lineColor set]; //设置颜色
    NSRectFill(rect);
    
    // left
    // left
    rect = NSRectFromCGRect(CGRectMake(0, 0, 1, w));
    [lineColor set]; //设置颜色
    NSRectFill(rect);
    
    rect = NSRectFromCGRect(CGRectMake(w-1, 0, 1, w));
    [lineColor set]; //设置颜色
    NSRectFill(rect);
    
    if (self.isShowBasePoints) {
        
       
        
        for (int i = 0; i < self.base21points.count; i++) {
            NSPoint pt = [self.base21points[i] pointValue];
            rect = NSRectFromCGRect(CGRectMake(pt.x*r, pt.y*r, l, l));
            
            [[NSColor redColor] set]; //设置颜色
            NSRectFill(rect);
        }

    }
    
    if (self.anchorPoint.x != -1) {
        CGFloat y =  self.anchorPoint.y;
        CGFloat x =  self.anchorPoint.x;
        
        if ((dirtyRect.size.width - x)<=1) {
            x = dirtyRect.size.width -l/2;
        }
        
        if ( (dirtyRect.size.height - y)<=1) {
            y = dirtyRect.size.height -l/2;
        }
        rect = NSRectFromCGRect(CGRectMake(x,y, l, l));
      
        [[NSColor blueColor] set]; //设置颜色
        NSRectFill(rect);
    }
    
    
    
}

@end
