//
//  GPXPerson.h
//  GPX Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "GPXElement.h"

NS_ASSUME_NONNULL_BEGIN

@class GPXEmail;
@class GPXLink;

/** A person or organization.
 */
@interface GPXPerson : GPXElement

/// ---------------------------------
/// @name Accessing Properties
/// ---------------------------------

/** Name of person or organization. */
@property (strong, nonatomic, nullable) NSString *name;

/** Email address. */
@property (strong, nonatomic, nullable) GPXEmail *email;

/** Link to Web site or other external information about person. */
@property (strong, nonatomic, nullable) GPXLink *link;

@end
NS_ASSUME_NONNULL_END
