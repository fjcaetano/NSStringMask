//
//  NSStringMask.m
//  NSStringMask
//
//  Created by Flávio Caetano on 4/17/13.
//  Copyright (c) 2013 FlavioCaetano. All rights reserved.
//

#import "NSStringMask.h"

/** Category declaring private ivars and methods for the NSStringMask
 */
@interface NSStringMask ()
{
    // The regex to be applied when formatting.
    NSRegularExpression *_regex;
}

/** Recursive method to format the given string based on the given pattern and character, returning the new regex pattern to be used on NSMutableString's replaceOccurrencesOfString:withString:options:range: and editing the pattern to match this method's replacement string.
 
 @warning This is a recursive method! Its external call must have `i = 1`, `range = (0, string.length)`, `mutableResult = &([NSMutableString new])`:
 
    NSMutableString *formattedString = [NSMutableString new];
 
    NSString *newPattern = [self patternStep:&pattern onString:string iterCount:1 resultFetcher:&formattedString range:NSMakeRange(0, string.length) placeholder:self.placeholder];
 
 @param pattern A pointer to the pattern. It will be edited to replace the first regex group with the matching result based on the iteration i.
 @param string The NSString to be formatted.
 @param i The iteration count. Must start at 1.
 @param mutableResult The filtered string based on the groups matched by pattern.
 @param range The range in which the replacement must start.
 @param placeholder The placeholder to fill missing characters to format the string.
 
 @returns
 */
- (NSString *)patternStep:(NSMutableString **)pattern onString:(NSString *)string iterCount:(long)i resultFetcher:(NSMutableString **)mutableResult range:(NSRange)range placeholder:(NSString *)placeholder;

/** Returns the first regex group and replaces it in the pattern with the current i.
 
 I.e. pattern = @"(\d)-(\w+)", i = 2. On completion, the method will return @"\d" and pattern will be @"$2-(\w+)".
 
 @param pattern A pointer to the pattern. It will be edited to replace the first regex group with the matching result based on the iteration i.
 @param i The current iteration to be placed over the first regex group.
 
 @return The first regex group found in pattern.
 */
- (NSString *)getStepPattern:(NSMutableString **)pattern iter:(long)i;

// _regex setter
- (void)setRegex:(NSRegularExpression *)regex;

// _regex getter
- (NSRegularExpression *)regex;

@end

@implementation NSStringMask

// Initiates the instance with a given pattern.
- (id)initWithPattern:(NSString *)pattern
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    self = (error ? nil : [self initWithRegex:regex]);
    return self;
}

// Initiates the instance with a given NSRegularExpression.
- (id)initWithRegex:(NSRegularExpression *)regex
{
    if (regex == nil || regex.numberOfCaptureGroups == 0) return nil;
    
    self = [self init];
    
    if (self)
    {
        [self setRegex:regex];
    }
    
    return self;
}

#pragma mark - Class Initializers

// Returns an NSStringMask instance set with the given NSRegularExpression.
+ (id)maskWithRegex:(NSRegularExpression *)regex
{
    return [[NSStringMask alloc] initWithRegex:regex];
}

// Returns a NSStringMask instance set with the given pattern.
+ (id)maskWithPattern:(NSString *)pattern
{
    return [[NSStringMask alloc] initWithPattern:pattern];
}

#pragma mark - Class Methods

// Formats a string based on the given regular expression.
+ (NSString *)maskString:(NSString *)string withRegex:(NSRegularExpression *)regex
{
    return [NSStringMask maskString:string withRegex:regex placeholder:nil];
}

// Formats a string based on the given regular expression filling missing characters with the given placeholder.
+ (NSString *)maskString:(NSString *)string withRegex:(NSRegularExpression *)regex placeholder:(NSString *)placeholder
{
    NSStringMask *mask = [NSStringMask maskWithRegex:regex];
    mask.placeholder = placeholder;
    
    return [mask format:string];
}

// Formats a string based on the given regular expression pattern.
+(NSString *)maskString:(NSString *)string withPattern:(NSString *)pattern
{
    return [NSStringMask maskString:string withPattern:pattern placeholder:nil];
}

// Formats a string based on the given regular expression pattern filling missing characters with the given placeholder.
+(NSString *)maskString:(NSString *)string withPattern:(NSString *)pattern placeholder:(NSString *)placeholder
{
    if (! pattern) return nil;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    return [NSStringMask maskString:string withRegex:regex placeholder:placeholder];
}

#pragma mark - Instance Methods

// Formats the given string based on the regex set on the instance.
- (NSString *)format:(NSString *)string
{
    if (string == nil || ! _regex) return nil;
    
    NSMutableString *pattern = [NSMutableString stringWithString:_regex.pattern];
    NSMutableString *formattedString = [NSMutableString new];
    
    NSString *newPattern = [self patternStep:&pattern onString:string iterCount:1 resultFetcher:&formattedString range:NSMakeRange(0, string.length) placeholder:self.placeholder];
    
    // Replacing the occurrences newPattern with the results of pattern on the var formattedString
    [formattedString replaceOccurrencesOfString:newPattern
                                     withString:pattern
                                        options:NSRegularExpressionSearch
                                          range:NSMakeRange(0, formattedString.length)];
    
    return [formattedString copy];
}

#pragma mark - Properties

// A placeholder to be used to fill an incomplete string.
- (void)setPlaceholder:(NSString *)placeholder
{
    // Empty placeholder (@"")
    if (placeholder != nil && placeholder.length == 0)
    {
        placeholder = nil;
    }
    
    _placeholder = placeholder;
}

#pragma mark - Private Methods

// Recursive method to format the given string based on the given pattern and placeholder, returning the new regex pattern to be used on NSMutableString's replaceOccurrencesOfString:withString:options:range: and editing the pattern to match this method's replacement string.
- (NSString *)patternStep:(NSMutableString **)pattern onString:(NSString *)string iterCount:(long)i resultFetcher:(NSMutableString **)mutableResult range:(NSRange)range placeholder:(NSString *)placeholder
{
    // Get the first group on the pattern and replace it with $i
    NSString *firstGroupPattern = [self getStepPattern:pattern iter:i];
    
    // If there's no group on the pattern, end the recursion.
    if (! firstGroupPattern) return @"";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern options:NSMatchingWithoutAnchoringBounds error:&error];
    
    NSTextCheckingResult *result = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];
    long num = 0;
    
    // If no result, tries the possibility of the string being shorted than expected.
    if ((! result || result.range.location == NSNotFound))
    {
        // Gets the expected repetition for the current group
        NSRegularExpression *numRepetEx = [NSRegularExpression regularExpressionWithPattern:@"\\{(\\d+)?(?:,(\\d+)?)?\\}" options:NSMatchingWithoutAnchoringBounds error:&error];
        NSTextCheckingResult *numRep = [numRepetEx firstMatchInString:firstGroupPattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, firstGroupPattern.length)];
        NSRange numRange = [numRep rangeAtIndex:2];
        if (numRange.location == NSNotFound)
        {
            numRange = [numRep rangeAtIndex:1];
        }
        
        num = [firstGroupPattern substringWithRange:numRange].integerValue;
        
        // Replaces the expected repetition on the group pattern with "+".
        firstGroupPattern = [firstGroupPattern stringByReplacingCharactersInRange:numRep.range withString:@"+"];
        
        // Tries to match the new pattern on the string.
        regex = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern options:NSMatchingWithoutAnchoringBounds error:&error];
        result = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];
    }
    
    // The matching on the string
    NSString *stringMatched = [string substringWithRange:result.range];
    [*mutableResult appendString:stringMatched];
    
    if (num > 0 && placeholder)
    {
        // Has a placeholder but couldn't match the expected repetition, but matched when repetition was replaced by "+"
        // Then, it'll complete the missing characters with the placeholder.
        NSString *placeholderRepetition = [@"" stringByPaddingToLength:num-stringMatched.length withString:placeholder startingAtIndex:0];
        [*mutableResult appendString:placeholderRepetition];
        
        // Adjusts the group pattern to also accept the placeholder.
        firstGroupPattern = [NSString stringWithFormat:@"[%@%@]{%ld}", firstGroupPattern, placeholder, num];
    }
    
    if (result)
    {
        // Adjusts the range to advance in the string.
        range.location = result.range.location + result.range.length;
        range.length = string.length - range.location;
    }
    
    return [NSString stringWithFormat:@"(%@)%@", firstGroupPattern, [self patternStep:pattern onString:string iterCount:++i resultFetcher:mutableResult range:range placeholder:placeholder]];
}

// Returns the first regex group and replaces it in the pattern with the current i.
- (NSString *)getStepPattern:(NSMutableString **)pattern iter:(long)i
{
    NSError *error;
    
    // Extracts the content of parentheses if it's not preceded by slash.
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)\\((.*?)(?<!\\\\)\\)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *checkingResult = [regex firstMatchInString:*pattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, (*pattern).length)];
    if (! checkingResult || checkingResult.range.location == NSNotFound) return nil;
    
    NSString *result = [*pattern substringWithRange:[checkingResult rangeAtIndex:1]];
    
    // Replaces the current group with $i.
    [*pattern replaceCharactersInRange:checkingResult.range withString:[NSString stringWithFormat:@"$%ld", i]];
    
    return result;
}

// _regex setter
- (void)setRegex:(NSRegularExpression *)regex
{
    _regex = regex;
}

// _regex setter
- (NSRegularExpression *)regex
{
    return _regex;
}

@end
