//
//  Answers.m
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

#import "Answers.h"

#import <stdlib.h>

@interface Answers ()

- (BOOL)previousIndiciesContain:(BoxColor)color toIndex:(uint8_t)index;
- (BoxColor)colorForIndex:(int)index;
- (BOOL)containsColor:(BoxColor)color;

@end


@implementation Answers

- (id)init {
	self = [super init];
	if (self) {
		srandom(time(NULL));
		
		[self generateColors];
	}
	return self;
}

#pragma mark -
#pragma mark Actions

- (void)generateColors {
	for (uint8_t i = 0; i < kColorsInRow; i++) {
		colors[i] = [self colorForIndex:i];
	}
}

- (void)getHints:(Hint *)hints forColors:(BoxColor *)sColors {
	for (uint8_t i = 0; i < kColorsInRow; i++) {
		BoxColor color = sColors[i];
		
		if (colors[i] == color) {
			hints[i] = HintRight;
		}
		else if ([self containsColor:color]) {
			hints[i] = HintWrongPlace;
		}
		else {
			hints[i] = HintWrongColor;
		}
	}
	
	qsort_b(hints, 4, 4, ^int (const void *arg1, const void *arg2) {
		int a1 = *(int *)arg1;
		int a2 = *(int *)arg2;
		
		if (a1 == a2) {
			return 0;
		}
		else if (a1 > a2) {
			return 1;
		}
		
		return -1;
	});
}

- (BOOL)previousIndiciesContain:(BoxColor)color toIndex:(uint8_t)index {
	for (uint8_t i = 0; i < index; i++) {
		if (colors[i] == color)
			return YES;
	}
	
	return NO;
}

- (BoxColor)colorForIndex:(int)index {
	BoxColor color;
	
	do {
		color = (random() % 6) + 1;
	}
	while ([self previousIndiciesContain:color toIndex:index]);
	
	return color;
}

- (BOOL)containsColor:(BoxColor)color {
	for (uint8_t i = 0; i < kColorsInRow; i++) {
		if (colors[i] == color)
			return YES;
	}
	
	return NO;
}

@end
