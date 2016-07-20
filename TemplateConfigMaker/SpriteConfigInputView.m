//
//  SpriteConfigInputView.m
//  TemplateConfigMaker
//
//  Created by guohao on 20/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "SpriteConfigInputView.h"
#import "LEOSprite.h"
#import "AppManager.h"
#import "ContainerImageView.h"
#import <AppKit/NSTextField.h>
@interface SpriteConfigInputView ()<NSTextFieldDelegate>{
    NSInteger tempVersion;
}
@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSPopUpButton *spriteType;
@property (weak) IBOutlet NSTextField *pos_x;
@property (weak) IBOutlet NSTextField *pos_y;
@property (weak) IBOutlet NSTextField *width;
@property (weak) IBOutlet NSTextField *height;
@property (weak) IBOutlet NSTextField *animationCount;
@property (weak) IBOutlet NSTextField *animationDuration;
@property (weak) IBOutlet NSView *anchorView;
@property (weak) IBOutlet NSView *posView;
@property (weak) IBOutlet NSView *triggerView;
@property (weak) IBOutlet NSTextField *widthLabel;
@property (weak) IBOutlet NSTextField *heightLabel;

@property (weak) IBOutlet NSPopUpButton *detectType;

@property (weak) IBOutlet NSTextField *order;
@property (weak) IBOutlet NSPopUpButton *anchorType;
@property (weak) IBOutlet NSPopUpButton *anchorSubType;
@property (weak) IBOutlet NSButton *hasBgMusic;
@property (weak) IBOutlet NSButton *isBgMusicLoop;
@property (weak) IBOutlet NSStepper *orderPlus;
@property (weak) IBOutlet NSTextField *anchorx;
@property (weak) IBOutlet NSTextField *anchory;

@property (weak) IBOutlet NSPopUpButton *rotateType;

@property (weak) IBOutlet NSPopUpButton *trigerTypeOn;
@property (weak) IBOutlet NSPopUpButton *trigerTypeOff;

@property (weak) IBOutlet NSStepper *posXStepper;
@property (weak) IBOutlet NSStepper *posYStepper;

@property (weak) IBOutlet NSStepper *widthStepper;
@property (weak) IBOutlet NSStepper *heightStepper;

@property (weak) IBOutlet NSStepper *anchorPosXStepper;
@property (weak) IBOutlet NSStepper *anchorPosYStepper;


@property (weak) IBOutlet NSPopUpButton *attachStyle;

@property (strong) NSArray* spriteTypeArray;
@property (strong) NSArray* anchorTypeArray;
@property (strong) NSArray* trigerTypeArray;
@property (strong) NSArray* detectTypeArray;
@property (strong) NSArray* attachTypeArray;
@property (strong) NSArray* rotateTypeArray;

@property (weak) IBOutlet NSTextField *loopCount;
@property (weak) IBOutlet NSTextField *loopIndex;
@property (weak) IBOutlet NSPopUpButton *faceIndex;
@property (weak) IBOutlet NSView *faceIndexView;
@property (weak) IBOutlet NSView *anchorTypeSubView;

@property (weak) IBOutlet NSTextField *startTime;

@property (strong) NSArray* trigerEnumIndexArray;

@property (strong) NSDictionary* anchorTypeDict;
@property (copy,nonatomic) void (^RefreshBlock) (LEOSprite* sprite, BOOL needRefreshUI);
@property (copy,nonatomic) void (^switchBasePointsBlock) (BOOL isOpen);


@end


#define ScreenWidth  450
#define ScreenHeight 800

@implementation SpriteConfigInputView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SpriteConfigInputView" owner:self topLevelObjects:nil];
        [self addSubview:self.view];
        self.curFaceIndex = 0;
        self.nameTextField.delegate = self;
        self.pos_x.delegate = self;
        self.pos_y.delegate = self;
        self.width.delegate = self;
        self.height.delegate = self;
        self.anchorx.delegate = self;
        self.anchory.delegate = self;
        self.animationCount.delegate = self;
        self.order.delegate = self;
        self.animationDuration.delegate = self;
        self.loopCount.delegate = self;
        self.loopIndex.delegate = self;
        self.startTime.delegate = self;
        [self setUpData];
    }
    return self;
}

- (LEOSprite*)sprite{
    if (_sprite == nil) {
        _sprite = [LEOSprite new];
    }
    return _sprite;
}

+ (CGFloat)getScreenHeight{
    return ScreenHeight;
}

+ (CGFloat)getScreenWidth{
    return ScreenWidth;
}

+ (CGFloat)getFaceLengthWithFaceType:(faceType)fType{
    return [ContainerImageView getFaceLenthWithFaceType:fType];
}


+ (CGFloat)getSizeRateWithSprite:(LEOSprite*)sprite{
    SpriteType type = sprite.spriteType;
    SpriteAnchorType atype = sprite.anchorType;
    if (type == SpriteTypeStatic) {
        return ScreenWidth;
    }
    
    if (type == SpriteTypeCondition &&
        atype == SpriteAnchorTypeStatic) {
        return ScreenWidth;
    }
    faceType faceType = [[AppManager sharedInstance] getCurrentFaceType];
    return [ContainerImageView getFaceLenthWithFaceType:faceType];
}



- (CGFloat)FaceLength{
    return [SpriteConfigInputView getSizeRateWithSprite:self.sprite];
}

- (void)setSprite:(LEOSprite *)sprite{
    _sprite = sprite;
    
    NSInteger index = sprite.faceIndex;
    if (index == -1) {
        index = 2;
    }else if(index != 0){
        index -= 1;
    }
    [self.faceIndex selectItemAtIndex:index];
    
    self.nameTextField.stringValue = sprite.spriteName;
    [self.spriteType selectItemAtIndex:sprite.spriteType];
    CGFloat w = sprite.width*[SpriteConfigInputView getSizeRateWithSprite:sprite];
    CGFloat h = sprite.height*[SpriteConfigInputView getSizeRateWithSprite:sprite];
    self.pos_x.stringValue = [NSString stringWithFormat:@"%.0f",sprite.pos_x*ScreenWidth-w/2];
    self.posXStepper.integerValue = self.pos_x.stringValue.integerValue;
    if (self.sprite.spriteType == SpriteTypeStatic ||(self.sprite.spriteType == SpriteTypeCondition &&
                                                      self.sprite.anchorType == SpriteAnchorTypeStatic)) {
        CGFloat f = sprite.pos_y*ScreenHeight - h/2;
        if (f > -0.001 && f < 0) {
            f = 0;
        }
        self.pos_y.stringValue = [NSString stringWithFormat:@"%.0f",f];
    }else{
        self.pos_y.stringValue = [NSString stringWithFormat:@"%.0f",sprite.pos_y*[self FaceLength]-h/2];
    }

    
    self.posYStepper.integerValue = self.pos_y.stringValue.integerValue;
    self.anchorx.stringValue = [NSString stringWithFormat:@"%.2f",sprite.anchor_x];
    CGFloat f = sprite.anchor_x*100;
    NSInteger anchorX =  f;
    if (f > 0) {
        if ((f - anchorX)>0.5) {
            anchorX += 1;
        }

    }else{
        if ((f - anchorX)<-0.5) {
            anchorX -= 1;
        }
    }
    
    self.anchorPosXStepper.integerValue = anchorX;
    self.anchory.stringValue = [NSString stringWithFormat:@"%.2f",sprite.anchor_y];
    f = sprite.anchor_y*100;
    NSInteger anchorY =  f;
    if (f > 0) {
        if ((f - anchorY)>0.5) {
            anchorY += 1;
        }
    }else{
        if ((f - anchorY)<-0.5) {
            anchorY -= 1;
        }
    }
    
    self.anchorPosYStepper.integerValue = anchorY;
    self.width.stringValue = [NSString stringWithFormat:@"%.0f",(sprite.width*[SpriteConfigInputView getSizeRateWithSprite:sprite])];
    self.widthStepper.integerValue = self.width.stringValue.integerValue;
    self.height.stringValue = [NSString stringWithFormat:@"%.0f",(sprite.height*[SpriteConfigInputView getSizeRateWithSprite:sprite])];
    self.heightStepper.integerValue = self.height.stringValue.integerValue;
    
    self.animationCount.stringValue = [NSString stringWithFormat:@"%ld",sprite.animationCount+1];
    self.animationDuration.stringValue = [NSString stringWithFormat:@"%.3f",sprite.duration];
    
    self.order.stringValue = [NSString stringWithFormat:@"%ld",sprite.order];
   
    
    self.hasBgMusic.state = sprite.hasBgMusic;
    [self.rotateType selectItemAtIndex:sprite.rotateType];
    self.isBgMusicLoop.state = sprite.isBgMusicLoop;
    [self.orderPlus setIntegerValue:sprite.order];
    
    
    [self.trigerTypeOff selectItemAtIndex:[self setTriggerWithEnum:sprite.triggerOffType]];
    [self.trigerTypeOn  selectItemAtIndex:[self setTriggerWithEnum:sprite.triggerOnType]];
    self.loopCount.stringValue = [NSString stringWithFormat:@"%ld",sprite.loopCount];
    self.loopIndex.stringValue = [NSString stringWithFormat:@"%ld",sprite.loopIndex];
    [self.detectType selectItemAtIndex:sprite.detectType];
    [self setAnchorTypeWithEnum:sprite.anchorType];
    
    //v5
    self.startTime.stringValue = [NSString stringWithFormat:@"%.2f",sprite.startTime];
    [self.attachStyle selectItemAtIndex:sprite.attachType];
    
    [self setLayoutState];
}



- (NSInteger)setTriggerWithEnum:(SpriteTriggerType)type{
    
    for (NSNumber* number in self.trigerEnumIndexArray) {
        if (number.integerValue == type) {
            return [self.trigerEnumIndexArray indexOfObject:number];
        }
    }
    
    return 0;
}

- (void)setAnchorTypeWithEnum:(SpriteAnchorType)anchorType{
    NSString* faceCode = [LEOSprite getFaceCodeFromAnchorType:anchorType];
    if (faceCode) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"FaceCode" ofType:@"plist"];
        NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:path][@"FaceGroup"];
        
        NSArray* groupArray = @[@"static",
                                @"face",
                                @"ear",
                                @"brow",
                                @"eye",
                                @"nose",
                                @"mouse"];
        
        for (int group = 0; group < dict.allKeys.count; group++) {
            NSString* key = groupArray[group];
            NSArray* array = dict[key];
            for (int part = 0; part < [array count]; part++) {
                if ([array[part] isEqualToString:faceCode]) {
                    [self.anchorType selectItemAtIndex:group];
                    if (self.anchorSubType) {
                        [self.anchorSubType removeAllItems];
                        NSString* title = self.anchorTypeArray[group];
                        [self.anchorSubType addItemsWithTitles:self.anchorTypeDict[title]];
                    }
                    [self.anchorSubType selectItemAtIndex:part];
                    break;
                }
            }
        }
    }
}

- (void)setUpData{
    
    [self setLayoutState];
    
    
    
    self.trigerEnumIndexArray = @[@(0),@(4),@(8),@(2),@(32),@(128),@(256)];
    
    self.anchorTypeDict = @{@"静态":@[@"静态"],
                            @"脸":@[@"全脸",@"头顶",@"额头",@"脖子",@"脸颊",@"下巴",@"左脸颊",@"右脸颊"],
                            @"耳朵":@[@"双耳",@"左耳",@"右耳"],
                            @"眉毛":@[@"双眉",@"左眉",@"右眉"],
                            @"眼睛":@[@"双眼",@"左眼",@"右眼",],
                            @"鼻子":@[@"全鼻",@"鼻孔"],
                            @"嘴巴":@[@"全嘴",@"上嘴唇",@"下嘴唇",@"左嘴角",@"右嘴角"]};
    
    self.trigerTypeArray = @[@"N/A",@"张嘴",@"闭嘴",@"挑眉",@"摆头",@"人脸出现",@"人脸消失"];
    self.spriteTypeArray = @[@"静态",@"伴随面部",@"条件触发"];
    self.anchorTypeArray = @[@"静态",
                             @"脸",
                             @"耳朵",
                             @"眉毛",
                             @"眼睛",
                             @"鼻子",
                             @"嘴巴"];
    
    self.detectTypeArray = @[@"变化触发",@"状态触发"];
    self.attachTypeArray = @[@"平面挂载",@"3D贴合"];
    self.rotateTypeArray = @[@"不随脸",@"z轴",@"y轴",@"z+y"];
    
    
    if (self.spriteType) {
        [self.spriteType removeAllItems];
        [self.spriteType addItemsWithTitles:self.spriteTypeArray];
    }
    
    if (self.anchorType) {
        [self.anchorType removeAllItems];
        [self.anchorType addItemsWithTitles:self.anchorTypeArray];
    }
    
    if (self.anchorSubType) {
        [self.anchorSubType removeAllItems];
        [self.anchorSubType addItemsWithTitles:self.anchorTypeDict[@"静态"]];
    }
    
    if (self.trigerTypeOn) {
        [self.trigerTypeOn removeAllItems];
        [self.trigerTypeOn addItemsWithTitles:self.trigerTypeArray];
    }
    
    if (self.trigerTypeOff) {
        [self.trigerTypeOff removeAllItems];
        [self.trigerTypeOff addItemsWithTitles:self.trigerTypeArray];
    }
    
    if (self.detectType) {
        [self.detectType removeAllItems];
        [self.detectType addItemsWithTitles:self.detectTypeArray];
    }
    
    if (self.faceIndex) {
        [self.faceIndex removeAllItems];
        [self.faceIndex addItemsWithTitles:@[@"第一张脸",@"第二张脸",@"二人共用"]];
    }
    
    if (self.attachStyle) {
        [self.attachStyle removeAllItems];
        [self.attachStyle addItemsWithTitles:self.attachTypeArray];
    }
    
    if (self.rotateType) {
        [self.rotateType removeAllItems];
        [self.rotateType addItemsWithTitles:self.rotateTypeArray];
    }
  
}







#pragma mark - action

#pragma mark - stepper
- (IBAction)onOrderPlus:(NSStepper *)sender {
    NSStepper* ss = sender;
    self.order.stringValue = [NSString stringWithFormat:@"%ld",ss.integerValue];
    [self checkValue];
}
- (IBAction)onPosXPlus:(NSStepper *)sender {
    NSStepper* ss = sender;
    self.pos_x.stringValue = [NSString stringWithFormat:@"%ld",ss.integerValue];
    [self checkValue];
}
- (IBAction)onPosYPlus:(id)sender {
    NSStepper* ss = sender;
    self.pos_y.stringValue = [NSString stringWithFormat:@"%ld",ss.integerValue];
    [self checkValue];
}


- (IBAction)onWidthPlus:(NSStepper *)sender {
    NSStepper* ss = sender;
    self.width.stringValue = [NSString stringWithFormat:@"%ld",ss.integerValue];
    [self checkValue];
}

- (IBAction)onHeightPlus:(NSStepper *)sender {
    NSStepper* ss = sender;
    self.height.stringValue = [NSString stringWithFormat:@"%ld",ss.integerValue];
    [self checkValue];
}

- (IBAction)onAnchorXPlus:(NSStepper *)sender {
    NSStepper* ss = sender;
    CGFloat f = (CGFloat)ss.integerValue/100;
  
    
    
    self.anchorx.stringValue = [NSString stringWithFormat:@"%.2f",f];
    NSLog(@"~~~%@",[NSString stringWithFormat:@" stepper %d",ss.integerValue]);
    [self checkValue];
}


- (IBAction)onAnchorYPlus:(NSStepper *)sender {
    NSStepper* ss = sender;
    self.anchory.stringValue = [NSString stringWithFormat:@"%f",(float)ss.integerValue/100];
    [self checkValue];
}
#pragma mark -

- (void)setLayoutState{
    NSInteger n = self.spriteType.indexOfSelectedItem;
    if (n == 0) {
        
        self.posView.hidden = NO;
        self.anchorView.hidden = !self.posView.hidden;
        self.anchorTypeSubView.hidden = self.anchorView.hidden;
        self.triggerView.hidden = YES;
        self.widthLabel.hidden = NO;
        self.heightLabel.hidden = NO;
    }else if(n == 1){
        self.posView.hidden = YES;
        self.anchorView.hidden = !self.posView.hidden;
        self.anchorTypeSubView.hidden = self.anchorView.hidden;
        self.triggerView.hidden = YES;
        self.widthLabel.hidden = YES;
        self.heightLabel.hidden = YES;
    }else if(n == 2){
        if (self.sprite.anchorType == SpriteAnchorTypeStatic) {
            self.posView.hidden = NO;
            self.anchorView.hidden = NO;
            self.anchorTypeSubView.hidden = YES;
            self.triggerView.hidden = NO;
            self.widthLabel.hidden = NO;
            self.heightLabel.hidden = NO;
        }else{
            self.posView.hidden = YES;
            self.anchorView.hidden = !self.posView.hidden;
            self.anchorTypeSubView.hidden = self.anchorView.hidden;
            self.triggerView.hidden = NO;
            self.widthLabel.hidden = YES;
            self.heightLabel.hidden = YES;
        }
        
    }
 
    BOOL isStatic = NO;
    if (self.sprite.spriteType == SpriteTypeStatic || (self.sprite.spriteType == SpriteTypeCondition &&
                                                       self.sprite.anchorType == SpriteAnchorTypeStatic)) {
        isStatic = YES;
    }
    if ( !isStatic &&
        self.isMultiPeople) {
        self.faceIndexView.hidden = NO;
    }else{
        self.faceIndexView.hidden = YES;
        [self.faceIndex selectItemAtIndex:0];
    }
}

- (NSInteger)curFaceIndex{
    if (self.faceIndex.indexOfSelectedItem == 2) {
        return  -1;
    }else{
        return  self.faceIndex.indexOfSelectedItem +1;
    }
}

#pragma mark - picker
- (IBAction)onFaceIndex:(NSPopUpButton *)sender {
    if (sender.indexOfSelectedItem == 2) {
        self.curFaceIndex = -1;
    }else{
        self.curFaceIndex = sender.indexOfSelectedItem +1;
    }
    
    [self checkValue];
}
- (IBAction)onRotateType:(id)sender {
    [self checkValue];
}
- (IBAction)onDetectTypeSelect:(NSPopUpButton *)sender {
     [self checkValue];
}
- (IBAction)onAttachStyleSelected:(id)sender {
     [self checkValue];
}

- (IBAction)onSpriteTypeSelect:(NSPopUpButton *)sender {
    NSInteger n = sender.indexOfSelectedItem;
    if (n == 0) {
        [self.anchorType selectItemAtIndex:0];
        [self.anchorSubType selectItemAtIndex:0];
        [self.faceIndex selectItemAtIndex:0];
        [self.attachStyle selectItemAtIndex:0];
    }
    
    [self checkValue];
    [self setLayoutState];
    
}
- (IBAction)onSpriteAnchorSubtype:(NSPopUpButton *)sender {
    [self checkValue];
    [self setLayoutState];
}

- (IBAction)onTriggerType:(NSPopUpButton *)sender {
    if (sender == self.trigerTypeOff) {
        NSInteger n = self.trigerTypeOff.indexOfSelectedItem;
        if (n == 0) {
             
        }
    }
    [self checkValue];
}


- (IBAction)onSelect:(NSPopUpButton *)sender {
    NSString* title = sender.selectedItem.title;
    if (self.anchorSubType) {
        [self.anchorSubType removeAllItems];
        [self.anchorSubType addItemsWithTitles:self.anchorTypeDict[title]];
    }
    [self checkValue];
    [self setLayoutState];
    
}

- (IBAction)onCheckBox:(id)sender{
    
    if (!self.hasBgMusic.state) {
        self.isBgMusicLoop.state = NO;
    }
    
    if (self.isBgMusicLoop.state) {
        self.hasBgMusic.state = YES;
    }
    
    [self checkValue];
}



- (void)checkValue{
    if ([self.loopCount.stringValue isEqualToString:@"0"]) {
        self.loopCount.stringValue = @"1";
    }
    
    if (self.faceIndexView.hidden) {
        [self.faceIndex selectItemAtIndex:0];
    }
    
    [self receiveDataWithRefresh:NO];
}

- (NSString*)getFaceCode{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"FaceCode" ofType:@"plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:path][@"FaceGroup"];
    
    NSInteger index0 = self.anchorType.indexOfSelectedItem;
    NSInteger index1 = self.anchorSubType.indexOfSelectedItem;
    
    if (index0 == 0) {
        NSLog(@"~ static");
        return @"static";
    }
    
    NSArray* keyArray = @[@"static",@"face",@"ear",@"brow",@"eye",@"nose",@"mouse"];
    NSString* key = [keyArray objectAtIndex:index0%keyArray.count];
    NSString* value = dict[key][index1];
    NSLog(@"~~%@",value);
    return value;
}

- (CGFloat)getAccurateFloatFromStr:(NSString*)originStr{
    CGFloat f = originStr.floatValue;
    
    
    NSString* str = [NSString stringWithFormat:@"%.2f",f];
    if (![str isEqualToString:originStr]) {
        NSString* bigf  = [NSString stringWithFormat:@"%.2f",f+0.01];
        NSString* smalf = [NSString stringWithFormat:@"%.2f",f-0.01];;
        if ([bigf isEqualToString:originStr]) {
            return f+0.01;
        }
        
        if ([smalf isEqualToString:originStr]) {
            return f-0.01;
        }
    }
    
    return f;
}



- (void)receiveDataWithRefresh:(BOOL)needRefreshUI{
    self.sprite.spriteName = self.nameTextField.stringValue;
    self.sprite.spriteType = self.spriteType.indexOfSelectedItem;
    CGFloat w = self.width.stringValue.floatValue/[SpriteConfigInputView getSizeRateWithSprite:self.sprite];
    CGFloat h = self.height.stringValue.floatValue/[SpriteConfigInputView getSizeRateWithSprite:self.sprite];
    self.sprite.width  = w;
    self.sprite.height = h;
    
    self.sprite.pos_x = self.pos_x.stringValue.floatValue/ScreenWidth+w/2;
    
    if (self.sprite.spriteType == SpriteTypeStatic ||(self.sprite.spriteType == SpriteTypeCondition &&
                                                      self.sprite.anchorType == SpriteAnchorTypeStatic)) {
        self.sprite.pos_y = (self.pos_y.stringValue.floatValue + self.height.stringValue.floatValue/2)/ScreenHeight;
    }else{
        self.sprite.pos_y = self.pos_y.stringValue.floatValue/[self FaceLength]+h/2;
    }
    
    
    
    NSInteger n = self.animationCount.stringValue.integerValue;
    self.sprite.animationCount = n-1;
    self.sprite.order = self.order.stringValue.integerValue;
    [self.sprite setAnchorTypeWithFaceCode:[self getFaceCode]];
    self.sprite.hasBgMusic = self.hasBgMusic.state;
    self.sprite.isBgMusicLoop = self.isBgMusicLoop.state;
    self.sprite.rotateType = (RotateType)self.rotateType.indexOfSelectedItem;
    self.sprite.duration = self.animationDuration.stringValue.floatValue;
    
    if(!self.anchorx.hidden){
        CGFloat f = [self getAccurateFloatFromStr:self.anchorx.stringValue];
        self.sprite.anchor_x = f;
    }
    
    if(!self.anchory.hidden){
      self.sprite.anchor_y = self.anchory.stringValue.floatValue;  
    }
    
    self.sprite.triggerOffType = [self.trigerEnumIndexArray[self.trigerTypeOff.indexOfSelectedItem] integerValue];
    self.sprite.triggerOnType  = [self.trigerEnumIndexArray[self.trigerTypeOn.indexOfSelectedItem] integerValue];
    self.sprite.detectType = self.detectType.indexOfSelectedItem;
    self.sprite.loopIndex = self.loopIndex.stringValue.integerValue;
    self.sprite.loopCount = self.loopCount.stringValue.integerValue;
    
    // v3
    NSInteger faceIndex;
    
    
    if(self.faceIndexView.hidden){
        self.sprite.faceIndex = 0;
    }else{
        if (!self.isMultiPeople) {
            if (self.sprite.spriteType == SpriteTypeStatic) {
                faceIndex = 0;
            }else if (self.sprite.spriteType == SpriteTypeDynamic){
                faceIndex = 1;
            }
        }else{
            if (self.sprite.spriteType == SpriteTypeStatic) {
                faceIndex = 0;
            }else if (self.sprite.spriteType == SpriteTypeDynamic){
                NSInteger index = self.faceIndex.indexOfSelectedItem;
                if (index == 2) {
                    faceIndex = -1;
                }else{
                    faceIndex = index + 1;
                }
            }else if (self.sprite.spriteType == SpriteTypeCondition){
                if (self.sprite.anchorType == SpriteAnchorTypeStatic) {
                    faceIndex = 0;
                }else{
                    NSInteger index = self.faceIndex.indexOfSelectedItem;
                    if (index == 2) {
                        faceIndex = -1;
                    }else{
                        faceIndex = index + 1;
                    }
                }
            }
        }
        self.sprite.faceIndex = faceIndex;
    }
    
    
    // v5
    if (self.startTime.hidden ) {
        self.sprite.startTime = 0;
    }else{
        self.sprite.startTime = self.startTime.stringValue.floatValue;
    }
    
    self.sprite.attachType = (AttachType)self.attachStyle.indexOfSelectedItem;
    
    if (self.RefreshBlock) {
        self.RefreshBlock(self.sprite,needRefreshUI);
    }
}
- (IBAction)onSwitchBasePoints:(NSButton *)sender {
    BOOL isOpen = sender.state;
    if (self.switchBasePointsBlock) {
        self.switchBasePointsBlock(isOpen);
    }
}

- (void)setRefreshBlock:(void(^)(LEOSprite* sprite,BOOL needRefreshUI))block{
    _RefreshBlock = block;
}

- (void)setBasePointsSwitchBlock:(void(^)(BOOL isOpen))block{
    _switchBasePointsBlock = block;
}

#pragma mark - TextFeild Delegate
- (void)controlTextDidChange:(NSNotification *)obj{
    id sender = obj.object;
    if (sender == self.width) {
        CGFloat f = self.width.stringValue.floatValue;
        NSImage* img = self.sprite.imageView.image;
        if (img) {
            CGFloat r = img.size.width/img.size.height;
            self.height.stringValue = [NSString stringWithFormat:@"%.0f",(f/r)];
        }
    }
    
    //[self checkValue];
}

- (void)controlTextDidEndEditing:(NSNotification *)obj{
   [self checkValue];
}

- (void)refreshFaceIndex{
    [self setLayoutState];
    if (self.faceIndexView.hidden) {
        [self.faceIndex selectItemAtIndex:0];
    }
}

#pragma mark - multyFace
- (void)changeSpriteWithFrame:(CGRect)frame Sprite:(LEOSprite*)sprite{
    
    NSInteger w = frame.size.width;
    NSInteger h = frame.size.height;
    self.width.stringValue = [NSString stringWithFormat:@"%d",w];
    self.height.stringValue = [NSString stringWithFormat:@"%d",h];
    if (sprite.spriteType == SpriteTypeStatic ||
        (sprite.spriteType == SpriteTypeCondition && sprite.anchorType == SpriteAnchorTypeStatic)){
        self.pos_x.stringValue = [NSString stringWithFormat:@"%ld",(NSInteger)frame.origin.x];
        NSInteger y = ScreenHeight - (NSInteger)frame.origin.y - frame.size.height;
        self.pos_y.stringValue = [NSString stringWithFormat:@"%ld",y];
        [self receiveDataWithRefresh:NO];
    }else{
        SpriteAnchorType atype = sprite.anchorType;
        faceType fType = [[AppManager sharedInstance] getCurrentFaceType];
        
        CGPoint pt = [[AppManager sharedInstance] getPointByAnchorType:atype FaceType:fType];
        
        CGFloat x = (pt.x - frame.origin.x)/frame.size.width;
        CGFloat y =  1 - (pt.y - frame.origin.y)/frame.size.height;
        NSLog(@"anchor_x %lf,anchor_y %lf",x,y);
        
        self.anchorx.stringValue = [NSString stringWithFormat:@"%.3lf",x];
        self.anchory.stringValue = [NSString stringWithFormat:@"%.3lf",y];
        [self receiveDataWithRefresh:NO];
    }

    
    
}



@end
