//
//  SpriteConfigInputView.h
//  TemplateConfigMaker
//
//  Created by guohao on 20/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class LEOSprite;
@interface SpriteConfigInputView : NSView
@property (strong) IBOutlet NSView *view;
@property (strong,nonatomic) LEOSprite* sprite;
@end
