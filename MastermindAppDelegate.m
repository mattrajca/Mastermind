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

@synthesize window = _window;
@synthesize gameView = _gameView;
@synthesize hintsView = _hintsView;

#pragma mark -
#pragma mark Initialization

- (id)init {
	self = [super init];
	if (self) {
		_answers = [[Answers alloc] init];
	}
	return self;
}

#pragma mark -
#pragma mark Actions

- (IBAction)newGame:(id)sender {
	[_answers generateColors];
	[_gameView clear];
	[_hintsView clear];
}

- (IBAction)checkRow:(id)sender {
	if ([_gameView checkRow]) {
		if (_gameView.currentRow + 1 == kRows) {
			NSBeginAlertSheet(@"Game over!", @"New Game", @"Quit", nil, _window, self, NULL,
							  @selector(sheetDidDismiss:returnCode:contextInfo:), NULL,
							  @"You ran out of rows!");
			
			return;
		}
		
		BoxColor colors[kColorsInRow];
		[_gameView getColorsFromCurrentRow:colors];
		
		Hint hints[kColorsInRow];
		[_answers getHints:hints forColors:colors];
		
		[_hintsView markHints:hints];
		
		if ([self isSolvedWithHints:hints]) {
			NSBeginAlertSheet(@"Congratulations!", @"New Game", @"Quit", nil, _window, self, NULL,
							  @selector(sheetDidDismiss:returnCode:contextInfo:), NULL,
							  @"You have solved the puzzle!");
			
			return;
		}
		
		[_gameView moveToNextRow];
	}
	else {
		NSBeginAlertSheet(@"Whoa!", @"OK", nil, nil, _window, nil, NULL, NULL, NULL, @"Invalid color combination");
	}
}

#pragma mark -
#pragma mark App Delegate

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;
}

#pragma mark -
#pragma mark Helpers

- (void)sheetDidDismiss:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
	if (returnCode == NSAlertAlternateReturn) {
		[_window close];
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

#pragma mark -

@end
