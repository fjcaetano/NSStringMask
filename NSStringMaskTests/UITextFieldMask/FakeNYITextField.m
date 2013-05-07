//
//  FakeNYITextField.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/6/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import "FakeNYITextField.h"

@implementation FakeNYITextField
{
    NSRange selectionRange;
}

// init
- (id)init
{
    self = [super init];
    if (self)
    {
        self.text = @"";
    }
    return self;
}

@end
