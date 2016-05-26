//
//  CornerImageView.m
//  TemplateConfigMaker
//
//  Created by guohao on 23/5/2016.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "CornerImageView.h"

@interface CornerImageView (){
    cornerType cornType;
}
@property (nonatomic,copy) void (^onEnterBlock)();
@property (nonatomic,copy) void (^onExitBlock)();
@end

@implementation CornerImageView

- (instancetype)initWithFrame:(NSRect)frameRect
                   cornerType:(cornerType)cType{
    self = [super initWithFrame: frameRect];
    cornType = cType;
   
    NSString* path = [[NSBundle mainBundle] pathForResource:@"dot" ofType:@"png"];
    self.image = [[NSImage alloc] initWithContentsOfFile:path];
    
    return self;
}

- (void)viewDidMoveToWindow {
    [self addTrackingRect:[self bounds] owner:self userData:nil assumeInside:NO];
}




- (void)mouseEntered:(NSEvent *)theEvent
{
    NSString* resName ;
    if (cornType == cornerTypeLeftTop ||
        cornType == cornerTypeRightBottom) {
        resName = @"ltrb@2x";
    }else{
        resName = @"lbrt@2x";
    }
    NSString* path = [[NSBundle mainBundle] pathForResource:resName ofType:@"png"];
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
    NSString* resName ;
    if (cornType == cornerTypeLeftTop ||
        cornType == cornerTypeRightBottom) {
        resName = @"ltrb@2x";
    }else{
        resName = @"lbrt@2x";
    }
    NSString* path = [[NSBundle mainBundle] pathForResource:resName ofType:@"png"];
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
