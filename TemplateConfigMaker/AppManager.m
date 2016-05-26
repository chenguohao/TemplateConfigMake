//
//  AppManager.m
//  TemplateConfigMaker
//
//  Created by guohao on 25/5/2016.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "AppManager.h"


static AppManager* sharedManager;
@implementation AppManager
+ (instancetype)sharedInstance{
    if (sharedManager == nil) {
        sharedManager = [[AppManager alloc] init];
    }
    return sharedManager;
}

- (faceType)getCurrentFaceType{
    return [self.viewController getCurrentFaceType];
}

- (CGPoint)getPointByAnchorType:(SpriteAnchorType)aType
                       FaceType:(faceType)fType{
    return [self.viewController getPointByAnchorType:aType FaceType:fType];
}
@end
