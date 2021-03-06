//
//  SpriteConfigInputView.m
//  TemplateConfigMaker
//
//  Created by guohao on 20/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "SpriteConfigInputView.h"
#import "LEOSprite.h"
#import "ContainerImageView.h"
#import <AppKit/NSTextField.h>
@interface SpriteConfigInputView ()<NSTextFieldDelegate>
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

@property (weak) IBOutlet NSPopUpButton *detectType;

@property (weak) IBOutlet NSTextField *order;
@property (weak) IBOutlet NSPopUpButton *anchorType;
@property (weak) IBOutlet NSPopUpButton *anchorSubType;
@property (weak) IBOutlet NSButton *hasBgMusic;
@property (weak) IBOutlet NSButton *isBgMusicLoop;
@property (weak) IBOutlet NSStepper *orderPlus;
@property (weak) IBOutlet NSTextField *anchorx;
@property (weak) IBOutlet NSTextField *anchory;
@property (weak) IBOutlet NSButton *isRotate;

@property (weak) IBOutlet NSPopUpButton *trigerTypeOn;
@property (weak) IBOutlet NSPopUpButton *trigerTypeOff;

@property (weak) IBOutlet NSStepper *posXStepper;
@property (weak) IBOutlet NSStepper *posYStepper;

@property (weak) IBOutlet NSStepper *widthStepper;
@property (weak) IBOutlet NSStepper *heightStepper;

@property (weak) IBOutlet NSStepper *anchorPosXStepper;
@property (weak) IBOutlet NSStepper *anchorPosYStepper;

@property (strong) NSArray* spriteTypeArray;
@property (strong) NSArray* anchorTypeArray;
@property (strong) NSArray* trigerTypeArray;
@property (strong) NSArray* detectTypeArray;

@property (weak) IBOutlet NSTextField *loopCount;
@property (weak) IBOutlet NSTextField *loopIndex;


@property (strong) NSArray* trigerEnumIndexArray;

@property (strong) NSDictionary* anchorTypeDict;
@property (copy,nonatomic) void (^RefreshBlock) (LEOSprite* sprite);
@property (copy,nonatomic) void (^switchBasePointsBlock) (BOOL isOpen);
@end



@implementation SpriteConfigInputView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SpriteConfigInputView" owner:self topLevelObjects:nil];
        [self addSubview:self.view];
        
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


+ (CGFloat)getSizeRateWithType:(SpriteType)type{
    if (type == SpriteTypeStatic) {
        return 480;
    }
    return [ContainerImageView getFaceLenth];
}

- (CGFloat)sizeRate
{
    if (self.sprite.spriteType == SpriteTypeStatic) {
        return 480;
    }
    return [ContainerImageView getFaceLenth];
}

- (void)setSprite:(LEOSprite *)sprite{
    _sprite = sprite;
    self.nameTextField.stringValue = sprite.spriteName;
    [self.spriteType selectItemAtIndex:sprite.spriteType];
    CGFloat w = sprite.width*self.sizeRate;
    CGFloat h = sprite.height*self.sizeRate;
    self.pos_x.stringValue = [NSString stringWithFormat:@"%.0f",sprite.pos_x*self.sizeRate-w/2];
    self.posXStepper.integerValue = self.pos_x.stringValue.integerValue;
    self.pos_y.stringValue = [NSString stringWithFormat:@"%.0f",sprite.pos_y*self.sizeRate-h/2];
    self.posYStepper.integerValue = self.pos_y.stringValue.integerValue;
    self.anchorx.stringValue = [NSString stringWithFormat:@"%.2f",sprite.anchor_x];
    CGFloat f = sprite.anchor_x*100;
    NSInteger anchorX =  f;
    if ((f - anchorX)>0.5) {
        anchorX += 1;
    }
    self.anchorPosXStepper.integerValue = anchorX;
    self.anchory.stringValue = [NSString stringWithFormat:@"%.2f",sprite.anchor_y];
    f = sprite.anchor_y*100;
    NSInteger anchorY =  f;
    if ((f - anchorY)>0.5) {
        anchorY += 1;
    }
    self.anchorPosYStepper.integerValue = anchorY;
    self.width.stringValue = [NSString stringWithFormat:@"%.0f",(sprite.width*self.sizeRate)];
    self.widthStepper.integerValue = self.width.stringValue.integerValue;
    self.height.stringValue = [NSString stringWithFormat:@"%.0f",(sprite.height*self.sizeRate)];
    self.heightStepper.integerValue = self.height.stringValue.integerValue;
    
    self.animationCount.stringValue = [NSString stringWithFormat:@"%ld",sprite.animationCount+1];
    self.animationDuration.stringValue = [NSString stringWithFormat:@"%.2f",sprite.duration];
    
    self.order.stringValue = [NSString stringWithFormat:@"%ld",sprite.order];
   
    
    self.hasBgMusic.state = sprite.hasBgMusic;
    self.isRotate.state = sprite.isRotate;
    self.isBgMusicLoop.state = sprite.isBgMusicLoop;
    [self.orderPlus setIntegerValue:sprite.order];
    
    [self.trigerTypeOff selectItemAtIndex:[self setTriggerWithEnum:sprite.triggerOffType]];
    [self.trigerTypeOn  selectItemAtIndex:[self setTriggerWithEnum:sprite.triggerOnType]];
    self.loopCount.stringValue = [NSString stringWithFormat:@"%ld",sprite.loopCount];
    self.loopIndex.stringValue = [NSString stringWithFormat:@"%ld",sprite.loopIndex];
    [self.detectType selectItemAtIndex:sprite.detectType];
    
    [self setAnchorTypeWithEnum:sprite.anchorType];
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
    
    
    self.trigerEnumIndexArray = @[@(0),@(4),@(8),@(2),@(32)];
    
    self.anchorTypeDict = @{@"静态":@[@"静态"],
                            @"脸":@[@"全脸",@"头顶",@"额头",@"脖子",@"脸颊",@"下巴"],
                            @"耳朵":@[@"双耳",@"左耳",@"右耳"],
                            @"眉毛":@[@"双眉",@"左眉",@"右眉"],
                            @"眼睛":@[@"双眼",@"左眼",@"右眼",],
                            @"鼻子":@[@"全鼻",@"鼻孔"],
                            @"嘴巴":@[@"全嘴",@"上嘴唇",@"下嘴唇",@"左嘴角",@"右嘴角"]};
    self.trigerTypeArray = @[@"N/A",@"张嘴",@"闭嘴",@"挑眉",@"摆头"];
    self.spriteTypeArray = @[@"静态",@"伴随面部",@"条件触发"];
    self.anchorTypeArray = @[@"静态",
                             @"脸",
                             @"耳朵",
                             @"眉毛",
                             @"眼睛",
                             @"鼻子",
                             @"嘴巴"];
    
    self.detectTypeArray = @[@"变化触发",@"状态触发"];
    
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
        self.triggerView.hidden = YES;
    }else if(n == 1){
        self.posView.hidden = YES;
        self.anchorView.hidden = !self.posView.hidden;
        self.triggerView.hidden = YES;
    }else if(n == 2){
        self.posView.hidden = YES;
        self.anchorView.hidden = !self.posView.hidden;
        self.triggerView.hidden = NO;
    }
}

#pragma mark - picker

- (IBAction)onDetectTypeSelect:(NSPopUpButton *)sender {
     [self checkValue];
}

- (IBAction)onSpriteTypeSelect:(NSPopUpButton *)sender {
    NSInteger n = sender.indexOfSelectedItem;
    if (n == 0) {
        [self.anchorType selectItemAtIndex:0];
        [self.anchorSubType selectItemAtIndex:0];
       
    }
    [self setLayoutState];
    [self checkValue];
}
- (IBAction)onSpriteAnchorSubtype:(NSPopUpButton *)sender {
    [self checkValue];
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
    [self receiveData];
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

- (void)receiveData{
    self.sprite.spriteName = self.nameTextField.stringValue;
    self.sprite.spriteType = self.spriteType.indexOfSelectedItem;
    CGFloat w = self.width.stringValue.floatValue/self.sizeRate;
    CGFloat h = self.height.stringValue.floatValue/self.sizeRate;
    self.sprite.width  = w;
    self.sprite.height = h;
    
    self.sprite.pos_x = self.pos_x.stringValue.floatValue/self.sizeRate+w/2;
    self.sprite.pos_y = self.pos_y.stringValue.floatValue/self.sizeRate+h/2;
    
    NSInteger n = self.animationCount.stringValue.integerValue;
    self.sprite.animationCount = n-1;
    self.sprite.order = self.order.stringValue.integerValue;
    [self.sprite setAnchorTypeWithFaceCode:[self getFaceCode]];
    self.sprite.hasBgMusic = self.hasBgMusic.state;
    self.sprite.isBgMusicLoop = self.isBgMusicLoop.state;
    self.sprite.isRotate = self.isRotate.state;
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
    
    if (self.RefreshBlock) {
        self.RefreshBlock(self.sprite);
    }
}
- (IBAction)onSwitchBasePoints:(NSButton *)sender {
    BOOL isOpen = sender.state;
    if (self.switchBasePointsBlock) {
        self.switchBasePointsBlock(isOpen);
    }
}

- (void)setRefreshBlock:(void(^)(LEOSprite* sprite))block{
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
    }else if (sender == self.animationCount){
        CGFloat f = self.animationCount.stringValue.floatValue;
        self.animationDuration.stringValue = [NSString stringWithFormat:@"%.2f",f/8];
    }else if (sender == self.animationDuration){
        CGFloat f = self.animationDuration.stringValue.floatValue;
        self.animationCount.stringValue = [NSString stringWithFormat:@"%.0f",f*8];
    }
    //[self checkValue];
}

- (void)controlTextDidEndEditing:(NSNotification *)obj{
   [self checkValue];
}


@end
