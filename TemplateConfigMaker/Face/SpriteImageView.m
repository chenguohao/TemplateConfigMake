//
//  SpriteImageView.m
//  TemplateConfigMaker
//
//  Created by guohao on 23/5/2016.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "SpriteImageView.h"
#import "CornerImageView.h"


typedef enum {
    dragTypeNone = 0,
    dragTypeCornerLeftTop,
    dragTypeCornerRightTop,
    dragTypeCornerRightBottom,
    dragTypeCornerLeftBottom
}DragType;

@interface SpriteImageView (){
    DragType preDragType;
    DragType currentDragType;
    CGFloat  cornerLen;
}
@property (nonatomic,strong) NSImageView* imageView;
@property (nonatomic,strong) CornerImageView* cimvLT;
@property (nonatomic,strong) CornerImageView* cimvRT;
@property (nonatomic,strong) CornerImageView* cimvRB;
@property (nonatomic,strong) CornerImageView* cimvLB;
@property (nonatomic,copy) void (^onDragBlock)(CGRect frame);
@property (nonatomic,copy) void (^onSelectBlock)();
@end

@implementation SpriteImageView


- (instancetype)initWithFrame:(NSRect)frameRect{
    self  = [super initWithFrame:frameRect];
    cornerLen = 15;
    int l = cornerLen;
    CGFloat w = frameRect.size.width;
    CGFloat h = frameRect.size.height;
    currentDragType = dragTypeNone;
    
    self.imageView = [[NSImageView alloc] initWithFrame:self.bounds];
    self.imageView.imageScaling = NSImageScaleAxesIndependently;
    [self addSubview:self.imageView];
    
    self.cimvLB = [[CornerImageView alloc] initWithFrame:CGRectMake(0, 0, l, l) cornerType:cornerTypeLeftBottom];
    [self addSubview:self.cimvLB];
    [self.cimvLB setEnterBlock:^{
        preDragType = dragTypeCornerLeftBottom;
    }];
    [self.cimvLB setExitBlock:^{
        preDragType = dragTypeNone;
    }];
    
    
    self.cimvRB = [[CornerImageView alloc] initWithFrame:CGRectMake(w-l, 0, l, l) cornerType:cornerTypeRightBottom];
    [self addSubview:self.cimvRB];
    [self.cimvRB setEnterBlock:^{
        preDragType = dragTypeCornerRightBottom;
    }];
    [self.cimvRB setExitBlock:^{
        preDragType = dragTypeNone;
    }];
    
    self.cimvRT = [[CornerImageView alloc] initWithFrame:CGRectMake(w - l, h - l, l, l) cornerType:cornerTypeRightTop];
    [self addSubview:self.cimvRT];
    [self.cimvRT setEnterBlock:^{
        preDragType = dragTypeCornerRightTop;
    }];
    [self.cimvRT setExitBlock:^{
        preDragType = dragTypeNone;
    }];
    
    self.cimvLT = [[CornerImageView alloc] initWithFrame:CGRectMake(0, h, l, l) cornerType:cornerTypeLeftTop];
    [self addSubview:self.cimvLT];
    [self.cimvLT setEnterBlock:^{
        preDragType = dragTypeCornerLeftTop;
    }];
    [self.cimvLT setExitBlock:^{
        preDragType = dragTypeNone;
    }];
    
    self.wantsLayer = YES;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [NSColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
    [self setEdit:NO];
    return self;
}

- (void)layout{
    [super layout];
    
    CGRect frameRect = self.frame;
    CGFloat w = frameRect.size.width;
    CGFloat h = frameRect.size.height;
    int l = cornerLen;
    
    self.imageView.frame = self.bounds;
    self.cimvLB.frame = CGRectMake(0, 0, l, l);
    self.cimvRB.frame = CGRectMake(w-l, 0, l, l);
    self.cimvRT.frame = CGRectMake(w - l, h - l, l, l);
    self.cimvLT.frame = CGRectMake(0, h - l, l, l);
    
    NSLog(@"layout");
}

- (void)setImage:(NSImage *)image{
    _image = image;
    self.imageView.image = image;
    [self.imageView setNeedsDisplay];
}

- (void)setEdit:(BOOL)isEdit{
    if (isEdit) {
        self.layer.borderColor = [NSColor redColor].CGColor;
    }else{
        self.layer.borderColor = [NSColor clearColor].CGColor;
    }
    
    self.cimvLT.hidden = !isEdit;
    self.cimvRT.hidden = self.cimvLT.hidden;
    self.cimvRB.hidden = self.cimvLT.hidden;
    self.cimvLB.hidden = self.cimvLT.hidden;
}

- (void)mouseDown:(NSEvent *)theEvent{
    NSLog(@"selected ");
    currentDragType = preDragType;
    if (self.onSelectBlock) {
        self.onSelectBlock();
    }
}

- (void)mouseUp:(NSEvent *)theEvent{
    currentDragType = dragTypeNone;
    preDragType = dragTypeNone;
}

- (void)mouseDragged:(NSEvent *)event {
    CGFloat deltax = event.deltaX;
    CGFloat deltay = event.deltaY;
    
    NSLog(@"delta x %lf y %lf",deltax,deltay);
    CGRect rect = self.frame;
    
    if (currentDragType == dragTypeNone ) {
        self.frame = CGRectMake(rect.origin.x + deltax, rect.origin.y - deltay, rect.size.width, rect.size.height);
        NSLog(@"drag");
        if (self.onDragBlock) {
            self.onDragBlock(self.frame);
        }
    }else{
        CGFloat w;
        CGFloat h;
        CGFloat x = rect.origin.x;
        CGFloat y = rect.origin.y;
        
        switch (currentDragType) {
            case dragTypeCornerLeftTop:
            {
                w = rect.size.width - deltax;
                h = rect.size.height - deltay;
                rect = CGRectMake(x + deltax, y, w, h);
            }
                break;
            case dragTypeCornerRightTop:
            {
                w = rect.size.width + deltax;
                h = rect.size.height - deltay;
                rect = CGRectMake(x, y , w, h);
            }
                break;
            case dragTypeCornerRightBottom:
            {
                w = rect.size.width + deltax;
                h = rect.size.height + deltay;
                rect = CGRectMake(x, y - deltay, w, h);
            }
                break;
            case dragTypeCornerLeftBottom:
            {
                w = rect.size.width - deltax;
                h = rect.size.height + deltay;
                rect = CGRectMake(x + deltax, y - deltay, w, h);
            }
                break;
                
            default:
                break;
        }
        self.frame = rect;
        if (self.onDragBlock) {
            self.onDragBlock(self.frame);
        }
    }
    
   
}

- (void)setOnDragBlock:(void(^)(CGRect frame))block{
    _onDragBlock = block;
}


- (void)setOnSelectBlock:(void(^)())block{
    _onSelectBlock = block;
}



@end
