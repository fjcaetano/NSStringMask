//
//  FakeTextField.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import "FakeTextField.h"

@implementation FakeTextField
{
    NSRange selectionRange;
}

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
