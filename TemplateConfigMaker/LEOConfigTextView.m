//
//  LEOConfigTextView.m
//  TemplateConfigMaker
//
//  Created by guohao on 1/3/16.
//  Copyright © 2016 guohao. All rights reserved.
//

#import "LEOConfigTextView.h"

@interface LEOConfigTextView()
@property (copy,nonatomic) void (^dragBlock)(NSArray* array);
@end

@implementation LEOConfigTextView{
    BOOL highlight;
}

- (void) awakeFromNib {
    [self registerForDraggedTypes:@[NSFilenamesPboardType]];
}

// Stop the NSTableView implementation getting in the way
- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    return [self draggingEntered:sender];
}

#pragma GCC diagnostic ignored "-Wundeclared-selector"
- (BOOL)performDragOperation:(id < NSDraggingInfo >)sender {
    NSLog(@"performDragOperation in TableViewDropper.h");
    
    NSPasteboard *pboard = [sender draggingPasteboard];
    NSArray *filenames = [pboard propertyListForType:NSFilenamesPboardType];
    
    if (self.dragBlock) {
        self.dragBlock(filenames);
    }
    highlight = NO;
    [self setNeedsDisplay: YES];
    return YES;
}


- (BOOL)prepareForDragOperation:(id)sender {
    NSLog(@"prepareForDragOperation called in TableViewDropper.h");
    return YES;
}


- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if (highlight==NO) {
        NSLog(@"drag entered in TableViewDropper.h");
        highlight=YES;
        [self setNeedsDisplay: YES];
    }
    
    return NSDragOperationCopy;
}

- (void)draggingExited:(id)sender
{
    highlight=NO;
    
    [self setNeedsDisplay: YES];
    NSLog(@"drag exit in TableViewDropper.h");
}

-(void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
    
    if ( highlight ) {
        //highlight by overlaying a gray border
        [[NSColor blueColor] set];
        [NSBezierPath setDefaultLineWidth: 4];
        [NSBezierPath strokeRect: rect];
    }
}

#pragma mark - block
- (void)setDragFileBlock:(void(^)(NSArray* array))block{
    self.dragBlock = block;
}
@end
