//
//  ContainerImageView.m
//  TemplateConfigMaker
//
//  Created by guohao on 26/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "ContainerImageView.h"
#import "LEOSprite.h"
#import "FaceView.h"
@interface ContainerImageView()
@end

@implementation ContainerImageView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    CGFloat r = self.frame.size.width/500;
    NSRect rect = NSRectFromCGRect(CGRectMake(154*r, 155*r, 217*r, 217*r));
    self.faceView = [[FaceView alloc] initWithFrame:rect];
    
    self.faceView .layer.masksToBounds   = YES;
    
    self.faceView.hidden = YES;
    
    [self addSubview:self.faceView];
    return self;
}

- (NSMutableArray*)spriteArray{
    if (_spriteArray == nil) {
        _spriteArray = [NSMutableArray new];
    }
    return _spriteArray;
}

- (void)addSprite:(LEOSprite*)sprite{
    CGFloat l = self.frame.size.width;
    if (sprite.imagePath) {
        [self.spriteArray addObject:sprite];
        CGFloat x;
        CGFloat y;
        if (sprite.spriteType == SpriteTypeStatic) {
            x = (sprite.pos_x - sprite.width*sprite.anchor_x)* l;
            y = l- (sprite.pos_y + sprite.height*sprite.anchor_y)* l;
        }else{
            
            NSPoint point = [[FaceView new] getPointWithAnchorType:sprite.anchorType];
            
            x = (point.x - sprite.width*sprite.anchor_x)* l;
            y = l- (point.y + sprite.height*sprite.anchor_y)* l;
        }
        
        CGFloat w = sprite.width * l;
        CGFloat h = sprite.height* l;
        NSImageView* imv = [[NSImageView alloc] initWithFrame:NSMakeRect(x, y, w, h)];
        imv.image = [[NSImage alloc] initWithContentsOfFile:sprite.imagePath];
        imv.imageScaling = NSImageScaleAxesIndependently;
        sprite.imageView = imv;
        [self addSubview:imv];
       
    }
}

- (void)updateSprite:(LEOSprite*)sprite{
    
    NSInteger i = -1;
    for (LEOSprite* subsprite in self.spriteArray) {
        if (subsprite == sprite) {
            i = [self.spriteArray indexOfObject:subsprite];
            break;
        }
    }
    
    if (i != -1) {
        [self.spriteArray replaceObjectAtIndex:i withObject:sprite];
        CGFloat l = self.frame.size.width;
        CGFloat x;
        CGFloat y;
        CGFloat w;
        CGFloat h;
        if (sprite.spriteType == SpriteTypeStatic) {
            x = (sprite.pos_x - sprite.width/2)* l;
            y = l- (sprite.pos_y + sprite.height/2)* l;
            w = sprite.width * l;
            h = sprite.height* l;
        }else{
            
            NSPoint point = [self.faceView getPointWithAnchorType:sprite.anchorType];
            l = self.faceView.frame.size.width;
            w = sprite.width * l;
            h = sprite.height* l;
            x = point.x - w*sprite.anchor_x+self.faceView.frame.origin.x;
            y =  point.y-h*(1-sprite.anchor_y)+self.faceView.frame.origin.y;
          
        }
       
        sprite.imageView.frame = NSMakeRect(x, y, w, h);
    }
   
}

- (void)removeSprite:(LEOSprite*)sprite{
    NSInteger i = -1;
    for (LEOSprite* subsprite in self.spriteArray) {
        if (subsprite == sprite) {
            i = [self.spriteArray indexOfObject:subsprite];
            break;
        }
    }
    
    if (i != -1) {
        LEOSprite* removeSprite = self.spriteArray[i];
        NSImageView* imv = removeSprite.imageView;
        [imv removeFromSuperview];
        [self.spriteArray removeObjectAtIndex:i];
    }
}

@end
