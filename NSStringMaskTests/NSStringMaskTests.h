//
//  NSStringMaskTests.h
//  NSStringMaskTests
//
//  Created by Flavio Caetano on 4/24/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

/** Unit test cases for the class NSStringMask
 */
@interface NSStringMaskTests : SenTestCase

#pragma mark - Instance inits
/// @name Instance inits

/** Tests for instance inits giving patterns.
 
 Tested methods:
 
 - [NSStringMask init]
 - [NSStringMask initWithPattern:]
 - [NSStringMask initWithPattern:placeholder:]
 */
- (void)testInstanceInitsWithPatterns;

/** Tests for instance inits with regex.
 
 Tested methods:
 
 - [NSStringMask init]
 - [NSStringMask initWithRegex:]
 */
- (void)testInstanceInitsWithRegex;

#pragma mark - Class inits
/// @name Class inits

/** Tests for class inits with patterns.
 
 Tested methods:
 
 - [NSStringMask maskWithPattern:]
 */
- (void)testClassInitsWithPatterns;

/** Tests for class inits with regex.
 
 Tested methods:
 
 - [NSStringMask maskWithRegex:]
 */
- (void)testClassInitsWithRegex;

#pragma mark - Properties
/// @name Properties

/** Tests for the placeholder property.
 */
- (void)testPlaceholderProperty;

#pragma mark - Instance Methods
/// @name Instance Methods

/** Tests for the instance method format:
 */
- (void)testFormat;

/** Tests for the instance method validCharactersForString:
 */
- (void)testValidCharactersForString;

#pragma mark - Class Methods
/// @name Class Methods

/** Tests for class methods with regex.
 
 Tested methods:
 
 - [NSStringMask maskString:withRegex:placeholder:]
 - [NSStringMask maskString:withRegex:]
 */
- (void)testClassWithRegex;

/** Tests for class methods with patterns.
 
 Tested methods:
 
 - [NSStringMask maskString:withPattern:placeholder:]
 - [NSStringMask maskString:withPattern:]
 */
- (void)testClassWithPattern;

@end
