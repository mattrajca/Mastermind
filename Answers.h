//
//  Answers.h
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

#import "Types.h"

@interface Answers : NSObject {
  @private
	BoxColor colors[4];
}

- (void)generateColors;

- (void)getHints:(Hint *)hints forColors:(BoxColor *)sColors;

@end
