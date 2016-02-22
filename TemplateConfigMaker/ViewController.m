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
#import "SpriteConfigInputView.h"
@interface ViewController()<NSTableViewDataSource,NSTableViewDelegate>
@property (strong) NSString* str1;
@property (weak) IBOutlet NSTableView *tableView;

@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (weak) IBOutlet SpriteConfigInputView *configInputView;

@property (strong) NSString* str0;
@property (nonatomic, strong) NSMutableArray* spritesArray;
@end

NSString* cellID = @"CellID";

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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

- (IBAction)onAction:(id)sender{
   
    LEOSprite* sprite = self.configInputView.sprite;
    [self.spritesArray addObject:sprite];
    [self.tableView reloadData];
   
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
@end
