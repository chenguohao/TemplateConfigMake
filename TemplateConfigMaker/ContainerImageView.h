//
//  ContainerImageView.h
//  TemplateConfigMaker
//
//  Created by guohao on 26/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class LEOSprite;
@class FaceView;
@interface ContainerImageView : NSImageView
@property (nonatomic,strong)NSMutableArray *spriteArray;

@property (nonatomic,strong) FaceView* faceView;
- (void)addSprite:(LEOSprite*)sprite;
- (void)updateSprite:(LEOSprite*)sprite;
- (void)removeSprite:(LEOSprite*)sprite;
+ (CGFloat)getFaceLenth;
@end
