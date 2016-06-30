//
//  LEOSpriteObject.h
//  biubiu
//
//  Created by Ternence on 16/1/29.
//  Copyright © 2016年 LEO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "SpriteImageView.h"


typedef NS_ENUM(NSUInteger, SpriteType) {
    SpriteTypeStatic = 0,//静态
    SpriteTypeDynamic,//动态
    SpriteTypeCondition,//条件触发
};

typedef NS_ENUM (NSUInteger, DetectType){
    SpriteDetectTypeTrigger = 0,
    SpriteDetectTypeStatus  = 1
};

typedef NS_ENUM(NSUInteger, SpriteTriggerType) {
    SpriteTrigerTypeNone    = 0,
    SpriteTrigerTypeZhayan   = 1,   //眨眼
    SpriteTrigerTypeTiaomei  = 2,  //挑眉
    SpriteTrigerTypeZhangzui = 4, //张嘴
    SpriteTrigerTypeBizui    = 8,    //闭嘴
    SpriteTrigerTypeYaotou   = 16,   //摇头
    SpriteTrigerTypeBaitou   = 32,   //摇头
    SpriteTrigerTypeDiantou  = 64  //点头
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
    
    SpriteAnchorTypeLeftCheek = 28,//左脸颊
    SpriteAnchorTypeRightCheek = 29,//右脸颊
};

typedef enum {
  attachType2DFlat = 0, // 平面挂载
  attachType3DCover = 1,    // 面部贴合
}AttachType;

typedef enum {
    rotateTypeNone = 0    ,//不旋转
    rotateTypeX    = 4    ,//绕X轴旋转
    rotateTypeY    = 2    ,//绕Y轴旋转
    rotateTypeZ    = 1   //绕Z轴旋转
}RotateType;

@interface LEOSprite : NSObject
@property (nonatomic, strong) SpriteImageView* imageView;
@property (nonatomic, assign) SpriteType spriteType;
@property (nonatomic, assign) NSInteger order;

@property (nonatomic, assign) BOOL recycle;
@property (nonatomic, strong) NSString *spriteName;
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


@property (nonatomic, assign) RotateType rotateType;
@property (nonatomic, assign) SpriteAnchorType anchorType;



@property (nonatomic, assign) BOOL hasBgMusic;
@property (nonatomic, assign) BOOL isBgMusicLoop;
@property (nonatomic, strong) NSString *imagePath;

// CG UI
@property (nonatomic, assign) CGRect spriteRect;

// 新增属性 v2
@property (nonatomic,assign) NSInteger loopCount;
@property (nonatomic,assign) NSInteger loopIndex;
@property (nonatomic,assign) DetectType detectType;
@property (nonatomic, assign) SpriteTriggerType triggerOnType;
@property (nonatomic, assign) SpriteTriggerType triggerOffType;

// 新增属性 v3
@property (nonatomic,assign) NSInteger faceIndex;

// 新增属性 v5
@property (nonatomic, assign) CGFloat startTime;

@property (nonatomic, assign) AttachType attachType;

- (instancetype)initWithName:(NSString*)spriteName;
- (instancetype)initWithDict:(NSDictionary*)dict;
- (NSDictionary*)getDictFromSprite;
- (void)setAnchorTypeWithFaceCode:(NSString *)faceCode;
+ (NSString*)getFaceCodeFromAnchorType:(SpriteAnchorType)anchorType;
@end
