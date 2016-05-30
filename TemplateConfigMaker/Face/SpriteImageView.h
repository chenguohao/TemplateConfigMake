//
//  SpriteImageView.h
//  TemplateConfigMaker
//
//  Created by guohao on 23/5/2016.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpriteImageView : NSView
@property (nonatomic,strong) NSImage* image;
@property (nonatomic,assign) NSInteger imageTag;
- (void)setEdit:(BOOL)isEdit;
- (void)setOnDragBlock:(void(^)(CGRect frame))block;
- (void)setOnSelectBlock:(void(^)())block;
@end
