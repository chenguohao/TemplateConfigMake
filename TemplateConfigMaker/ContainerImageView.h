//
//  ContainerImageView.h
//  TemplateConfigMaker
//
//  Created by guohao on 26/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class LEOSprite;
@interface ContainerImageView : NSImageView
@property (nonatomic,strong)NSMutableArray *spriteArray;

- (void)addSprite:(LEOSprite*)sprite;
- (void)updateSprite:(LEOSprite*)sprite;
@end
