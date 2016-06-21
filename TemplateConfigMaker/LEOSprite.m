//
//  LEOSpriteObject.m
//  biubiu
//
//  Created by Ternence on 16/1/29.
//  Copyright © 2016年 LEO. All rights reserved.
//

#import "LEOSprite.h"
#import <AppKit/AppKit.h>
@implementation LEOSprite

    


- (instancetype)initWithName:(NSString*)spriteName{
    self = [super init];
    self.spriteName = spriteName;
    self.spriteType = SpriteTypeStatic;
    self.pos_x = 0.5;
    self.pos_y = 0.5;
    self.width = 0.5;
    self.height = 0.5;
    self.anchor_x = 0.5;
    self.anchor_y = 0.5;
    self.animationCount = 1;
    self.recycle = YES;
    self.duration = 1;
    self.order = 0;
    self.hasBgMusic = NO;
    self.isBgMusicLoop = NO;
    self.isRotate = NO;
    self.anchorType = [self getEnumFromFaceCode:@"static"];
    self.triggerOffType = 0;
    self.triggerOnType  = 0;
    self.detectType = 0;
    self.loopCount = 1;
    self.loopIndex = 0;
    // v3
    self.faceIndex = 0;
    
    // v5
    self.startTime = 0;
    self.attachType = 0;
    return self;
}


- (instancetype)initWithDict:(NSDictionary*)dict{
    self = [super init];
    
    self.spriteName = dict[@"spriteName"];
    self.spriteType = [dict[@"spriteType"] integerValue];
    self.animationCount = [dict[@"animationCount"] integerValue];
    self.duration = [dict[@"animationDuration"] floatValue];
    self.anchorType = [dict[@"anchorType"] integerValue];
    self.order = [dict[@"order"] integerValue];
    if (self.spriteType == SpriteTypeStatic ||
        (self.spriteType == SpriteTypeCondition && self.anchorType == SpriteAnchorTypeStatic)) {
        self.pos_x = [dict[@"pos_x"] floatValue];
        self.pos_y = [dict[@"pos_y"] floatValue];
        self.anchor_x = 0.5;
        self.anchor_y = 0.5;
    }else{
        self.pos_x = 0;
        self.pos_y = 0;
        self.anchor_x = [dict[@"pos_x"] floatValue];
        self.anchor_y = [dict[@"pos_y"] floatValue];
    }
    
    self.width = [dict[@"width"] floatValue];
    self.height= [dict[@"height"] floatValue];
    self.isBgMusicLoop = [dict[@"isBgMusicLoop"] boolValue];
    self.isRotate = [dict[@"isRotate"] boolValue];
    self.hasBgMusic = [dict[@"hasBgMusic"] boolValue];
    
    self.triggerOffType = [dict[@"triggerOffType"] integerValue];
    self.triggerOnType  = [dict[@"triggerOnType"] integerValue];
    self.detectType = [dict[@"detectType"] integerValue];
    self.loopIndex = [dict[@"loopIndex"] integerValue];
    self.loopCount = [dict[@"loopCount"] integerValue];
    
    // v3
    self.faceIndex = [dict[@"faceIndex"] integerValue];
    
    // v5
    self.startTime = [dict[@"startTime"] floatValue];
    self.attachType = (AttachType)[dict[@"attchType"] integerValue];
    return self;
}

- (SpriteAnchorType)getEnumFromFaceCode:(NSString*)faceCode{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"FaceCode" ofType:@"plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:path][@"FaceCodeStr2EnumValue"];
    NSInteger number = [dict[faceCode] integerValue];
    
    return (SpriteAnchorType)number;
}

- (void)setAnchorTypeWithFaceCode:(NSString *)faceCode{
    _anchorType = [self getEnumFromFaceCode:faceCode];
}

+ (NSString*)getFaceCodeFromAnchorType:(SpriteAnchorType)anchorType{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"FaceCode" ofType:@"plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:path][@"FaceCodeStr2EnumValue"];
    
    for (NSString* key in dict.allKeys) {
        if ([dict[key] integerValue] == anchorType) {
            return key;
        }
    }
    
    return nil;
}

- (NSString*)getStringFromFloat:(CGFloat)floatnumber{
    return [NSString stringWithFormat:@"%.2f",floatnumber];
}

- (NSString*)getStringFrom3Float:(CGFloat)floatnumber{
    return [NSString stringWithFormat:@"%.3f",floatnumber];
}

- (NSDictionary*)getDictFromSprite{
    NSMutableDictionary* mdic = [NSMutableDictionary new];
    [mdic setObject:self.spriteName forKey:@"spriteName"];
    [mdic setObject:[@(self.spriteType) stringValue] forKey:@"spriteType"];
    if (self.spriteType == SpriteTypeStatic) {
        [mdic setObject:[self getStringFromFloat:self.pos_x] forKey:@"pos_x"];
        [mdic setObject:[self getStringFromFloat:self.pos_y] forKey:@"pos_y"];
    }else if (self.spriteType == SpriteTypeDynamic){
        
        [mdic setObject:[self getStringFromFloat:self.anchor_x] forKey:@"pos_x"];
        [mdic setObject:[self getStringFromFloat:self.anchor_y] forKey:@"pos_y"];
    }else if (self.spriteType == SpriteTypeCondition){
        if (self.anchorType == SpriteAnchorTypeStatic) {
            [mdic setObject:[self getStringFromFloat:self.pos_x] forKey:@"pos_x"];
            [mdic setObject:[self getStringFromFloat:self.pos_y] forKey:@"pos_y"];
        }else{
            [mdic setObject:[self getStringFromFloat:self.anchor_x] forKey:@"pos_x"];
            [mdic setObject:[self getStringFromFloat:self.anchor_y] forKey:@"pos_y"];
        }
    }
   
    [mdic setObject:[self getStringFromFloat:self.width] forKey:@"width"];
    [mdic setObject:[self getStringFromFloat:self.height] forKey:@"height"];
    [mdic setObject:[@(self.animationCount) stringValue] forKey:@"animationCount"];
    [mdic setObject:[self getStringFrom3Float:self.duration] forKey:@"animationDuration"];
    [mdic setObject:[@(self.order) stringValue] forKey:@"order"];
    [mdic setObject:[@(self.anchorType) stringValue] forKey:@"anchorType"];
    [mdic setObject:@(self.hasBgMusic)forKey:@"hasBgMusic"];
    [mdic setObject:@(self.isBgMusicLoop) forKey:@"isBgMusicLoop"];
    [mdic setObject:@(self.isRotate) forKey:@"isRotate"];
    
    [mdic setObject:[@(self.detectType) stringValue] forKey:@"detectType"];
    [mdic setObject:[@(self.triggerOnType) stringValue] forKey:@"triggerOnType"];
    [mdic setObject:[@(self.triggerOffType) stringValue] forKey:@"triggerOffType"];
    [mdic setObject:[@(self.loopCount) stringValue] forKey:@"loopCount"];
    [mdic setObject:[@(self.loopIndex) stringValue] forKey:@"loopIndex"];
    // v3
    [mdic setObject:[@(self.faceIndex) stringValue] forKey:@"faceIndex"];
    
    // v5
    [mdic setObject:[@(self.startTime) stringValue] forKey:@"startTime"];
    [mdic setObject:[@(self.attachType) stringValue] forKey:@"attachType"];
    return mdic;
}

@end
