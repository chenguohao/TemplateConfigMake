//
//  LEOSpriteObject.h
//  biubiu
//
//  Created by Ternence on 16/1/29.
//  Copyright © 2016年 LEO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
typedef NS_ENUM(NSUInteger, SpriteType) {
    SpriteTypeStatic = 0,//静态
    SpriteTypeDynamic,//动态
    SpriteTypeCondition,//条件触发
};


typedef NS_ENUM(NSUInteger, SpriteTriggerType) {
    SpriteTriggerTypeStartRightNow,//动画立即触发
    SpriteTriggerTypeStartFrom,//动画等待触发
};



typedef NS_ENUM(NSUInteger, SpriteAnchorType) {
    SpriteAnchorTypeStatic = 0,//静态
    SpriteAnchorTypeTophead = 1,//头发，头顶
    SpriteAnchorTypeForehead = 2,//额头
    SpriteAnchorTypeLeftEyebrow = 3,//左眉毛
    SpriteAnchorTypeRightEyebrow = 4,//右眉毛
    SpriteAnchorTypeCenterEyebrow = 5,//眉心
    
    SpriteAnchorTypeEye = 6,//双眼
    SpriteAnchorTypeEyeLeft = 7,//左眼睛
    SpriteAnchorTypeEyeRight = 8,//右眼睛
    
    SpriteAnchorTypeApexNose = 9,//鼻尖
    SpriteAnchorTypeLeftNostril = 10,//左鼻孔
    SpriteAnchorTypeRightNostril = 11,//右鼻孔
    SpriteAnchorTypeMouth = 12,//嘴巴
    SpriteAnchorTypeLeftMouthSide = 13,//左嘴角
    SpriteAnchorTypeRightMouthSide = 14,//右嘴角
    SpriteAnchorTypeCheek = 15,//脸颊
    SpriteAnchorTypeNeck = 16,//脖子
    
    SpriteAnchorTypeEar = 17,//耳朵
    SpriteAnchorTypeEarLeft = 18,
    SpriteAnchorTypeEarRight = 19,
    
    SpriteSubTypeTopBody = 20,//上半身
    SpriteSubTypeFace = 21, //全脸
    
};

@interface LEOSprite : NSObject
@property (nonatomic, strong) NSImageView* imageView;
@property (nonatomic, assign) SpriteType spriteType;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) SpriteTriggerType triggerType;
@property (nonatomic, assign) BOOL recycle;
@property (nonatomic, strong) NSString *spriteName;
@property (nonatomic, assign) CGFloat startTime;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) NSInteger animationCount;
@property (nonatomic, assign) NSInteger animationFrame;
@property (nonatomic, strong) NSImage *frameImage;
@property (nonatomic, assign) CGFloat pos_x;
@property (nonatomic, assign) CGFloat pos_y;

@property (nonatomic, assign) CGFloat anchor_x;
@property (nonatomic, assign) CGFloat anchor_y;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) SpriteAnchorType anchorType;

@property (nonatomic, assign) BOOL hasBgMusic;
@property (nonatomic, assign) BOOL isBgMusicLoop;
@property (nonatomic, strong) NSString *imagePath;

// CG UI
@property (nonatomic, assign) CGRect spriteRect;
- (instancetype)initDynimicWithDict:(NSDictionary*)dict;
- (instancetype)initStaticWithDict:(NSDictionary*)dict
                              Size:(CGSize)size;
- (instancetype)initWithName:(NSString*)spriteName;

- (NSDictionary*)getDictFromSprite;
- (void)setAnchorTypeWithFaceCode:(NSString *)faceCode;
+ (NSString*)getFaceCodeFromAnchorType:(SpriteAnchorType)anchorType;
@end
