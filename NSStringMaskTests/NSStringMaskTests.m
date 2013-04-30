//
//  NSStringMaskTests.m
//  NSStringMaskTests
//
//  Created by Flavio Caetano on 4/24/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import "NSStringMaskTests.h"

#import "NSStringMask.h"

/** Category declaring private ivars and methods for the NSStringMask
 */
@interface NSStringMask ()

/** _regex getter declaration.
 */
- (NSRegularExpression *)regex;

@end

@implementation NSStringMaskTests

#pragma mark - Instance inits

// Tests for instance inits giving patterns.
- (void)testInstanceInitsWithPatterns
{
    NSStringMask *mask;
    NSRegularExpression *regexMask;
    
    STAssertNoThrow((mask = [NSStringMask new]), @"[no throw] init");
    STAssertNotNil(mask, @"[not nil] init");
    
    // Valid pattern
    mask = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"(\\d+)"]), @"[no throw] init with valid pattern");
    STAssertNotNil(mask, @"[not nil] init with valid pattern");
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNotNil([mask regex], @"[not nil] mask regex");
    
    // Invalid pattern
    mask = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"\\d"]), @"[no throw] init with invalid pattern");
    STAssertNil(mask, @"[nil] init with invalid pattern");
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNil([mask regex], @"[nil] mask regex");
}

// Tests for instance inits with regex.
- (void)testInstanceInitsWithRegex
{
    NSStringMask *mask;
    NSRegularExpression *regexMask;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d+)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    // Valid regex
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex]), @"[no throw] init with valid regex");
    STAssertNotNil(mask, @"[not nil] init with valid regex");
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, @"[equals] mask regex");
    
    // Nil regex
    regex = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex]), @"[no throw] init with invalid regex");
    STAssertNil(mask, @"[nil] init with invalid regex");
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, @"[equals] mask regex");
}

#pragma mark - Class inits

// Tests for class inits with patterns.
- (void)testClassInitsWithPatterns
{
    NSStringMask *mask;
    NSRegularExpression *regexMask;
    
    // Valid pattern
    STAssertNoThrow((mask = [NSStringMask maskWithPattern:@"(\\d+)"]), @"[no throw] init with valid pattern");
    STAssertNotNil(mask, @"[not nil] init with valid pattern");
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNotNil([mask regex], @"[not nil] mask regex");
    
    // Invalid pattern
    STAssertNoThrow((mask = [NSStringMask maskWithPattern:@"\\d"]), @"[no throw] init with invalid pattern");
    STAssertNil(mask, @"[nil] init with invalid pattern");
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNil([mask regex], @"[nil] mask regex");
}

// Tests for class inits with regex.
- (void)testClassInitsWithRegex
{
    NSStringMask *mask;
    NSRegularExpression *regexMask;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d+)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    // Valid regex;
    STAssertNoThrow((mask = [NSStringMask maskWithRegex:regex]), @"[no throw] init with valid regex");
    STAssertNotNil(mask, @"[not nil] init with valid regex");
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, @"[equals] mask regex");
    
    // Nil regex
    regex = nil;
    STAssertNoThrow((mask = [NSStringMask maskWithRegex:regex]), @"[no throw] init with invalid regex");
    STAssertNil(mask, @"[nil] init with invalid regex");
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, @"[equals] mask regex");
}

#pragma mark - Properties

// Tests for the placeholder property.
- (void)testPlaceholderProperty
{
    NSStringMask *mask = [NSStringMask new];
    STAssertNil(mask.placeholder, @"[nil] nil placeholder");
    
    STAssertNoThrow((mask.placeholder = nil), @"[no throw] setting nil placeholder");
    STAssertNil(mask.placeholder, @"[nil] nil placeholder");
    
    STAssertNoThrow((mask.placeholder = @"1"), @"[no throw] setting 1 length placeholder");
    STAssertNotNil(mask.placeholder, @"[not nil] 1 length placeholder");
    
    STAssertNoThrow((mask.placeholder = @"1234567890987654321"), @"[no throw] setting n length placeholder");
    STAssertNotNil(mask.placeholder, @"[not nil] n length placeholder");
    
    STAssertNoThrow((mask.placeholder = @""), @"[no throw] setting empty placeholder");
    STAssertNil(mask.placeholder, @"[nil] empty placeholder");
}

#pragma mark - Instance Methods

// Tests for the instance method format:
- (void)testFormat
{
    NSString *result;
    
    NSStringMask *mask = [NSStringMask new];
    
    // Empty mask
    STAssertNoThrow((result = [mask format:nil]), @"[no throw] empty mask formatting nil string");
    STAssertNil(result, @"[nil] empty mask formatting nil string");
    
    STAssertNoThrow((result = [mask format:@""]), @"[no throw] empty mask formatting empty string");
    STAssertNil(result, @"[nil] empty mask formatting empty string");
    
    STAssertNoThrow((result = [mask format:@"123"]), @"[no throw] empty mask formatting valid string");
    STAssertNil(result, @"[nil] empty mask formatting valid string");
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d{3}).(\\d{3}).(\\d{3})-(\\d{2})"];
    
    STAssertNoThrow((result = [mask format:nil]), @"[no throw] valid mask formatting nil string");
    STAssertNil(result, @"[nil] valid mask formatting nil string");
    
    STAssertNoThrow((result = [mask format:@""]), @"[no throw] valid mask formatting empty string");
    STAssertTrue(([result isEqualToString:@""]), @"[true] valid mask formatting empty string");
    
    STAssertNoThrow((result = [mask format:@"12345678909"]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[true] valid mask formatting valid string");
    
    STAssertNoThrow((result = [mask format:@"12345"]), @"[no throw] valid mask formatting short string");
    STAssertTrue(([result isEqualToString:@"12345"]), @"[true] valid mask formatting short string");
    
    STAssertNoThrow((result = [mask format:@"1234567890987654321"]), @"[no throw] valid mask formatting big string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[true] valid mask formatting big string");
    
    STAssertNoThrow((result = [mask format:@"123abc456def78909"]), @"[no throw] valid mask formatting alphanumeric string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[true] valid mask alphanumeric string");
    
    // Placeholder
    mask.placeholder = @"_";
    
    STAssertNoThrow((result = [mask format:nil]), @"[no throw] valid mask formatting nil string");
    STAssertNil(result, @"[nil] valid mask formatting nil string");
    
    STAssertNoThrow((result = [mask format:@""]), @"[no throw] valid mask formatting empty string");
    STAssertTrue(([result isEqualToString:@"___.___.___-__"]), @"[true] valid mask formatting empty string");
    
    STAssertNoThrow((result = [mask format:@"12345678909"]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[true] valid mask formatting valid string");
    
    STAssertNoThrow((result = [mask format:@"12345"]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"123.45_.___-__"]), @"[true] valid mask formatting short string");
    
    STAssertNoThrow((result = [mask format:@"1234567890987654321"]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[true] valid mask formatting big string");
    
    STAssertNoThrow((result = [mask format:@"123abc456def78909"]), @"[no throw] empty mask formatting alphanumeric  string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), @"[true] valid mask alphanumeric  string");
}

- (void)testValidCharactersForString
{
    NSString *result;
    
    NSStringMask *mask = [NSStringMask new];
    
    // Empty mask
    STAssertNoThrow((result = [mask validCharactersForString:nil]), @"[no throw] empty mask validating nil string");
    STAssertNil(result, @"[nil] empty mask validating nil string");
    
    STAssertNoThrow((result = [mask validCharactersForString:@""]), @"[no throw] empty mask validating empty string");
    STAssertNil(result, @"[nil] empty mask validating empty string");
    
    STAssertNoThrow((result = [mask validCharactersForString:@"123"]), @"[no throw] empty mask validating valid string");
    STAssertNil(result, @"[nil] empty mask validating valid string");
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d{3}).(\\d{3}).(\\d{3})-(\\d{2})"];
    
    STAssertNoThrow((result = [mask validCharactersForString:nil]), @"[no throw] valid mask validating nil string");
    STAssertNil(result, @"[nil] valid mask validating nil string");
    
    STAssertNoThrow((result = [mask validCharactersForString:@""]), @"[no throw] valid mask validating empty string");
    STAssertTrue(([result isEqualToString:@""]), @"[true] valid mask validating empty string");
    
    STAssertNoThrow((result = [mask validCharactersForString:@"12345678909"]), @"[no throw] valid mask validating valid string");
    STAssertTrue(([result isEqualToString:@"12345678909"]), @"[true] valid mask validating valid string");
    
    STAssertNoThrow((result = [mask validCharactersForString:@"1234567890987654321"]), @"[no throw] valid mask validating big string");
    STAssertTrue(([result isEqualToString:@"12345678909"]), @"[true] valid mask validating big string");
    
    STAssertNoThrow((result = [mask validCharactersForString:@"123abc456def78909"]), @"[no throw] valid mask validating alphanumeric string");
    STAssertTrue(([result isEqualToString:@"12345678909"]), @"[true] valid mask validating string");
}

#pragma mark - Class Methods

// Tests for class methods with regex.
- (void)testClassWithRegex
{
    NSString *result;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\((\\d{2})\\) (\\d{4})-(\\d{4,5})" options:NSRegularExpressionCaseInsensitive error:&error];
    
    //Valid regex
    STAssertNoThrow((result = [NSStringMask maskString:nil withRegex:regex]), @"[no throw] class mask nil string");
    STAssertNil(result, @"[nil] valid mask formatting nil string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withRegex:regex]), @"[no throw] empty mask formatting empty string");
    STAssertTrue(([result isEqualToString:@""]), @"[true] valid mask formatting empty string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withRegex:regex]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"123"]), @"[true] valid mask formatting short string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withRegex:regex]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), @"[true] valid mask formatting valid string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withRegex:regex]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), @"[true] valid mask formatting big string");
    
    // Placeholder
    STAssertNoThrow((result = [NSStringMask maskString:nil withRegex:regex placeholder:@"_"]), @"[no throw] class mask nil string");
    STAssertNil(result, @"[nil] valid mask formatting nil string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withRegex:regex placeholder:@"abcdefghi"]), @"[no throw] empty mask formatting empty string");
    STAssertTrue(([result isEqualToString:@"(ab) abcd-abcde"]), @"[true] valid mask formatting empty string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withRegex:regex placeholder:@"x"]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"(12) 3xxx-xxxxx"]), @"[true] valid mask formatting short string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withRegex:regex placeholder:@"_"]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), @"[true] valid mask formatting valid string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withRegex:regex placeholder:@"_"]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), @"[true] valid mask formatting big string");
    
    // Invalid regex
    regex = nil;
    
    STAssertNoThrow((result = [NSStringMask maskString:nil withRegex:nil]), @"[no throw] class mask nil string");
    STAssertNil(result, @"[nil] valid mask formatting nil string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withRegex:nil]), @"[no throw] empty mask formatting empty string");
    STAssertNil(result, @"[nil] empty mask formatting empty string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withRegex:nil]), @"[no throw] empty mask formatting valid string");
    STAssertNil(result, @"[nil] empty mask formatting valid string");
}

// Tests for class methods with patterns.
- (void)testClassWithPattern
{
    NSString *result;
    NSString *pattern = @"\\((\\d{2})\\) (\\d{4})-(\\d{4,5})";
    
    //Valid pattern
    STAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern]), @"[no throw] class mask nil string");
    STAssertNil(result, @"[nil] valid mask formatting nil string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern]), @"[no throw] empty mask formatting empty string");
    STAssertTrue(([result isEqualToString:@""]), @"[true] valid mask formatting empty string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"123"]), @"[true] valid mask formatting short string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withPattern:pattern]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), @"[true] valid mask formatting valid string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withPattern:pattern]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), @"[true] valid mask formatting big string");
    
    // Placeholder
    STAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern placeholder:@"_"]), @"[no throw] class mask nil string");
    STAssertNil(result, @"[nil] valid mask formatting nil string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern placeholder:@"abcdefghi"]), @"[no throw] empty mask formatting empty string");
    STAssertTrue(([result isEqualToString:@"(ab) abcd-abcde"]), @"[true] valid mask formatting empty string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern placeholder:@"x"]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"(12) 3xxx-xxxxx"]), @"[true] valid mask formatting short string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withPattern:pattern placeholder:@"_"]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), @"[true] valid mask formatting valid string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withPattern:pattern placeholder:@"_"]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), @"[true] valid mask formatting big string");
    
    // Invalid pattern
    pattern = @"\\d";
    STAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern]), @"[no throw] class mask nil string");
    STAssertNil(result, @"[nil] valid mask formatting nil string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern]), @"[no throw] empty mask formatting empty string");
    STAssertNil(result, @"[nil] empty mask formatting empty string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern]), @"[no throw] empty mask formatting valid string");
    STAssertNil(result, @"[nil] empty mask formatting valid string");
    
    // Nil pattern
    pattern = nil;
    STAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern]), @"[no throw] class mask nil string");
    STAssertNil(result, @"[nil] valid mask formatting nil string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern]), @"[no throw] empty mask formatting empty string");
    STAssertNil(result, @"[nil] empty mask formatting empty string");
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern]), @"[no throw] empty mask formatting valid string");
    STAssertNil(result, @"[nil] empty mask formatting valid string");
}

@end
