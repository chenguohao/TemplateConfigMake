//
//  ViewController.h
//  TemplateConfigMaker
//
//  Created by guohao on 18/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ContainerImageView.h"
@interface ViewController : NSViewController
- (faceType)getCurrentFaceType;
- (CGPoint)getPointByAnchorType:(SpriteAnchorType)aType
                       FaceType:(faceType)fType;
@end

