//
//  GPXLink.h
//  GPX Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "GPXElement.h"

NS_ASSUME_NONNULL_BEGIN

/** A link to an external resource (Web page, digital photo, video clip, etc) with additional information.
 */
@interface GPXLink : GPXElement

/// ---------------------------------
/// @name Accessing Properties
/// ---------------------------------

/** Text of hyperlink. */
@property (strong, nonatomic, nullable) NSString *text;

/** Mime type of content (image/jpeg) */
@property (strong, nonatomic, nullable) NSString *mimetype;

/** URL of hyperlink. */
@property (strong, nonatomic, nullable) NSString *href;

/// ---------------------------------
/// @name Create Link
/// ---------------------------------

/** Creates and returns a new link element.
 @param href URL of hyperlink
 @return A newly created link element.
 */
+ (GPXLink *)linkWithHref:(NSString *)href;

@end

NS_ASSUME_NONNULL_END
