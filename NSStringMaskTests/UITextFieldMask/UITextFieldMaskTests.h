//
//  UITextFieldMaskTests.h
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

/** Unit test cases for the class UITextFieldMask
 */
@interface UITextFieldMaskTests : SenTestCase

/** Testing the initialization with invalid masks.
 */
- (void)testEmptyMask;

/** Testing the initialization with valid masks.
 */
- (void)testValidMask;

/** Testing UITextFieldDelegate methods without extension.
 */
- (void)testNilExtension;

#pragma mark - Testing Extensions
/// @name Testing Extensions

/** Testing parcially implemented UITextFieldDelegate methods with extension.
 */
- (void)testExtensionWithoutOptionalMethods;

/** Testing fully implemented UITextFieldDelegate methods with extension.
 */
- (void)testExtensionWithOptionalMethods;

@end
