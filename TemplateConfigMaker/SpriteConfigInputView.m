//
//  SpriteConfigInputView.m
//  TemplateConfigMaker
//
//  Created by guohao on 20/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "SpriteConfigInputView.h"
#import "LEOSprite.h"
#import <AppKit/NSTextField.h>
@interface SpriteConfigInputView ()<NSTextFieldDelegate>
@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSPopUpButton *spriteType;
@property (weak) IBOutlet NSTextField *pos_x;
@property (weak) IBOutlet NSTextField *pos_y;
@property (weak) IBOutlet NSTextField *width;
@property (weak) IBOutlet NSTextField *height;
@property (weak) IBOutlet NSTextField *animationCount;
@property (weak) IBOutlet NSButton *isAnimationLoop;
@property (weak) IBOutlet NSTextField *order;
@property (weak) IBOutlet NSPopUpButton *anchorType;
@property (weak) IBOutlet NSPopUpButton *anchorSubType;
@property (weak) IBOutlet NSButton *hasBgMusic;
@property (weak) IBOutlet NSButton *isBgMusicLoop;
@property (weak) IBOutlet NSStepper *orderPlus;


@property (strong) NSArray* spriteTypeArray;
@property (strong) NSArray* anchorTypeArray;
@property (strong) NSDictionary* anchorTypeDict;
@property (copy,nonatomic) void (^RefreshBlock) (LEOSprite* sprite);
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
        self.animationCount.delegate = self;
        self.order.delegate = self;
        
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

- (void)setSprite:(LEOSprite *)sprite{
    _sprite = sprite;
    self.nameTextField.stringValue = sprite.spriteName;
    [self.spriteType selectItemAtIndex:sprite.spriteType];
    self.pos_x.stringValue = [NSString stringWithFormat:@"%.2f",sprite.pos_x];
    self.pos_y.stringValue = [NSString stringWithFormat:@"%.2f",sprite.pos_y];
    self.width.stringValue = [NSString stringWithFormat:@"%.2f",sprite.width];
    self.height.stringValue = [NSString stringWithFormat:@"%.2f",sprite.height];
    self.animationCount.stringValue = [NSString stringWithFormat:@"%ld",sprite.animationCount];
    self.isAnimationLoop.state = sprite.recycle;
    self.order.stringValue = [NSString stringWithFormat:@"%ld",sprite.order];
    
    self.hasBgMusic.state = sprite.hasBgMusic;
    
    self.isBgMusicLoop.state = sprite.isBgMusicLoop;
    [self.orderPlus setIntegerValue:sprite.order];
}

- (void)setUpData{
    
    self.anchorType.enabled = NO;
    self.anchorSubType.enabled = self.anchorType.enabled;
    
    self.anchorTypeDict = @{@"静态":@[@"静态"],
                            @"👨":@[@"头顶",@"额头",@"脸下",@"脸颊",@"下巴"],
                            @"👂":@[@"双耳",@"左耳",@"右耳"],
                            @"眉毛":@[@"双眉",@"左眉",@"右眉"],
                            @"👀":@[@"双眼",@"左眼",@"右眼"],
                            @"👃":@[@"全鼻",@"鼻梁",@"鼻尖",@"鼻孔"],
                            @"👄":@[@"全嘴",@"上嘴唇",@"下嘴唇",@"左嘴角",@"右嘴角"]};
    
    self.spriteTypeArray = @[@"静态",@"伴随面部"];
    self.anchorTypeArray = @[@"静态",
                             @"👨",
                             @"👂",
                             @"眉毛",
                             @"👀",
                             @"👃",
                             @"👄"];
    
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
}

#pragma mark - action
- (IBAction)onOrderPlus:(NSStepper *)sender {
    NSStepper* ss = sender;
    
    self.order.stringValue = [NSString stringWithFormat:@"%ld",ss.integerValue];
    
    [self checkValue];
}

 
- (IBAction)onSpriteTypeSelect:(NSPopUpButton *)sender {
    NSInteger n = sender.indexOfSelectedItem;
    
    self.anchorType.enabled = (n != 0);
    self.anchorSubType.enabled = self.anchorType.enabled;
    [self checkValue];
}
- (IBAction)onSpriteAnchorSubtype:(NSPopUpButton *)sender {
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

- (void)receiveData{
    self.sprite.spriteName = self.nameTextField.stringValue;
   self.sprite.pos_x = self.pos_x.stringValue.floatValue;
    self.sprite.pos_y = self.pos_y.stringValue.floatValue;
    self.sprite.width = self.width.stringValue.floatValue;
    self.sprite.height = self.height.stringValue.floatValue;
    self.sprite.animationCount = self.animationCount.stringValue.integerValue;
    self.sprite.recycle = self.isAnimationLoop.state;
    self.sprite.order = self.order.stringValue.integerValue;
    self.sprite.anchorType = [self getFaceCode];
    self.sprite.hasBgMusic = self.hasBgMusic.state;
    self.sprite.isBgMusicLoop = self.isBgMusicLoop.state;
    
    
    
    if (self.RefreshBlock) {
        self.RefreshBlock(self.sprite);
    }
}

- (void)setRefreshBlock:(void(^)(LEOSprite* sprite))block{
    _RefreshBlock = block;
}

#pragma mark - TextFeild Delegate
- (void)controlTextDidEndEditing:(NSNotification *)obj{
   [self checkValue];
}


@end
