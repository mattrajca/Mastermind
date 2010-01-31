//
//  GameView.m
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

#import "GameView.h"

#import "NSColor+Additions.h"

@interface GameView ()

- (BOOL)rowHasOneColor:(BoxColor)colors;
- (NSColor *)colorForBoxColor:(BoxColor)color;

@end


@implementation GameView

@synthesize currentRow = _currentRow;

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(NSRect)dirtyRect {		
    for (uint8_t n = 0; n < kRows; n++) {
		if (_currentRow == n) {
			[[NSColor whiteColor] set];
		}
		else {
			[[NSColor reallyLightGreyColor] set];
		}
		
		NSRectFill(RectForRow(n));
		
		[[NSColor grayColor] set];
		
		CGFloat strokeWidth = !n ? 1.0f : 2.0f;
		NSRectFill(NSMakeRect(0.0f, n * kBoxWidth, kBoxWidth * kColorsInRow, strokeWidth));
		
		for (uint8_t m = 0; m < kColorsInRow; m++) {
			[[NSColor grayColor] set];
			NSRectFill(NSMakeRect(m * kBoxWidth, 0.0f, 1.0f, kRows * kBoxWidth));
			
			[[self colorForBoxColor:_grid[n][m]] set];
			[[NSBezierPath bezierPathWithOvalInRect:NSInsetRect(RectForBox(m, n), 4.0f, 4.0f)] fill];
		}
	}
	
	[[NSColor grayColor] set];
	NSFrameRect([self bounds]);
}

- (void)mouseDown:(NSEvent *)event {
	NSPoint pt = [self convertPoint:[event locationInWindow] fromView:nil];
	
	uint8_t col = pt.x / kBoxWidth;
	uint8_t row = pt.y / kBoxWidth;
	
	if (_currentRow != row) {
		NSBeep();
		
		return;
	}
	
	BoxColor cur = _grid[row][col];
	
	if ([NSEvent modifierFlags] & NSAlternateKeyMask) {
		if (cur == BoxColorNone)
			cur = BoxColorPurple;
		else
			cur--;
	}
	else {
		if (cur == BoxColorPurple)
			cur = BoxColorNone;
		else
			cur++;
	}
	
	_grid[row][col] = cur;
	
	[self setNeedsDisplayInRect:RectForBox(col, row)];
}

#pragma mark -
#pragma mark Actions

- (BOOL)checkRow {
	for (uint8_t col = 0; col < kColorsInRow; col++) {
		uint8_t color = _grid[_currentRow][col];
		
		if (color == BoxColorNone)
			return NO;
	}
	
	if (![self rowHasOneColor:BoxColorRed])
		return NO;
	else if (![self rowHasOneColor:BoxColorBlue])
		return NO;
	else if (![self rowHasOneColor:BoxColorGreen])
		return NO;
	else if (![self rowHasOneColor:BoxColorBrown])
		return NO;
	else if (![self rowHasOneColor:BoxColorYellow])
		return NO;
	else if (![self rowHasOneColor:BoxColorPurple])
		return NO;
	
	return YES;
}

- (void)moveToNextRow {
	[self setNeedsDisplayInRect:RectForRow(_currentRow)];

	_currentRow++;
	
	[self setNeedsDisplayInRect:RectForRow(_currentRow)];
}

- (void)getColorsFromCurrentRow:(BoxColor *)colors {
	for (uint8_t i = 0; i < kColorsInRow; i++) {
		colors[i] = _grid[_currentRow][i];
	}
}

- (void)clear {
	bzero(_grid, sizeof(BoxColor) * kRows * kColorsInRow);
	_currentRow = 0;
	
	[self setNeedsDisplay:YES];
}

#pragma mark -
#pragma mark Helpers

- (BOOL)rowHasOneColor:(BoxColor)colors {
	uint8_t count = 0;
	
	for (uint8_t col = 0; col < kColorsInRow; col++) {
		uint8_t color = _grid[_currentRow][col];
		
		if (color == colors)
			count++;
	}
	
	return count == 0 || count == 1;
}

- (NSColor *)colorForBoxColor:(BoxColor)color {
	if (color == BoxColorNone) {
		return [NSColor clearColor];
	}
	else if (color == BoxColorRed) {
		return [NSColor redColor];
	}
	else if (color == BoxColorGreen) {
		return [NSColor darkGreenColor];
	}
	else if (color == BoxColorBlue) {
		return [NSColor blueColor];
	}
	else if (color == BoxColorBrown) {
		return [NSColor brownColor];
	}
	else if (color == BoxColorYellow) {
		return [NSColor orangeColor];
	}
	else if (color == BoxColorPurple) {
		return [NSColor purpleColor];
	}
	
	return [NSColor clearColor];
}

#pragma mark -

@end
