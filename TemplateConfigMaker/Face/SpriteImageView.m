//
//  SpriteImageView.m
//  TemplateConfigMaker
//
//  Created by guohao on 23/5/2016.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "SpriteImageView.h"
#import "CornerImageView.h"
@interface SpriteImageView (){
    
}
@property (nonatomic,strong) CornerImageView* cimv0;
@property (nonatomic,strong) CornerImageView* cimv1;
@property (nonatomic,strong) CornerImageView* cimv2;
@property (nonatomic,strong) CornerImageView* cimv3;
@property (nonatomic,copy) void (^onDragBlock)(CGRect frame);
@end

@implementation SpriteImageView


- (instancetype)initWithFrame:(NSRect)frameRect{
    self  = [super initWithFrame:frameRect];
    CGFloat l = 40;
    
    CGFloat w = frameRect.size.width;
    CGFloat h = frameRect.size.height;
    
    self.cimv0 = [[CornerImageView alloc] initWithFrame:CGRectMake(-l/2, -l/2, l, l)];
    [self addSubview:self.cimv0];
    self.cimv1 = [[CornerImageView alloc] initWithFrame:CGRectMake(w-l/2, -l/2, l, l)];
    [self addSubview:self.cimv1];
    self.cimv2 = [[CornerImageView alloc] initWithFrame:CGRectMake(w-l/2, h-l/2, l, l)];
    [self addSubview:self.cimv2];
    self.cimv3 = [[CornerImageView alloc] initWithFrame:CGRectMake(-l/2, h-l/2, l, l)];
    [self addSubview:self.cimv3];
    return self;
}

- (void)layout{
    [super layout];
    NSLog(@"layout");
}

//- (void)viewDidMoveToWindow {
//    [self addTrackingRect:[self bounds] owner:self userData:nil assumeInside:NO];
//}



//- (void)mouseEntered:(NSEvent *)theEvent
//{
//    
//    NSCursor *cursor = [NSCursor pointingHandCursor];
//    [cursor set];
//    [self setNeedsDisplay:YES];
//}
//
//- (void)mouseExited:(NSEvent *)theEvent{
//    NSCursor *cursor = [NSCursor arrowCursor];
//    [cursor set];
//    [self setNeedsDisplay:YES];
//}

- (void)mouseDragged:(NSEvent *)event {
   
    
    CGFloat deltax = event.deltaX;
    CGFloat deltay = event.deltaY;
    
    CGRect rect = self.frame;
    self.frame = CGRectMake(rect.origin.x + deltax, rect.origin.y - deltay, rect.size.width, rect.size.height);
    NSLog(@"drag");
    if (self.onDragBlock) {
        self.onDragBlock(self.frame);
    }
}

- (void)setOnDragBlock:(void(^)(CGRect frame))block{
    _onDragBlock = block;
}

//
//-(void)resetCursorRects
//{
//   [self addCursorRect:self.bounds cursor:[NSCursor pointingHandCursor]];
//    
//    
//}

@end
