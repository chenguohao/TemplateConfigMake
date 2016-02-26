//
//  ContainerImageView.m
//  TemplateConfigMaker
//
//  Created by guohao on 26/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "ContainerImageView.h"
#import "LEOSprite.h"
@interface ContainerImageView()
@end

@implementation ContainerImageView

- (NSMutableArray*)spriteArray{
    if (_spriteArray == nil) {
        _spriteArray = [NSMutableArray new];
    }
    return _spriteArray;
}

- (void)addSprite:(LEOSprite*)sprite{
    
    if (sprite.imagePath) {
        [self.spriteArray addObject:sprite];
        if (sprite.spriteType == SpriteTypeStatic) {
            CGFloat l = self.frame.size.width;
            CGFloat x = (sprite.pos_x - sprite.width/2)* l;
            CGFloat y = l- (sprite.pos_y + sprite.height/2)* l;
            CGFloat w = sprite.width * l;
            CGFloat h = sprite.height* l;
            NSImageView* imv = [[NSImageView alloc] initWithFrame:NSMakeRect(x, y, w, h)];
            imv.image = [[NSImage alloc] initWithContentsOfFile:sprite.imagePath];
            imv.imageScaling = NSImageScaleAxesIndependently;
            sprite.imageView = imv;
            [self addSubview:imv];
        }
       
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
        CGFloat x = (sprite.pos_x - sprite.width/2)* l;
        CGFloat y = l- (sprite.pos_y + sprite.height/2)* l;
        CGFloat w = sprite.width * l;
        CGFloat h = sprite.height* l;
        sprite.imageView.frame = NSMakeRect(x, y, w, h);
    }
   
}


@end
