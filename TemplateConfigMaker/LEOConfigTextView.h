//
//  LEOConfigTextView.h
//  TemplateConfigMaker
//
//  Created by guohao on 1/3/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LEOConfigTextView : NSTextView
- (void)setDragFileBlock:(void(^)(NSArray* array))block;
@end
