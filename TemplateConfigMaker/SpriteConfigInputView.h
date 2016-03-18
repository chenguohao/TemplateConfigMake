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
@property (strong) IBOutlet NSView *view;
@property (assign,nonatomic) CGFloat sizeRate;
@property (strong, nonatomic) LEOSprite* sprite;
+ (CGFloat)getSizeRateWithType:(SpriteType)type;
- (void)setRefreshBlock:(void(^)(LEOSprite* sprite))block;
- (void)setBasePointsSwitchBlock:(void(^)(BOOL isOpen))block;
@end
