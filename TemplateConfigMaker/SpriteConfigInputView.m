//
//  SpriteConfigInputView.m
//  TemplateConfigMaker
//
//  Created by guohao on 20/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "SpriteConfigInputView.h"
#import "LEOSprite.h"
@interface SpriteConfigInputView ()
@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSPopUpButton *spriteType;
@property (weak) IBOutlet NSTextField *pos_x;
@property (weak) IBOutlet NSTextField *pos_y;
@property (weak) IBOutlet NSTextField *width;
@property (weak) IBOutlet NSTextField *height;
@property (weak) IBOutlet NSTextField *animationCount;
@property (weak) IBOutlet NSButton *isAnimationLoopYes;
@property (weak) IBOutlet NSButton *isAnimationLoopNo;
@property (weak) IBOutlet NSTextField *order;
@property (weak) IBOutlet NSPopUpButton *anchorType;
@property (weak) IBOutlet NSPopUpButton *anchorSubType;
@property (weak) IBOutlet NSButton *hasBgMusicYes;
@property (weak) IBOutlet NSButton *hasBgMusicNo;
@property (weak) IBOutlet NSButton *isBgMusicLoopYes;
@property (weak) IBOutlet NSButton *isBgMusicLoopNo;


@property (strong) NSArray* spriteTypeArray;
@property (strong) NSArray* anchorTypeArray;
@property (strong) NSDictionary* anchorTypeDict;
@end

@implementation SpriteConfigInputView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SpriteConfigInputView" owner:self topLevelObjects:nil];
        [self addSubview:self.view];
        
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

- (void)setUpData{
    
    self.anchorType.enabled = NO;
    self.anchorSubType.enabled = self.anchorType.enabled;
    
    self.anchorTypeDict = @{@"静态":@[@"静态"],
                            @"👨":@[@"头顶",@"额头",@"脸下",@"脸颊",@"下巴"],
                            @"👂":@[@"双耳",@"左耳",@"右耳"],
                            @"眉毛":@[@"双眉",@"左眉",@"右眉"],
                            @"👀":@[@"双眼",@"左眼",@"右眼"],
                            @"👃":@[@"全鼻",@"鼻梁",@"鼻尖",@"鼻孔"],
                            @"👄":@[@"全嘴",@"上嘴唇",@"下嘴唇",@"嘴角",@"左嘴角",@"右嘴角"]};
    
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

 
- (IBAction)onSpriteTypeSelect:(NSPopUpButton *)sender {
    NSInteger n = sender.indexOfSelectedItem;
    
    self.anchorType.enabled = (n != 0);
    self.anchorSubType.enabled = self.anchorType.enabled;
}

- (IBAction)onSelect:(NSPopUpButton *)sender {
    NSString* title = sender.selectedItem.title;
    if (self.anchorSubType) {
        [self.anchorSubType removeAllItems];
        [self.anchorSubType addItemsWithTitles:self.anchorTypeDict[title]];
    }
}

- (void)checkValue{
}

@end
