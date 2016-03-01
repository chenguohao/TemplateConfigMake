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
    SpriteAnchorTypeNostril = 10,//鼻孔
    SpriteAnchorTypeMouth = 11,//嘴巴
    SpriteAnchorTypeLeftMouthSide = 12,//左嘴角
    SpriteAnchorTypeRightMouthSide = 13,//右嘴角
    SpriteAnchorTypeCheek = 14,//脸颊
    SpriteAnchorTypeNeck = 15,//脖子
    
    SpriteAnchorTypeEar = 16,//耳朵
    SpriteAnchorTypeEarLeft = 17,//左耳朵
    SpriteAnchorTypeEarRight = 18,//右耳朵
    
    SpriteAnchorTypeTopBody = 19,//上半身
    SpriteAnchorTypeFace = 20, //全脸
    
    
    SpriteAnchorTypeInLeftEyeSide = 21,//内眼角左
    SpriteAnchorTypeInRightEyeSide = 22,//内眼角右
    SpriteAnchorTypeOutLeftEyeSide = 23,//外眼角左
    SpriteAnchorTypeOutRightEyeSide= 24,//外眼角右
    SpriteAnchorTypeUpMouth = 25,//上嘴唇
    SpriteAnchorTypeDownMouth = 26,//下嘴唇
    SpriteAnchorTypeLowerJaw = 27,//下巴
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

- (instancetype)initWithName:(NSString*)spriteName;
- (instancetype)initWithDict:(NSDictionary*)dict;
- (NSDictionary*)getDictFromSprite;
- (void)setAnchorTypeWithFaceCode:(NSString *)faceCode;
+ (NSString*)getFaceCodeFromAnchorType:(SpriteAnchorType)anchorType;
@end
