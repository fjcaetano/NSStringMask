//
//  UITextFieldMaskDelegate.h
//  Pods
//
//  Created by Alessandro Nakamuta on 20/10/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "NSStringMask.h"

@interface UITextFieldMaskDynamicDelegate : NSObject <UITextFieldDelegate>

#pragma mark - Properties
/// @name Properties

/** The mask to be applied to the text field.
 */
@property (nonatomic, strong) NSStringMask *mask;
@property (nonatomic, strong) id<UITextFieldDelegate> realDelegate;


@end
