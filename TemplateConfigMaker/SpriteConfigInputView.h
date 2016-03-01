//
//  SpriteConfigInputView.h
//  TemplateConfigMaker
//
//  Created by guohao on 20/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class LEOSprite;
@interface SpriteConfigInputView : NSView{
    LEOSprite* _sprite;
}
@property (strong) IBOutlet NSView *view;
@property (strong, nonatomic) LEOSprite* sprite;
- (void)setRefreshBlock:(void(^)(LEOSprite* sprite))block;
- (void)setBasePointsSwitchBlock:(void(^)(BOOL isOpen))block;
@end
