//
//  CornerImageView.m
//  TemplateConfigMaker
//
//  Created by guohao on 23/5/2016.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "CornerImageView.h"

@interface CornerImageView ()
@property (nonatomic,copy) void (^onEnterBlock)();
@property (nonatomic,copy) void (^onExitBlock)();
@end

@implementation CornerImageView

- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame: frameRect];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"dot" ofType:@"png"];
    self.image = [[NSImage alloc] initWithContentsOfFile:path];
    
    return self;
}

- (void)viewDidMoveToWindow {
    [self addTrackingRect:[self bounds] owner:self userData:nil assumeInside:NO];
}




- (void)mouseEntered:(NSEvent *)theEvent
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ltrb" ofType:@"tiff"];
    NSImage* image = [[NSImage alloc] initWithContentsOfFile:path];
    NSCursor *cursor = [[NSCursor alloc] initWithImage:image hotSpot:NSZeroPoint];
    [cursor set];
    [self setNeedsDisplay:YES];
    if (self.onEnterBlock) {
        self.onEnterBlock();
    }
}

- (void)mouseExited:(NSEvent *)theEvent{
    NSCursor *cursor = [NSCursor arrowCursor];
    [cursor set];
    [self setNeedsDisplay:YES];
    if (self.onExitBlock) {
        self.onExitBlock();
    }
}


-(void)resetCursorRects
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ltrb" ofType:@"tiff"];
    NSImage* image = [[NSImage alloc] initWithContentsOfFile:path];
    NSCursor *cursor = [[NSCursor alloc] initWithImage:image hotSpot:NSZeroPoint];
    [self addCursorRect:self.bounds cursor:cursor];
    
    
}

- (void)setEnterBlock:(void(^)())block{
    self.onEnterBlock = block;
}

- (void)setExitBlock:(void(^)())block{
    self.onExitBlock = block;
}
@end
