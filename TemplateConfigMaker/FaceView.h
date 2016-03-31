//
//  FaceView.h
//  TemplateConfigMaker
//
//  Created by guohao on 25/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LEOSprite.h"
@interface FaceView : NSView
@property (nonatomic,assign)BOOL isShowBasePoints;
- (void)setAnchorPointWithType:(SpriteAnchorType)anchorType;
- (NSPoint)getPointWithAnchorType:(SpriteAnchorType)anchorType;

@end
