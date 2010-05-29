//
//  MastermindAppDelegate.h
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

@class GameView, Answers, HintsView;

@interface MastermindAppDelegate : NSObject < NSApplicationDelegate > {
  @private
	NSWindow *window;
	GameView *gameView;
	HintsView *hintsView;
	Answers *answers;
}

@property (nonatomic, assign) IBOutlet NSWindow *window;
@property (nonatomic, assign) IBOutlet GameView *gameView;
@property (nonatomic, assign) IBOutlet HintsView *hintsView;

- (IBAction)newGame:(id)sender;
- (IBAction)checkRow:(id)sender;

@end
