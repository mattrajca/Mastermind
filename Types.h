//
//  Types.h
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

extern const CGFloat kBoxWidth;
extern const uint8_t kColorsInRow;
extern const uint8_t kRows;

extern const CGFloat kHintWidth;
extern const uint8_t kHintsInRow;

typedef enum {
	BoxColorNone = 0,
	BoxColorRed,
	BoxColorGreen,
	BoxColorBlue,
	BoxColorBrown,
	BoxColorYellow,
	BoxColorPurple
} BoxColor;

typedef enum {
	HintNone = 0,
	HintRight,
	HintWrongPlace,
	HintWrongColor
} Hint;

extern NSRect RectForBox (uint8_t row, uint8_t col);
extern NSRect RectForRow (uint8_t row);

extern NSRect RectForHintRow (uint8_t row);
