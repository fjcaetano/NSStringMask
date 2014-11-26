//
//  NSStringMaskTests.m
//  NSStringMaskTests
//
//  Created by Flavio Caetano on 4/24/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import <XCTest/XCTest.h>


#import "NSStringMask.h"

/** Category declaring private ivars and methods for the NSStringMask
 */
@interface NSStringMask ()

/** _regex getter declaration.
 */
- (NSRegularExpression *)regex;

@end

@interface NSStringMaskTests : XCTestCase

@end

@implementation NSStringMaskTests

#pragma mark - Instance inits

// Tests for instance inits giving patterns.
- (void)testInstanceInitsWithPatterns
{
    NSStringMask *mask;
    NSString *placeholder, *placeholderMask;
    NSRegularExpression *regexMask;
    
    XCTAssertNoThrow((mask = [NSStringMask new]), @"[no throw] init");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    // Valid pattern
    mask = nil;
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"(\\d+)"]), @"[no throw] init with valid pattern");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNotNil([mask regex], @"[%@]", mask);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    // Valid pattern; Invalid placeholder
    placeholder = nil;
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"(\\d+)" placeholder:placeholder]), @"[no throw] init with valid pattern; invalid placeholder");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNotNil(regexMask, @"[%@]", mask);
    
    // Valid pattern; Valid placeholder
    placeholder = @"_";
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"(\\d+)" placeholder:placeholder]), @"[no throw] init with valid pattern; valid placeholder");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertTrue([placeholderMask isEqualToString:@"_"], @"[%@]", placeholderMask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNotNil(regexMask, @"[%@]", mask);
    
    // Invalid pattern
    mask = nil;
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"\\d"]), @"[no throw] init with invalid pattern");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNil([mask regex], @"[%@]", mask);
    
    // Invalid pattern; Invalid placeholder
    placeholder = nil;
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"\\d"]), @"[no throw] init with invalid pattern; invalid placeholder");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNil([mask regex], @"[%@]", mask);
    
    // Invalid pattern; Valid placeholder
    placeholder = @"_";
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"\\d"]), @"[no throw] init with invalid pattern; valid placeholder");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNil([mask regex], @"[%@]", mask);
}

// Tests for instance inits with regex.
- (void)testInstanceInitsWithRegex
{
    NSStringMask *mask;
    NSString *placeholder, *placeholderMask;
    NSRegularExpression *regexMask;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d+)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    // Valid regex
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex]), @"[no throw] init with valid regex");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    // Valid regex; Invalid placeholder
    placeholder = nil;
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex placeholder:placeholder]), @"[no throw] init with valid regex; invalid placeholder");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    // Valid regex; Valid placeholder
    placeholder = @"_";
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex placeholder:placeholder]), @"[no throw] init with valid regex; valid placeholder");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertTrue([placeholderMask isEqualToString:@"_"], @"[%@]", placeholderMask);
    
    // Nil regex
    regex = nil;
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex]), @"[no throw] init with invalid regex");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    // Nil regex; Invalid placeholder
    placeholder = nil;
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex placeholder:placeholder]), @"[no throw] init with invalid regex; invalid placeholder");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    // Nil regex; Valid placeholder
    placeholder = @"_";
    XCTAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex placeholder:placeholder]), @"[no throw] init with invalid regex; valid placeholder");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
}

#pragma mark - Class inits

// Tests for class inits with patterns.
- (void)testClassInitsWithPatterns
{
    NSStringMask *mask;
    NSString *placeholder, *placeholderMask;
    NSRegularExpression *regexMask;
    
    // Valid pattern
    XCTAssertNoThrow((mask = [NSStringMask maskWithPattern:@"(\\d+)"]), @"[no throw] init with valid pattern");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNotNil([mask regex], @"[%@]", [mask regex]);
    
    // Valid pattern; Invalid placeholder
    placeholder = nil;
    XCTAssertNoThrow((mask = [NSStringMask maskWithPattern:@"(\\d+)" placeholder:placeholder]), @"[no throw] init with valid pattern; invalid placeholder");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNotNil([mask regex], @"[%@]", [mask regex]);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    // Valid pattern; Valid placeholder
    placeholder = @"_";
    XCTAssertNoThrow((mask = [NSStringMask maskWithPattern:@"(\\d+)" placeholder:placeholder]), @"[no throw] init with valid pattern; valid placeholder");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNotNil([mask regex], @"[%@]", [mask regex]);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertTrue([placeholderMask isEqualToString:@"_"], @"[%@]", placeholderMask);
    
    // Invalid pattern
    XCTAssertNoThrow((mask = [NSStringMask maskWithPattern:@"\\d"]), @"[no throw] init with invalid pattern");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNil([mask regex], @"[%@]", [mask regex]);
    
    // Invalid pattern; Invalid placeholder
    placeholder = nil;
    XCTAssertNoThrow((mask = [NSStringMask maskWithPattern:@"\\d" placeholder:placeholder]), @"[no throw] init with invalid pattern; invalid placeholder");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNil([mask regex], @"[%@]", [mask regex]);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    // Invalid pattern; Valid placeholder
    placeholder = @"_";
    XCTAssertNoThrow((mask = [NSStringMask maskWithPattern:@"\\d" placeholder:placeholder]), @"[no throw] init with invalid pattern; valid placeholder");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertNil([mask regex], @"[%@]", [mask regex]);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
}

// Tests for class inits with regex.
- (void)testClassInitsWithRegex
{
    NSStringMask *mask;
    NSString *placeholder, *placeholderMask;
    NSRegularExpression *regexMask;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d+)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    // Valid regex;
    XCTAssertNoThrow((mask = [NSStringMask maskWithRegex:regex]), @"[no throw] init with valid regex");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    // Valid regex; Invalid placeholder
    placeholder = nil;
    XCTAssertNoThrow((mask = [NSStringMask maskWithRegex:regex placeholder:placeholder]), @"[no throw] init with valid regex; invalid placeholder");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    // Valid regex; Valid placeholder
    placeholder = @"_";
    XCTAssertNoThrow((mask = [NSStringMask maskWithRegex:regex placeholder:placeholder]), @"[no throw] init with valid regex; valid placeholder");
    XCTAssertNotNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertTrue([placeholderMask isEqualToString:@"_"], @"[%@]", placeholderMask);
    
    // Nil regex
    regex = nil;
    XCTAssertNoThrow((mask = [NSStringMask maskWithRegex:regex]), @"[no throw] init with invalid regex");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    // Nil regex; Invalid placeholder
    placeholder = nil;
    XCTAssertNoThrow((mask = [NSStringMask maskWithRegex:regex placeholder:placeholder]), @"[no throw] init with invalid regex; invalid placeholder");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
    
    // Nil regex; Valid placeholder
    placeholder = @"_";
    XCTAssertNoThrow((mask = [NSStringMask maskWithRegex:regex placeholder:placeholder]), @"[no throw] init with invalid regex; valid placeholder");
    XCTAssertNil(mask, @"[%@]", mask);
    
    XCTAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    XCTAssertEqual(regexMask, regex, @"[regexMask = %@, regex = %@]", regexMask, regex);
    
    XCTAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    XCTAssertNil(placeholderMask, @"[%@]", placeholderMask);
}

#pragma mark - Properties

// Tests for the placeholder property.
- (void)testPlaceholderProperty
{
    NSStringMask *mask = [NSStringMask new];
    XCTAssertNil(mask.placeholder, @"[%@]", mask.placeholder);
    
    XCTAssertNoThrow((mask.placeholder = nil), @"[no throw] setting nil placeholder");
    XCTAssertNil(mask.placeholder, @"[%@]", mask.placeholder);
    
    XCTAssertNoThrow((mask.placeholder = @"1"), @"[no throw] setting 1 length placeholder");
    XCTAssertNotNil(mask.placeholder, @"[%@]", mask.placeholder);
    
    XCTAssertNoThrow((mask.placeholder = @"1234567890987654321"), @"[no throw] setting n length placeholder");
    XCTAssertNotNil(mask.placeholder, @"[%@]", mask.placeholder);
    
    XCTAssertNoThrow((mask.placeholder = @""), @"[no throw] setting empty placeholder");
    XCTAssertNil(mask.placeholder, @"[%@]", mask.placeholder);
}

#pragma mark - Instance Methods

// Tests for the instance method format:
- (void)testFormat
{
    NSString *result;
    
    NSStringMask *mask = [NSStringMask new];
    
    // Empty mask
    XCTAssertNoThrow((result = [mask format:nil]), @"[no throw] empty mask formatting nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@""]), @"[no throw] empty mask formatting empty string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@"123"]), @"[no throw] empty mask formatting valid string");
    XCTAssertNil(result, @"[%@]", result);
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d{3}).(\\d{3}).(\\d{3})-(\\d{2})"];
    
    XCTAssertNoThrow((result = [mask format:nil]), @"[no throw] valid mask formatting nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@""]), @"[no throw] valid mask formatting empty string");
    XCTAssertTrue(([result isEqualToString:@""]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@"12345678909"]), @"[no throw] empty mask formatting valid string");
    XCTAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@"12345"]), @"[no throw] valid mask formatting short string");
    XCTAssertTrue(([result isEqualToString:@"12345"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@"1234567890987654321"]), @"[no throw] valid mask formatting big string");
    XCTAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@"123abc456def78909"]), @"[no throw] valid mask formatting alphanumeric string");
    XCTAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[%@]", result);
    
    // Placeholder
    mask.placeholder = @"_";
    
    XCTAssertNoThrow((result = [mask format:nil]), @"[no throw] valid mask formatting nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@""]), @"[no throw] valid mask formatting empty string");
    XCTAssertTrue(([result isEqualToString:@"___.___.___-__"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@"12345678909"]), @"[no throw] empty mask formatting valid string");
    XCTAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@"12345"]), @"[no throw] empty mask formatting short string");
    XCTAssertTrue(([result isEqualToString:@"123.45_.___-__"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@"1234567890987654321"]), @"[no throw] empty mask formatting big string");
    XCTAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask format:@"123abc456def78909"]), @"[no throw] empty mask formatting alphanumeric  string");
    XCTAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[%@]", result);
}

- (void)testValidCharactersForString
{
    NSString *result;
    
    NSStringMask *mask = [NSStringMask new];
    
    // Empty mask
    XCTAssertNoThrow((result = [mask validCharactersForString:nil]), @"[no throw] empty mask validating nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@""]), @"[no throw] empty mask validating empty string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@"123"]), @"[no throw] empty mask validating valid string");
    XCTAssertNil(result, @"[%@]", result);
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d{3}).(\\d{3}).(\\d{3})-(\\d{2})"];
    
    XCTAssertNoThrow((result = [mask validCharactersForString:nil]), @"[no throw] valid mask validating nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@""]), @"[no throw] valid mask validating empty string");
    XCTAssertTrue(([result isEqualToString:@""]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@"12345678909"]), @"[no throw] valid mask validating valid string");
    XCTAssertTrue(([result isEqualToString:@"12345678909"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@"1234567890987654321"]), @"[no throw] valid mask validating big string");
    XCTAssertTrue(([result isEqualToString:@"12345678909"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@"123abc456def78909"]), @"[no throw] valid mask validating alphanumeric string");
    XCTAssertTrue(([result isEqualToString:@"12345678909"]), @"[%@]", result);
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d+)"];
    
    XCTAssertNoThrow((result = [mask validCharactersForString:nil]), @"[no throw] valid mask validating nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@""]), @"[no throw] valid mask validating empty string");
    XCTAssertTrue(([result isEqualToString:@""]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@"12345678909"]), @"[no throw] valid mask validating valid string");
    XCTAssertTrue(([result isEqualToString:@"12345678909"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@"1234567890987654321"]), @"[no throw] valid mask validating big string");
    XCTAssertTrue(([result isEqualToString:@"1234567890987654321"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@"123abc456def78909"]), @"[no throw] valid mask validating alphanumeric string");
    XCTAssertTrue(([result isEqualToString:@"12345678909"]), @"[%@]", result);
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d{2}$)"];
    
    XCTAssertNoThrow((result = [mask validCharactersForString:@"1234567890"]), @"[no throw] valid mask validating nil string");
    XCTAssertTrue(([result isEqualToString:@"90"]), @"[%@]", result);
}

#pragma mark - Class Methods

// Tests for class methods with regex.
- (void)testClassWithRegex
{
    NSString *result;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\((\\d{2})\\) (\\d{4})-(\\d{4,5})" options:NSRegularExpressionCaseInsensitive error:&error];
    
    //Valid regex
    XCTAssertNoThrow((result = [NSStringMask maskString:nil withRegex:regex]), @"[no throw] class mask nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"" withRegex:regex]), @"[no throw] empty mask formatting empty string");
    XCTAssertTrue(([result isEqualToString:@""]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"123" withRegex:regex]), @"[no throw] empty mask formatting short string");
    XCTAssertTrue(([result isEqualToString:@"123"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withRegex:regex]), @"[no throw] empty mask formatting valid string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withRegex:regex]), @"[no throw] empty mask formatting big string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), @"[%@]", result);
    
    // Placeholder
    XCTAssertNoThrow((result = [NSStringMask maskString:nil withRegex:regex placeholder:@"_"]), @"[no throw] class mask nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"" withRegex:regex placeholder:@"abcdefghi"]), @"[no throw] empty mask formatting empty string");
    XCTAssertTrue(([result isEqualToString:@"(ab) abcd-abcde"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"123" withRegex:regex placeholder:@"x"]), @"[no throw] empty mask formatting short string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3xxx-xxxxx"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withRegex:regex placeholder:@"_"]), @"[no throw] empty mask formatting valid string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withRegex:regex placeholder:@"_"]), @"[no throw] empty mask formatting big string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), @"[%@]", result);
    
    // Invalid regex
    regex = nil;
    
    XCTAssertNoThrow((result = [NSStringMask maskString:nil withRegex:nil]), @"[no throw] class mask nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"" withRegex:nil]), @"[no throw] empty mask formatting empty string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"123" withRegex:nil]), @"[no throw] empty mask formatting valid string");
    XCTAssertNil(result, @"[%@]", result);
}

// Tests for class methods with patterns.
- (void)testClassWithPattern
{
    NSString *result;
    NSString *pattern = @"\\((\\d{2})\\) (\\d{4})-(\\d{4,5})";
    
    //Valid pattern
    XCTAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern]), @"[no throw] class mask nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern]), @"[no throw] empty mask formatting empty string");
    XCTAssertTrue(([result isEqualToString:@""]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern]), @"[no throw] empty mask formatting short string");
    XCTAssertTrue(([result isEqualToString:@"123"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withPattern:pattern]), @"[no throw] empty mask formatting valid string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withPattern:pattern]), @"[no throw] empty mask formatting big string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), @"[%@]", result);
    
    // Placeholder
    XCTAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern placeholder:@"_"]), @"[no throw] class mask nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern placeholder:@"abcdefghi"]), @"[no throw] empty mask formatting empty string");
    XCTAssertTrue(([result isEqualToString:@"(ab) abcd-abcde"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern placeholder:@"x"]), @"[no throw] empty mask formatting short string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3xxx-xxxxx"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withPattern:pattern placeholder:@"_"]), @"[no throw] empty mask formatting valid string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withPattern:pattern placeholder:@"_"]), @"[no throw] empty mask formatting big string");
    XCTAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), @"[%@]", result);
    
    // Invalid pattern
    pattern = @"\\d";
    XCTAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern]), @"[no throw] class mask nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern]), @"[no throw] empty mask formatting empty string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern]), @"[no throw] empty mask formatting valid string");
    XCTAssertNil(result, @"[%@]", result);
    
    // Nil pattern
    pattern = nil;
    XCTAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern]), @"[no throw] class mask nil string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern]), @"[no throw] empty mask formatting empty string");
    XCTAssertNil(result, @"[%@]", result);
    
    XCTAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern]), @"[no throw] empty mask formatting valid string");
    XCTAssertNil(result, @"[%@]", result);
}

@end
