//
//  ContainerImageView.h
//  TemplateConfigMaker
//
//  Created by guohao on 26/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FaceView.h"
@class LEOSprite;
@interface ContainerImageView : NSImageView
@property (nonatomic,strong)NSMutableArray *spriteArray;
@property (nonatomic) BOOL isMultyPeople;
@property (nonatomic,strong) FaceView* faceView;
- (void)addSprite:(LEOSprite*)sprite;
- (void)updateSprite:(LEOSprite*)sprite withFaceType:(faceType)fType;
- (void)removeSprite:(LEOSprite*)sprite;
+ (CGFloat)getFaceLenth;
- (void)selectSprite:(LEOSprite*)sprite;
- (void)setAnchorPointWithType:(SpriteAnchorType)anchorType FaceType:(faceType)fType;
- (void)setFaceHidden:(BOOL)hidden;
- (void)setResizeBlock:(void(^)(CGRect frame,LEOSprite *sprite))block;
- (void)setSpriteSelectedBlock:(void(^)(LEOSprite* sprite))block;
@end
