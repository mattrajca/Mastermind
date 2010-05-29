//
//  GameView.h
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

#import "Types.h"

@interface GameView : NSView {
  @private
	BoxColor grid[6][4];
	uint8_t currentRow;
}

@property (nonatomic, readonly) uint8_t currentRow;

- (BOOL)checkRow;
- (void)moveToNextRow;
- (void)getColorsFromCurrentRow:(BoxColor *)colors;

- (void)clear;

@end
