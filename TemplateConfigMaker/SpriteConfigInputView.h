//
//  SpriteConfigInputView.h
//  TemplateConfigMaker
//
//  Created by guohao on 20/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LEOSprite.h"
@interface SpriteConfigInputView : NSView{
    LEOSprite* _sprite;
}
@property (assign,nonatomic) BOOL isMultiPeople;
@property (strong) IBOutlet NSView *view;
@property (assign,nonatomic) CGFloat sizeRate;
@property (strong, nonatomic) LEOSprite* sprite;
@property (assign,nonatomic) NSInteger curFaceIndex;
+ (CGFloat)getSizeRateWithSprite:(LEOSprite*)sprite;

- (void)setRefreshBlock:(void(^)(LEOSprite* sprite))block;
- (void)setBasePointsSwitchBlock:(void(^)(BOOL isOpen))block;
- (void)setFaceIndexHidden:(BOOL)isHidden;
- (void)setTempVersion:(NSInteger)tempV;
- (void)refreshFaceIndex;

+ (CGFloat)getScreenHeight;
+ (CGFloat)getScreenWidth;
@end
