//
//  HintsView.h
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

#import "Types.h"

@interface HintsView : NSView {
  @private
	Hint _hints[6][4];
	uint8_t _currentRow;
}

- (void)markHints:(Hint *)hints;

- (void)clear;

@end
