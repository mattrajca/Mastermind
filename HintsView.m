//
//  HintsView.m
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

#import "HintsView.h"

#import "NSColor+Additions.h"

@interface HintsView ()

- (NSColor *)colorForHint:(Hint)hint;

@end


@implementation HintsView

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor reallyLightGreyColor] set];
	NSRectFill(dirtyRect);
	
	for (uint8_t row = 0; row < kRows; row++) {
		for (uint8_t y = 0; y < kHintsInRow; y++) {
			for (uint8_t x = 0; x < kHintsInRow; x++) {
				Hint hint = hints[row][x + y * kHintsInRow];
				
				[[self colorForHint:hint] set];
				
				uint8_t nY = row * kHintsInRow + (1 - y);
				NSRect rect = NSMakeRect(x * kHintWidth, nY * kHintWidth, kHintWidth, kHintWidth);
				
				NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:NSInsetRect(rect, 3.0f, 3.0f)];
				[path fill];
				
				[[NSColor grayColor] set];
				
				if (hint != HintNone && hint != HintWrongColor)
					[path stroke];
				
				CGFloat strokeWidth = 1.0f;
				
				if (row != 0 && y % 2 == 0)
					strokeWidth = 2.0f;
				
				NSRectFill(NSMakeRect(x * kHintWidth, (row * kHintsInRow + y) * kHintWidth, kHintWidth, strokeWidth));
			}
		}
	}
	
	// Stroke the vertical line
	NSRectFill(NSMakeRect(kHintWidth, 0.0f, 1.0f, kRows * kBoxWidth));
	
	// Stroke the bounds
	NSFrameRect([self bounds]);
}

- (void)markHints:(Hint *)sHints {
	for (uint8_t i = 0; i < kColorsInRow; i++) {
		hints[currentRow][i] = sHints[i];
	}
	
	[self setNeedsDisplayInRect:RectForHintRow(currentRow)];
	
	currentRow++;
	
	[self setNeedsDisplayInRect:RectForHintRow(currentRow)];
}

- (void)clear {
	bzero(hints, sizeof(Hint) * kRows * kColorsInRow);
	currentRow = 0;
	
	[self setNeedsDisplay:YES];
}

- (NSColor *)colorForHint:(Hint)hint {
	if (hint == HintRight) {
		return [NSColor blackColor];
	}
	else if (hint == HintWrongPlace) {
		return [NSColor whiteColor];
	}
	
	return [NSColor clearColor];
}

@end
