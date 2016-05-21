//
//  FaceView.h
//  TemplateConfigMaker
//
//  Created by guohao on 25/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LEOSprite.h"


typedef enum {
    faceTypeSingle = 0,
    faceTypeMulty0,
    faceTypeMulty1
}faceType;

@interface FaceView : NSView
@property (nonatomic,assign)BOOL isShowBasePoints;
- (instancetype)initWithFrame:(NSRect)frameRect FaceType:(faceType)fType;
- (void)setAnchorPointWithType:(SpriteAnchorType)anchorType;
- (NSPoint)getPointWithAnchorType:(SpriteAnchorType)anchorType;

@end
