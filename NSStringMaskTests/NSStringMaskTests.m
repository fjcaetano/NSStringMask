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
    NSString *placeholder, *placeholderMask;
    NSRegularExpression *regexMask;
    
    STAssertNoThrow((mask = [NSStringMask new]), @"[no throw] init");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    // Valid pattern
    mask = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"(\\d+)"]), @"[no throw] init with valid pattern");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNotNil([mask regex], [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Valid pattern; Invalid placeholder
    placeholder = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"(\\d+)" placeholder:placeholder]), @"[no throw] init with valid pattern; invalid placeholder");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNotNil(regexMask, [NSString stringWithFormat:@"[%@]", mask]);
    
    // Valid pattern; Valid placeholder
    placeholder = @"_";
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"(\\d+)" placeholder:placeholder]), @"[no throw] init with valid pattern; valid placeholder");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertTrue([placeholderMask isEqualToString:@"_"], [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNotNil(regexMask, [NSString stringWithFormat:@"[%@]", mask]);
    
    // Invalid pattern
    mask = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"\\d"]), @"[no throw] init with invalid pattern");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNil([mask regex], [NSString stringWithFormat:@"[%@]", mask]);
    
    // Invalid pattern; Invalid placeholder
    placeholder = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"\\d"]), @"[no throw] init with invalid pattern; invalid placeholder");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNil([mask regex], [NSString stringWithFormat:@"[%@]", mask]);
    
    // Invalid pattern; Valid placeholder
    placeholder = @"_";
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithPattern:@"\\d"]), @"[no throw] init with invalid pattern; valid placeholder");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNil([mask regex], [NSString stringWithFormat:@"[%@]", mask]);
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
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex]), @"[no throw] init with valid regex");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    // Valid regex; Invalid placeholder
    placeholder = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex placeholder:placeholder]), @"[no throw] init with valid regex; invalid placeholder");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Valid regex; Valid placeholder
    placeholder = @"_";
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex placeholder:placeholder]), @"[no throw] init with valid regex; valid placeholder");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertTrue([placeholderMask isEqualToString:@"_"], [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Nil regex
    regex = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex]), @"[no throw] init with invalid regex");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    // Nil regex; Invalid placeholder
    placeholder = nil;
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex placeholder:placeholder]), @"[no throw] init with invalid regex; invalid placeholder");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Nil regex; Valid placeholder
    placeholder = @"_";
    STAssertNoThrow((mask = [[NSStringMask alloc] initWithRegex:regex placeholder:placeholder]), @"[no throw] init with invalid regex; valid placeholder");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
}

#pragma mark - Class inits

// Tests for class inits with patterns.
- (void)testClassInitsWithPatterns
{
    NSStringMask *mask;
    NSString *placeholder, *placeholderMask;
    NSRegularExpression *regexMask;
    
    // Valid pattern
    STAssertNoThrow((mask = [NSStringMask maskWithPattern:@"(\\d+)"]), @"[no throw] init with valid pattern");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNotNil([mask regex], [NSString stringWithFormat:@"[%@]", [mask regex]]);
    
    // Valid pattern; Invalid placeholder
    placeholder = nil;
    STAssertNoThrow((mask = [NSStringMask maskWithPattern:@"(\\d+)" placeholder:placeholder]), @"[no throw] init with valid pattern; invalid placeholder");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNotNil([mask regex], [NSString stringWithFormat:@"[%@]", [mask regex]]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Valid pattern; Valid placeholder
    placeholder = @"_";
    STAssertNoThrow((mask = [NSStringMask maskWithPattern:@"(\\d+)" placeholder:placeholder]), @"[no throw] init with valid pattern; valid placeholder");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNotNil([mask regex], [NSString stringWithFormat:@"[%@]", [mask regex]]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertTrue([placeholderMask isEqualToString:@"_"], [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Invalid pattern
    STAssertNoThrow((mask = [NSStringMask maskWithPattern:@"\\d"]), @"[no throw] init with invalid pattern");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNil([mask regex], [NSString stringWithFormat:@"[%@]", [mask regex]]);
    
    // Invalid pattern; Invalid placeholder
    placeholder = nil;
    STAssertNoThrow((mask = [NSStringMask maskWithPattern:@"\\d" placeholder:placeholder]), @"[no throw] init with invalid pattern; invalid placeholder");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNil([mask regex], [NSString stringWithFormat:@"[%@]", [mask regex]]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Invalid pattern; Valid placeholder
    placeholder = @"_";
    STAssertNoThrow((mask = [NSStringMask maskWithPattern:@"\\d" placeholder:placeholder]), @"[no throw] init with invalid pattern; valid placeholder");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertNil([mask regex], [NSString stringWithFormat:@"[%@]", [mask regex]]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
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
    STAssertNoThrow((mask = [NSStringMask maskWithRegex:regex]), @"[no throw] init with valid regex");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    // Valid regex; Invalid placeholder
    placeholder = nil;
    STAssertNoThrow((mask = [NSStringMask maskWithRegex:regex placeholder:placeholder]), @"[no throw] init with valid regex; invalid placeholder");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Valid regex; Valid placeholder
    placeholder = @"_";
    STAssertNoThrow((mask = [NSStringMask maskWithRegex:regex placeholder:placeholder]), @"[no throw] init with valid regex; valid placeholder");
    STAssertNotNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertTrue([placeholderMask isEqualToString:@"_"], [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Nil regex
    regex = nil;
    STAssertNoThrow((mask = [NSStringMask maskWithRegex:regex]), @"[no throw] init with invalid regex");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    // Nil regex; Invalid placeholder
    placeholder = nil;
    STAssertNoThrow((mask = [NSStringMask maskWithRegex:regex placeholder:placeholder]), @"[no throw] init with invalid regex; invalid placeholder");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
    
    // Nil regex; Valid placeholder
    placeholder = @"_";
    STAssertNoThrow((mask = [NSStringMask maskWithRegex:regex placeholder:placeholder]), @"[no throw] init with invalid regex; valid placeholder");
    STAssertNil(mask, [NSString stringWithFormat:@"[%@]", mask]);
    
    STAssertNoThrow((regexMask = [mask regex]), @"[no throw] mask regex");
    STAssertEquals(regexMask, regex, [NSString stringWithFormat:@"[regexMask = %@, regex = %@]", regexMask, regex]);
    
    STAssertNoThrow((placeholderMask = mask.placeholder), @"[no throw] mask placeholder");
    STAssertNil(placeholderMask, [NSString stringWithFormat:@"[%@]", placeholderMask]);
}

#pragma mark - Properties

// Tests for the placeholder property.
- (void)testPlaceholderProperty
{
    NSStringMask *mask = [NSStringMask new];
    STAssertNil(mask.placeholder, [NSString stringWithFormat:@"[%@]", mask.placeholder]);
    
    STAssertNoThrow((mask.placeholder = nil), @"[no throw] setting nil placeholder");
    STAssertNil(mask.placeholder, [NSString stringWithFormat:@"[%@]", mask.placeholder]);
    
    STAssertNoThrow((mask.placeholder = @"1"), @"[no throw] setting 1 length placeholder");
    STAssertNotNil(mask.placeholder, [NSString stringWithFormat:@"[%@]", mask.placeholder]);
    
    STAssertNoThrow((mask.placeholder = @"1234567890987654321"), @"[no throw] setting n length placeholder");
    STAssertNotNil(mask.placeholder, [NSString stringWithFormat:@"[%@]", mask.placeholder]);
    
    STAssertNoThrow((mask.placeholder = @""), @"[no throw] setting empty placeholder");
    STAssertNil(mask.placeholder, [NSString stringWithFormat:@"[%@]", mask.placeholder]);
}

#pragma mark - Instance Methods

// Tests for the instance method format:
- (void)testFormat
{
    NSString *result;
    
    NSStringMask *mask = [NSStringMask new];
    
    // Empty mask
    STAssertNoThrow((result = [mask format:nil]), @"[no throw] empty mask formatting nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@""]), @"[no throw] empty mask formatting empty string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@"123"]), @"[no throw] empty mask formatting valid string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d{3}).(\\d{3}).(\\d{3})-(\\d{2})"];
    
    STAssertNoThrow((result = [mask format:nil]), @"[no throw] valid mask formatting nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@""]), @"[no throw] valid mask formatting empty string");
    STAssertTrue(([result isEqualToString:@""]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@"12345678909"]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@"12345"]), @"[no throw] valid mask formatting short string");
    STAssertTrue(([result isEqualToString:@"12345"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@"1234567890987654321"]), @"[no throw] valid mask formatting big string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@"123abc456def78909"]), @"[no throw] valid mask formatting alphanumeric string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), [NSString stringWithFormat:@"[%@]", result]);
    
    // Placeholder
    mask.placeholder = @"_";
    
    STAssertNoThrow((result = [mask format:nil]), @"[no throw] valid mask formatting nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@""]), @"[no throw] valid mask formatting empty string");
    STAssertTrue(([result isEqualToString:@"___.___.___-__"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@"12345678909"]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@"12345"]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"123.45_.___-__"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@"1234567890987654321"]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask format:@"123abc456def78909"]), @"[no throw] empty mask formatting alphanumeric  string");
    STAssertTrue(([result isEqualToString:@"123.456.789-09"]), [NSString stringWithFormat:@"[%@]", result]);
}

- (void)testValidCharactersForString
{
    NSString *result;
    
    NSStringMask *mask = [NSStringMask new];
    
    // Empty mask
    STAssertNoThrow((result = [mask validCharactersForString:nil]), @"[no throw] empty mask validating nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@""]), @"[no throw] empty mask validating empty string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@"123"]), @"[no throw] empty mask validating valid string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d{3}).(\\d{3}).(\\d{3})-(\\d{2})"];
    
    STAssertNoThrow((result = [mask validCharactersForString:nil]), @"[no throw] valid mask validating nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@""]), @"[no throw] valid mask validating empty string");
    STAssertTrue(([result isEqualToString:@""]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@"12345678909"]), @"[no throw] valid mask validating valid string");
    STAssertTrue(([result isEqualToString:@"12345678909"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@"1234567890987654321"]), @"[no throw] valid mask validating big string");
    STAssertTrue(([result isEqualToString:@"12345678909"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@"123abc456def78909"]), @"[no throw] valid mask validating alphanumeric string");
    STAssertTrue(([result isEqualToString:@"12345678909"]), [NSString stringWithFormat:@"[%@]", result]);
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d+)"];
    
    STAssertNoThrow((result = [mask validCharactersForString:nil]), @"[no throw] valid mask validating nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@""]), @"[no throw] valid mask validating empty string");
    STAssertTrue(([result isEqualToString:@""]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@"12345678909"]), @"[no throw] valid mask validating valid string");
    STAssertTrue(([result isEqualToString:@"12345678909"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@"1234567890987654321"]), @"[no throw] valid mask validating big string");
    STAssertTrue(([result isEqualToString:@"1234567890987654321"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [mask validCharactersForString:@"123abc456def78909"]), @"[no throw] valid mask validating alphanumeric string");
    STAssertTrue(([result isEqualToString:@"12345678909"]), [NSString stringWithFormat:@"[%@]", result]);
    
    // Valid mask
    mask = [NSStringMask maskWithPattern:@"(\\d{2}$)"];
    
    STAssertNoThrow((result = [mask validCharactersForString:@"1234567890"]), @"[no throw] valid mask validating nil string");
    STAssertTrue(([result isEqualToString:@"90"]), [NSString stringWithFormat:@"[%@]", result]);
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
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withRegex:regex]), @"[no throw] empty mask formatting empty string");
    STAssertTrue(([result isEqualToString:@""]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withRegex:regex]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"123"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withRegex:regex]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withRegex:regex]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), [NSString stringWithFormat:@"[%@]", result]);
    
    // Placeholder
    STAssertNoThrow((result = [NSStringMask maskString:nil withRegex:regex placeholder:@"_"]), @"[no throw] class mask nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withRegex:regex placeholder:@"abcdefghi"]), @"[no throw] empty mask formatting empty string");
    STAssertTrue(([result isEqualToString:@"(ab) abcd-abcde"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withRegex:regex placeholder:@"x"]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"(12) 3xxx-xxxxx"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withRegex:regex placeholder:@"_"]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withRegex:regex placeholder:@"_"]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), [NSString stringWithFormat:@"[%@]", result]);
    
    // Invalid regex
    regex = nil;
    
    STAssertNoThrow((result = [NSStringMask maskString:nil withRegex:nil]), @"[no throw] class mask nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withRegex:nil]), @"[no throw] empty mask formatting empty string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withRegex:nil]), @"[no throw] empty mask formatting valid string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
}

// Tests for class methods with patterns.
- (void)testClassWithPattern
{
    NSString *result;
    NSString *pattern = @"\\((\\d{2})\\) (\\d{4})-(\\d{4,5})";
    
    //Valid pattern
    STAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern]), @"[no throw] class mask nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern]), @"[no throw] empty mask formatting empty string");
    STAssertTrue(([result isEqualToString:@""]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"123"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withPattern:pattern]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withPattern:pattern]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), [NSString stringWithFormat:@"[%@]", result]);
    
    // Placeholder
    STAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern placeholder:@"_"]), @"[no throw] class mask nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern placeholder:@"abcdefghi"]), @"[no throw] empty mask formatting empty string");
    STAssertTrue(([result isEqualToString:@"(ab) abcd-abcde"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern placeholder:@"x"]), @"[no throw] empty mask formatting short string");
    STAssertTrue(([result isEqualToString:@"(12) 3xxx-xxxxx"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890" withPattern:pattern placeholder:@"_"]), @"[no throw] empty mask formatting valid string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-7890"]), [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"1234567890987654321" withPattern:pattern placeholder:@"_"]), @"[no throw] empty mask formatting big string");
    STAssertTrue(([result isEqualToString:@"(12) 3456-78909"]), [NSString stringWithFormat:@"[%@]", result]);
    
    // Invalid pattern
    pattern = @"\\d";
    STAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern]), @"[no throw] class mask nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern]), @"[no throw] empty mask formatting empty string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern]), @"[no throw] empty mask formatting valid string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    // Nil pattern
    pattern = nil;
    STAssertNoThrow((result = [NSStringMask maskString:nil withPattern:pattern]), @"[no throw] class mask nil string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"" withPattern:pattern]), @"[no throw] empty mask formatting empty string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
    
    STAssertNoThrow((result = [NSStringMask maskString:@"123" withPattern:pattern]), @"[no throw] empty mask formatting valid string");
    STAssertNil(result, [NSString stringWithFormat:@"[%@]", result]);
}

@end
