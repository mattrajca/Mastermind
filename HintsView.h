//
//  HintsView.h
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

#import "Types.h"

@interface HintsView : NSView {
  @private
	Hint hints[6][4];
	uint8_t currentRow;
}

- (void)markHints:(Hint *)sHints;

- (void)clear;

@end
