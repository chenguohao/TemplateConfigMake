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
@interface ContainerImageView(){
    FaceView* faceView_s0;
    FaceView* faceView_m0;
    FaceView* faceView_m1;
}
@end

#define faceLen 213
#define faceLen_m0 119
#define faceLen_m1 140
@implementation ContainerImageView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    CGFloat r = 1;//self.frame.size.width/450;
    
    NSRect rect = NSRectFromCGRect(CGRectMake(115*r, 285*r, faceLen*r, faceLen*r));
    faceView_s0 = [[FaceView alloc] initWithFrame:rect FaceType:faceTypeSingle];
    faceView_s0.layer.masksToBounds   = YES;
    faceView_s0.hidden = YES;
    [self addSubview:faceView_s0];
    
    rect = NSRectFromCGRect(CGRectMake(54, 246, faceLen_m0, faceLen_m0));
    faceView_m0 = [[FaceView alloc] initWithFrame:rect FaceType:faceTypeMulty0];
    faceView_m0.layer.masksToBounds   = YES;
    faceView_m0.hidden = YES;
    [self addSubview:faceView_m0];
    
    
    rect = NSRectFromCGRect(CGRectMake(246, 295, faceLen_m1, faceLen_m1));
    faceView_m1 = [[FaceView alloc] initWithFrame:rect FaceType:faceTypeMulty1];
    faceView_m1.layer.masksToBounds   = YES;
    [self addSubview:faceView_m1];
    faceView_m1.hidden = YES;
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
            y = l-(sprite.pos_y + sprite.height*sprite.anchor_y)* l;
        }else{
            
            NSPoint point = [[FaceView new] getPointWithAnchorType:sprite.anchorType];
            
            x = (point.x - sprite.width*sprite.anchor_x)* l;
            y = l-(point.y + sprite.height*sprite.anchor_y)* l;
        }
        
        CGFloat w = sprite.width * l;
        CGFloat h = sprite.height* l;
        NSImageView* imv = [[NSImageView alloc] initWithFrame:NSMakeRect(x, y, w, h)];
        imv.image = [[NSImage alloc] initWithContentsOfFile:sprite.imagePath];
        imv.imageScaling = NSImageScaleAxesIndependently;
        sprite.imageView = imv;
        imv.wantsLayer = YES;
        imv.layer.masksToBounds = YES;
        imv.layer.borderColor = [NSColor blueColor].CGColor;
        imv.layer.borderWidth = 1;
        [self addSubview:imv];
       
    }
}

- (void)updateSprite:(LEOSprite*)sprite withFaceType:(faceType)fType{
    
    
    switch (fType) {
        case faceTypeSingle:
            self.faceView = faceView_s0;
            break;
        case faceTypeMulty0:
            self.faceView = faceView_m0;
            break;
        case faceTypeMulty1:
            self.faceView = faceView_m1;
            break;
        default:
            break;
    }

    
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
        CGFloat H = self.frame.size.height;
        CGFloat x;
        CGFloat y;
        CGFloat w;
        CGFloat h;
        if (sprite.spriteType == SpriteTypeStatic ||
            (sprite.spriteType == SpriteTypeCondition && sprite.anchorType == SpriteAnchorTypeStatic)) {
            x = (sprite.pos_x - sprite.width/2)* l;
            y = H -  H *sprite.pos_y -(sprite.height/2)* l;
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
    [self reSortOrder];
}

NSComparisonResult viewcmp( NSView * view1, NSView * view2, void * context )
{
    if (view1.tag > view2.tag) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    
    if (view1.tag < view2.tag) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
}

- (void)reSortOrder{

    NSComparator cmptr = ^(LEOSprite* sprite, LEOSprite* sprite2){
        if (sprite.order > sprite2.order) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if (sprite.order < sprite2.order) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
     [self.spriteArray sortUsingComparator:cmptr];
    
    for (LEOSprite* sprite in self.spriteArray) {
        sprite.imageView.tag = [self.spriteArray indexOfObject:sprite];
    }

    [self sortSubviewsUsingFunction:viewcmp context:nil];
    
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

+ (CGFloat)getFaceLenth{
    return faceLen;
}

- (void)selectSprite:(LEOSprite*)sprite{
    
    
    for (NSView* subv in self.subviews) {
        NSLog(@"subview %@",subv.description);
    }
    
    for (LEOSprite* sp in self.spriteArray) {
        NSLog(@"imageView %@",sp.imageView.description);
        if ([sp.spriteName isEqualToString:sprite.spriteName]) {
          
            NSLog(@"red %@",sprite.spriteName);
            sp.imageView.layer.borderColor = [NSColor redColor].CGColor;
            
        }else{
           NSLog(@"blue %@",sprite.spriteName);
            sp.imageView.layer.borderColor = [NSColor blueColor].CGColor;
        }
    }
}

#pragma mark - set MultyPeople
- (void)setIsMultyPeople:(BOOL)isMultyPeople{
    _isMultyPeople = isMultyPeople;
    
    faceView_s0.hidden = isMultyPeople;
    faceView_m1.hidden = !faceView_s0.hidden;
    faceView_m0.hidden = !faceView_s0.hidden;

    
    NSString* path;
    if (!isMultyPeople) {
        path = [[NSBundle mainBundle] pathForResource:@"longFace" ofType:@"jpg"];
    }else{
        path = [[NSBundle mainBundle] pathForResource:@"dualFace" ofType:@"jpg"];
    }
    self.image = [[NSImage alloc] initWithContentsOfFile:path];
}

- (void)setAnchorPointWithType:(SpriteAnchorType)anchorType FaceType:(faceType)fType{
    FaceView* faceView;
    switch (fType) {
        case faceTypeSingle:
            faceView = faceView_s0;
            break;
        case faceTypeMulty0:
            faceView = faceView_m0;
            break;
        case faceTypeMulty1:
            faceView = faceView_m1;
            break;
        default:
            break;
    }
    
    [faceView setAnchorPointWithType:anchorType];
}

- (void)setFaceHidden:(BOOL)hidden{
    faceView_s0.hidden = _isMultyPeople;
    faceView_m1.hidden = !faceView_s0.hidden;
    faceView_m0.hidden = !faceView_s0.hidden;
}

@end
