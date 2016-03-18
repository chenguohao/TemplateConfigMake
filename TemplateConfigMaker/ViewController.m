//
//  ViewController.m
//  TemplateConfigMaker
//
//  Created by guohao on 18/2/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "ViewController.h"
#import <AppKit/AppKit.h>
#import "LEOSprite.h"
#import "FaceView.h"
#import "SpriteConfigInputView.h"
#import "ContainerImageView.h"
#import "LEOConfigTextView.h"

#define tempVer @"2"

@interface ViewController()<NSTableViewDataSource,NSTableViewDelegate>
@property (strong) NSString* str1;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSButton *btDelete;
@property (weak) IBOutlet NSButton *bgMusic;
@property (assign) BOOL hasBgMusic;
@property (unsafe_unretained) IBOutlet LEOConfigTextView *textView;
@property (weak) IBOutlet SpriteConfigInputView *configInputView;
@property (weak) LEOSprite* curEditSprite;
@property (strong) NSString* str0;
@property (weak) IBOutlet NSButton *btSave;
@property (weak) IBOutlet NSView *containerView;

@property (weak) IBOutlet ContainerImageView *photoImage;
@property (nonatomic, strong) NSMutableArray* spritesArray;
@property (weak) IBOutlet NSTextField *templateVersion;
@end

NSString* cellID = @"CellID";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.tableView.allowsEmptySelection = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.curEditSprite = nil;
    self.hasBgMusic = NO;
    self.templateVersion.stringValue = tempVer;
    [self.configInputView setRefreshBlock:^(LEOSprite *sprite) {
        self.curEditSprite = sprite;
        self.photoImage.faceView.hidden = sprite.spriteType == SpriteTypeStatic;
        [self.photoImage.faceView setAnchorPointWithType:sprite.anchorType];
        if (self.spritesArray.count) {
            NSInteger selectRow = self.tableView.selectedRow;
            [self.spritesArray replaceObjectAtIndex:self.tableView.selectedRow withObject:self.curEditSprite];
            [self.tableView reloadData];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:selectRow];
            [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
            [self selectRow:selectRow];
        }
        [self.photoImage updateSprite:sprite];
        [self produceSpriteConfig];
    }];
    
    [self.configInputView setBasePointsSwitchBlock:^(BOOL isOpen) {
        self.photoImage.faceView.isShowBasePoints = isOpen;
    }];
    
    [self.textView setDragFileBlock:^(NSArray *array) {
        NSString* str = array.firstObject;
        if ([str hasSuffix:@".config"] != 1) {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"确定"];
            [alert setMessageText:@"只支持.config文件"];
            [alert setAlertStyle:NSWarningAlertStyle];
            [alert beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] firstObject] modalDelegate:self didEndSelector:nil contextInfo:nil];
        }else{
            [self readConfigWithPath:str];
        }
    }];
}

- (void)readConfigWithPath:(NSString*)path{
    
    NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.textView.string = str;
    NSDictionary* dic = [self dictionaryWithJsonString:str];
    if (dic) {
        if ([[dic allKeys] containsObject:@"sprites"]) {
            NSArray* array = dic[@"sprites"];
            NSMutableArray* spritesArray = [NSMutableArray new];
            for (NSDictionary* spriteDic in array) {
                LEOSprite* sprite = [[LEOSprite alloc] initWithDict:spriteDic];
                [spritesArray addObject:sprite];
            }
            self.spritesArray = spritesArray;
            [self.tableView reloadData];
        }
        if ([[dic allKeys] containsObject:@"hasBgMusic"]) {
            self.hasBgMusic = [dic[@"hasBgMusic"] boolValue];
            self.bgMusic.state = self.hasBgMusic;
        }
    }
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(NSArray*)getDicArrayFromSpriteArray:(NSArray*)array{
    NSMutableArray* resultArray = [NSMutableArray new];
    
    for (LEOSprite* sprite in array) {
        NSDictionary* dict = [sprite getDictFromSprite];
        [resultArray addObject:dict];
    }
    
    return resultArray;
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSMutableArray*)spritesArray{
    if (_spritesArray == nil) {
        _spritesArray = [NSMutableArray new];
    }
    return _spritesArray;
}


- (BOOL)isSpriteArrayContainName:(NSString*)name{
    for(LEOSprite * sprite in self.spritesArray){
        if([sprite.spriteName isEqualToString:name])
            return YES;
    }
    return NO;
}

- (NSString*)getNewNameWithName:(NSString*)name{
    NSString* newName =name;
    if ([self isSpriteArrayContainName:newName]) {
        
        int n = 0;
        
        while ([self isSpriteArrayContainName:newName]) {
            newName = [NSString stringWithFormat:@"%@%d",name,++n];
        }
    }
     return newName;
}

#pragma mark - action
- (IBAction)onDeleteCurrentSprite:(NSButton *)sender {
    if (self.curEditSprite) {
        [self.photoImage removeSprite:self.curEditSprite];
        [self.spritesArray removeObject:self.curEditSprite];
        [self.tableView reloadData];
        if (self.spritesArray.count) {
            self.curEditSprite = self.spritesArray[0];
        }else{
            self.curEditSprite = nil;
        }
        
    }
    [self produceSpriteConfig];
}


- (IBAction)onNewSprite:(id)sender{
   
    LEOSprite* sprite = [[LEOSprite alloc] initWithName:[self getNewNameWithName:@"newSprite"]];
    
    [self.spritesArray addObject:sprite];
    if(self.spritesArray.count == 1){
        self.configInputView.sprite = sprite;
    }
    [self.tableView reloadData];
    [self produceSpriteConfig];
}

- (void)setCurEditSprite:(LEOSprite *)curEditSprite{
    _curEditSprite = curEditSprite;
    if (_curEditSprite == nil) {
        self.configInputView.hidden = YES;
        self.btDelete.enabled = NO;
        self.btSave.enabled = NO;
        
    }else{
        self.configInputView.hidden = NO;
        self.btDelete.enabled = YES;
        self.btSave.enabled = YES;
    }
}

- (IBAction)onBgMusic:(id)sender {
    self.hasBgMusic = self.bgMusic.state;
    [self produceSpriteConfig];
}

#pragma mark - delegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.spritesArray.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTableCellView *result = [self.tableView makeViewWithIdentifier:cellID owner:self];
    if(result == nil){
        result = [[NSTableCellView alloc] init];
    }
    LEOSprite *sprite = [self.spritesArray objectAtIndex:row];
    
    result.textField.stringValue = sprite.spriteName;
    return result;
    
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
    NSLog(@"ROW:%ld",row);
    [self selectRow:row];
    return YES;
}

- (void)selectRow:(NSInteger)row{
    LEOSprite *sprite = [self.spritesArray objectAtIndex:row];
    self.configInputView.sprite = sprite;
    self.curEditSprite = sprite;
}

- (IBAction)onSave:(id)sender {
    NSSavePanel* panel = [NSSavePanel savePanel];
    
    // This method displays the panel and returns immediately.
    // The completion handler is called when the user selects an
    // item or cancels the panel.
   
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL*  theDoc = panel.URL;
            theDoc =[theDoc URLByAppendingPathExtension:[NSString stringWithFormat:@"config"]];
            NSString* content = self.textView.string;
            BOOL result = [content writeToURL:theDoc atomically:YES encoding:NSUTF8StringEncoding error:nil];
            if (result) {
                NSAlert *alert = [[NSAlert alloc] init];
                
                [alert addButtonWithTitle:@"确定"];
                
                [alert setMessageText:@"保存完毕"];
                
                [alert setInformativeText:[NSString stringWithFormat:@"保存在%@",theDoc.path]];
                
                [alert setAlertStyle:NSWarningAlertStyle];
                [alert beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] firstObject] modalDelegate:self didEndSelector:nil contextInfo:nil];
            }
        }
        
    }];
    
    
   
}

- (void)onDrag:(NSArray*)files{
    NSString* path = [files firstObject];
    
    if ([path hasSuffix:@".png"] != 1 &&[path hasSuffix:@".jpg"] != 1  ) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"确定"];
        [alert setMessageText:@"只支持png/jpg文件"];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] firstObject] modalDelegate:self didEndSelector:nil contextInfo:nil];
    }else{
        NSString* file = [path lastPathComponent];
        file = [file stringByDeletingPathExtension];
        LEOSprite* sprite = [[LEOSprite alloc] initWithName:[self getNewNameWithName:file]];
        sprite.imagePath = path;
        [self.spritesArray addObject:sprite];
        if (self.spritesArray.count == 1) {
            
            self.configInputView.sprite = sprite;
        }
        [self.photoImage addSprite:sprite];
        [self.tableView reloadData];
        [self produceSpriteConfig];
    }
    
    
   
}

#pragma mark - sprite data
- (void)produceSpriteConfig{
    self.textView.string = [self DataTOjsonString:@{
                                                    @"sprites":[self getDicArrayFromSpriteArray:self.spritesArray],
                                                    @"hasBgMusic":@(self.hasBgMusic),@"tempViersion":self.templateVersion.stringValue}];
}

@end
