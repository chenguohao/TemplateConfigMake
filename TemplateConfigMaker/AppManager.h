//
//  AppManager.h
//  TemplateConfigMaker
//
//  Created by guohao on 25/5/2016.
//  Copyright © 2016 guohao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContainerImageView.h"
#import "ViewController.h"
@interface AppManager : NSObject
@property (nonatomic,strong) ViewController* viewController;
+ (instancetype)sharedInstance;
- (faceType)getCurrentFaceType;
- (CGPoint)getPointByAnchorType:(SpriteAnchorType)aType
                       FaceType:(faceType)fType;
@end
