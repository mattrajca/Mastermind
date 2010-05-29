//
//  MastermindAppDelegate.m
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

#import "MastermindAppDelegate.h"

#import "Answers.h"
#import "GameView.h"
#import "HintsView.h"
#import "Types.h"

@interface MastermindAppDelegate ()

- (BOOL)isSolvedWithHints:(Hint *)hints;

@end


@implementation MastermindAppDelegate

@synthesize window, gameView, hintsView;

- (id)init {
	self = [super init];
	if (self) {
		answers = [[Answers alloc] init];
	}
	return self;
}

- (IBAction)newGame:(id)sender {
	[answers generateColors];
	[gameView clear];
	[hintsView clear];
}

- (IBAction)checkRow:(id)sender {
	if ([gameView checkRow]) {
		if (gameView.currentRow + 1 == kRows) {
			NSBeginAlertSheet(@"Game over!", @"New Game", @"Quit", nil, window, self, NULL,
							  @selector(sheetDidDismiss:returnCode:contextInfo:), NULL,
							  @"You ran out of rows!");
			
			return;
		}
		
		BoxColor colors[kColorsInRow];
		[gameView getColorsFromCurrentRow:colors];
		
		Hint hints[kColorsInRow];
		[answers getHints:hints forColors:colors];
		
		[hintsView markHints:hints];
		
		if ([self isSolvedWithHints:hints]) {
			NSBeginAlertSheet(@"Congratulations!", @"New Game", @"Quit", nil, window, self, NULL,
							  @selector(sheetDidDismiss:returnCode:contextInfo:), NULL,
							  @"You have solved the puzzle!");
			
			return;
		}
		
		[gameView moveToNextRow];
	}
	else {
		NSBeginAlertSheet(@"Whoa!", @"OK", nil, nil, window, nil, NULL, NULL, NULL, @"Invalid color combination");
	}
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;
}

- (void)sheetDidDismiss:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
	if (returnCode == NSAlertAlternateReturn) {
		[window close];
	}
	else {
		[self newGame:nil];
	}
}

- (BOOL)isSolvedWithHints:(Hint *)hints {
	for (uint8_t i = 0; i < kColorsInRow; i++) {
		if (hints[i] != HintRight)
			return NO;
	}
	
	return YES;
}

@end
