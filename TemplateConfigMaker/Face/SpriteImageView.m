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
@property (nonatomic,copy) void (^onSelectBlock)();
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
    
    self.wantsLayer = YES;
    self.enabled = YES;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [NSColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
    [self setEdit:NO];
    return self;
}

- (void)layout{
    [super layout];
    NSLog(@"layout");
}

- (void)setEdit:(BOOL)isEdit{
    if (isEdit) {
        self.layer.borderColor = [NSColor redColor].CGColor;
    }else{
        self.layer.borderColor = [NSColor clearColor].CGColor;
    }
    
    self.cimv0.hidden = !isEdit;
    self.cimv1.hidden = self.cimv0.hidden;
    self.cimv2.hidden = self.cimv0.hidden;
    self.cimv3.hidden = self.cimv0.hidden;
}

- (void)mouseDown:(NSEvent *)theEvent{
    NSLog(@"selected ");
    if (self.onSelectBlock) {
        self.onSelectBlock();
    }
}

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


- (void)setOnSelectBlock:(void(^)())block{
    _onSelectBlock = block;
}



@end
