//
//  CornerImageView.h
//  TemplateConfigMaker
//
//  Created by guohao on 23/5/2016.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
    cornerTypeLeftTop = 0,
    cornerTypeRightTop,
    cornerTypeRightBottom,
    cornerTypeLeftBottom
}cornerType;

@interface CornerImageView : NSImageView
- (void)setEnterBlock:(void(^)())block;
- (void)setExitBlock:(void(^)())block;
@end
