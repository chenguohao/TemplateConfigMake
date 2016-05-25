//
//  SpriteImageView.h
//  TemplateConfigMaker
//
//  Created by guohao on 23/5/2016.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpriteImageView : NSImageView
- (void)setOnDragBlock:(void(^)(CGRect frame))block;
@end
