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

@property (nonatomic,strong) NSArray* face21Points_s0;
@property (nonatomic,strong) NSArray* face21Points_m0;
@property (nonatomic,strong) NSArray* face21Points_m1;
@property NSPoint anchorPoint;
@end

@implementation FaceView

- (instancetype)initWithFrame:(NSRect)frameRect FaceType:(faceType)fType{
    self = [super initWithFrame:frameRect];
    self.anchorPoint = NSMakePoint(-1, -1);
    self.isShowBasePoints = YES;
    
    switch (fType) {
        case faceTypeSingle:
            self.base21Points = self.face21Points_s0;
            break;
        case faceTypeMulty0:
            self.base21Points = self.face21Points_m0;
            break;
        case faceTypeMulty1:
            self.base21Points = self.face21Points_m1;
            break;
        default:
            break;
    }
    
    return self;
}


- (NSArray*)face21Points_s0{
    if (_face21Points_s0 == nil) {
        // 右眉毛 3, 2, 1
        // 左眉毛 6，5，4
        // 左眼   10,18,9
        // 右眼   8, 17, 7
        
        NSArray* array = @[ [NSValue valueWithPoint:NSMakePoint(197, 180)], //1
                            [NSValue valueWithPoint:NSMakePoint(166, 184)], //2
                            [NSValue valueWithPoint:NSMakePoint(133, 178)], //3
                            
                            [NSValue valueWithPoint:NSMakePoint(81, 178)],  //4
                            [NSValue valueWithPoint:NSMakePoint(46, 184)],  //5
                            [NSValue valueWithPoint:NSMakePoint(15, 180)],  //6
                            
                            [NSValue valueWithPoint:NSMakePoint(185, 150)], //7
                            [NSValue valueWithPoint:NSMakePoint(136, 144)], //8
                            
                            [NSValue valueWithPoint:NSMakePoint(77, 144)],  //9
                            [NSValue valueWithPoint:NSMakePoint(29, 150)],  //10
                            
                            [NSValue valueWithPoint:NSMakePoint(140, 89)],  //11
                            [NSValue valueWithPoint:NSMakePoint(108, 75)],  //12
                            [NSValue valueWithPoint:NSMakePoint(77, 89)],   //13
                            
                            [NSValue valueWithPoint:NSMakePoint(108, 54)],  //14
                            [NSValue valueWithPoint:NSMakePoint(108, 44)],  //15
                            [NSValue valueWithPoint:NSMakePoint(108, 29)],  //16
                            
                            [NSValue valueWithPoint:NSMakePoint(157, 150)], //17
                            
                            [NSValue valueWithPoint:NSMakePoint(58, 150)],  //18
                            
                            [NSValue valueWithPoint:NSMakePoint(108, 93)],  //19
                            
                            [NSValue valueWithPoint:NSMakePoint(149, 54)],  //20
                            [NSValue valueWithPoint:NSMakePoint(66, 54)],   //21
                            [NSValue valueWithPoint:NSMakePoint(110, -13)]  //22
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
        _face21Points_s0 = marray;
    }
    return _face21Points_s0;
}

- (NSArray*)face21Points_m0{
    if (_face21Points_m0 == nil) {
        // 右眉毛 3, 2, 1
        // 左眉毛 6，5，4
        // 左眼   10,18,9
        // 右眼   8, 17, 7
        
        _face21Points_m0 = @[ [NSValue valueWithPoint:NSMakePoint(112, 93)], //1
                            [NSValue valueWithPoint:NSMakePoint(94, 101)], //2
                            [NSValue valueWithPoint:NSMakePoint(71, 95)], //3
                            
                            [NSValue valueWithPoint:NSMakePoint(46, 95)],  //4
                            [NSValue valueWithPoint:NSMakePoint(22, 100)],  //5
                            [NSValue valueWithPoint:NSMakePoint(3, 94)],  //6
                            
                            [NSValue valueWithPoint:NSMakePoint(105, 80)], //7
                            [NSValue valueWithPoint:NSMakePoint(76, 80)], //8

                            [NSValue valueWithPoint:NSMakePoint(41, 80)],  //9
                            [NSValue valueWithPoint:NSMakePoint(11, 80)],  //10

                            [NSValue valueWithPoint:NSMakePoint(78, 46)],  //11
                            [NSValue valueWithPoint:NSMakePoint(59, 34)],  //12
                            [NSValue valueWithPoint:NSMakePoint(36, 46)],   //13

                            [NSValue valueWithPoint:NSMakePoint(59, 24)],  //14
                            [NSValue valueWithPoint:NSMakePoint(59, 16)],  //15
                            [NSValue valueWithPoint:NSMakePoint(59, 4)],  //16

                            [NSValue valueWithPoint:NSMakePoint(87, 83)], //17

                            [NSValue valueWithPoint:NSMakePoint(28, 83)],  //18
//
                            [NSValue valueWithPoint:NSMakePoint(59, 44)],  //19
//
                            [NSValue valueWithPoint:NSMakePoint(89, 27)],  //20
                            [NSValue valueWithPoint:NSMakePoint(25, 27)],   //21
                            [NSValue valueWithPoint:NSMakePoint(59, -13)]  //22
                            ];
        
    }
    return _face21Points_m0;
}

- (NSArray*)face21Points_m1{
    if (_face21Points_m1 == nil) {
        // 右眉毛 3, 2, 1
        // 左眉毛 6，5，4
        // 左眼   10,18,9
        // 右眼   8, 17, 7
        
        _face21Points_m1 = @[ [NSValue valueWithPoint:NSMakePoint(130, 119)], //1
                              [NSValue valueWithPoint:NSMakePoint(103, 129)], //2
                              [NSValue valueWithPoint:NSMakePoint(74, 120)], //3
                              
                              [NSValue valueWithPoint:NSMakePoint(47, 116)],  //4
                              [NSValue valueWithPoint:NSMakePoint(19, 119)],  //5
                              [NSValue valueWithPoint:NSMakePoint(0, 102)],  //6
                              
                              [NSValue valueWithPoint:NSMakePoint(117, 102)], //7
                              [NSValue valueWithPoint:NSMakePoint(84, 97)], //8
                              
                              [NSValue valueWithPoint:NSMakePoint(46, 94)],  //9
                              [NSValue valueWithPoint:NSMakePoint(10, 90)],  //10
//
                              [NSValue valueWithPoint:NSMakePoint(92, 64)],  //11
                              [NSValue valueWithPoint:NSMakePoint(69, 51)],  //12
                              [NSValue valueWithPoint:NSMakePoint(45, 59)],   //13
//
                              [NSValue valueWithPoint:NSMakePoint(71, 39)],  //14
                              [NSValue valueWithPoint:NSMakePoint(73, 28)],  //15
                              [NSValue valueWithPoint:NSMakePoint(74, 11)],  //16
//
                              [NSValue valueWithPoint:NSMakePoint(98, 103)], //17
//
                              [NSValue valueWithPoint:NSMakePoint(31, 96)],  //18
//                              //
                              [NSValue valueWithPoint:NSMakePoint(67, 64)],  //19
//                              //
                              [NSValue valueWithPoint:NSMakePoint(106, 36)],  //20
                              [NSValue valueWithPoint:NSMakePoint(36, 30)],   //21
                              [NSValue valueWithPoint:NSMakePoint(74, -13)]  //22
                              ];
        
    }
    return _face21Points_m1;
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
            facePoint = [_base21Points[21] pointValue];
            
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
        
       
        
        for (int i = 0; i < self.base21Points.count; i++) {
            NSPoint pt = [self.base21Points[i] pointValue];
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
