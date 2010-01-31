//
//  Types.m
//  Mastermind
//
//  Copyright Matt Rajca 2009. All rights reserved.
//

#include "Types.h"

const CGFloat kBoxWidth = 40.0f;
const uint8_t kColorsInRow = 4;
const uint8_t kRows = 6;

const CGFloat kHintWidth = 20.0f;
const uint8_t kHintsInRow = 2;

NSRect RectForBox (uint8_t row, uint8_t col) {
	return NSMakeRect(kBoxWidth * row, kBoxWidth * col, kBoxWidth, kBoxWidth);
}

NSRect RectForRow (uint8_t row) {
	return NSMakeRect(0.0f, row * kBoxWidth, kBoxWidth * kColorsInRow, kBoxWidth);
}

NSRect RectForHintRow (uint8_t row) {
	return NSMakeRect(0.0f, row * kBoxWidth, kBoxWidth, kBoxWidth);
}
