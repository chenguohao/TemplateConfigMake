//
//  LEOSpriteObject.m
//  biubiu
//
//  Created by Ternence on 16/1/29.
//  Copyright © 2016年 LEO. All rights reserved.
//

#import "LEOSprite.h"

@implementation LEOSprite
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//- (CGRect)spriteRect{
//    return CGRectMake(self.pos_x, self.pos_y, self.width, self.height);
//}


#pragma mark - animation

- (void)setAnimationCount:(NSInteger)animationCount{
    if (animationCount > _animationFrame) {
        if (_recycle) {
            _animationCount = 0;
        }
    } else {
        _animationCount = animationCount;
    }
    
}

- (NSImage *)frameImage {
    return nil;
}

- (void)setDuration:(CGFloat)duration{
    _duration = duration;

}

- (void)setRecycle:(BOOL)recycle{
    _recycle = recycle;

}

- (instancetype)initDynimicWithDict:(NSDictionary*)dict{
    self = [super init];
    
    self.spriteName = dict[@"spriteName"];
    self.spriteType = SpriteTypeDynamic;
    self.order = [dict[@"order"] integerValue];
    
    self.animationFrame = [dict[@"animationCount"] integerValue];
    self.recycle = [dict[@"isloop"] boolValue];
    self.duration = [dict[@"animationDuration"] integerValue];
    
    self.anchor_x = [dict[@"pos_x"] floatValue];
    self.anchor_y = [dict[@"pos_y"] floatValue];
    self.width = [dict[@"width"] floatValue];
    self.height = [dict[@"height"] floatValue];
    self.anchorType = dict[@"anchorType"];
    
    self.hasBgMusic = [dict[@"hasBgMusic"] boolValue];
    self.isBgMusicLoop = [dict[@"isBgMusicLoop"] boolValue];
    
    return self;
}
    

    
    
- (instancetype)initStaticWithDict:(NSDictionary*)dict
                              Size:(CGSize)size{
    self = [super init];
    
    self.spriteName = dict[@"spriteName"];
    self.spriteType = SpriteTypeStatic;
    
    self.animationFrame = [dict[@"animationCount"] integerValue];
    self.recycle = [dict[@"isloop"] boolValue];
    self.duration = [dict[@"animationDuration"] integerValue];
    self.order = [dict[@"order"] integerValue];
    
    self.pos_x = [dict[@"pos_x"] floatValue];
    self.pos_y = [dict[@"pos_y"] floatValue];
    self.width = [dict[@"width"] floatValue]*size.width;
    self.height = [dict[@"height"] floatValue]*size.height;
    
    self.spriteRect = CGRectMake(self.pos_x * size.width - self.width * 0.5, self.pos_y * size.height - self.height * 0.5, self.width, self.height);
    
    return self;
}

- (instancetype)initWithName:(NSString*)spriteName{
    self = [super init];
    self.spriteName = spriteName;
    self.spriteType = SpriteTypeStatic;
    self.pos_x = 0.5;
    self.pos_y = 0.5;
    self.width = 0.5;
    self.height = 0.5;
    self.animationCount = 1;
    self.recycle = YES;
    self.duration = 1;
    self.order = 0;
    self.hasBgMusic = NO;
    self.isBgMusicLoop = NO;
    self.anchorType = @"static";
    return self;
}

- (void)setAnchorType:(NSString *)anchorType{
    _anchorType = anchorType;
}

- (NSString*)getStringFromFloat:(CGFloat)floatnumber{
    return [NSString stringWithFormat:@"%.2f",floatnumber];
}



- (NSDictionary*)getDictFromSprite{
    NSMutableDictionary* mdic = [NSMutableDictionary new];
    [mdic setObject:self.spriteName forKey:@"spriteName"];
    [mdic setObject:[self getStringFromFloat:self.pos_x] forKey:@"pos_x"];
    [mdic setObject:[self getStringFromFloat:self.pos_y] forKey:@"pos_y"];
    [mdic setObject:[self getStringFromFloat:self.width] forKey:@"width"];
    [mdic setObject:[self getStringFromFloat:self.height] forKey:@"height"];
    [mdic setObject:[@(self.animationCount) stringValue] forKey:@"animationCount"];
    [mdic setObject:[@(self.recycle) stringValue] forKey:@"isloop"];
    [mdic setObject:[@(self.duration) stringValue] forKey:@"animationDuration"];
    [mdic setObject:[@(self.order) stringValue] forKey:@"order"];
    [mdic setObject:self.anchorType forKey:@"anchorType"];
    [mdic setObject:[@(self.hasBgMusic) stringValue] forKey:@"hasBgMusic"];
    [mdic setObject:[@(self.isBgMusicLoop) stringValue] forKey:@"isBgMusicLoop"];
    return mdic;
}

@end
