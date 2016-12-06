//
//  GPXMetadata.h
//  GPX Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "GPXElement.h"

NS_ASSUME_NONNULL_BEGIN

@class GPXAuthor;
@class GPXCopyright;
@class GPXLink;
@class GPXBounds;
@class GPXExtensions;

/** Information about the GPX file, author, and copyright restrictions goes in the metadata section. 
    Providing rich, meaningful information about your GPX files allows others to search for and use your GPS data.
 */
@interface GPXMetadata : GPXElement

/// ---------------------------------
/// @name Accessing Properties
/// ---------------------------------

/** The name of the GPX file. */
@property (strong, nonatomic, nullable) NSString *name;

/** A description of the contents of the GPX file. */
@property (strong, nonatomic, nullable) NSString *desc;

/** The person or organization who created the GPX file. */
@property (strong, nonatomic, nullable) GPXAuthor *author;

/** Copyright and license information governing use of the file. */
@property (strong, nonatomic, nullable) GPXCopyright *copyright;

/** URLs associated with the location described in the file. */
@property (strong, nonatomic, nullable) GPXLink *link;

/** The creation date of the file. */
@property (strong, nonatomic, nullable) NSDate *time;

/** Keywords associated with the file. Search engines or databases can use this information to classify the data. */
@property (strong, nonatomic, nullable) NSString *keyword;

/** Minimum and maximum coordinates which describe the extent of the coordinates in the file. */
@property (strong, nonatomic, nullable) GPXBounds *bounds;

/** You can add extend GPX by adding your own elements from another schema here. */
@property (strong, nonatomic, nullable) GPXExtensions *extensions;

@end

NS_ASSUME_NONNULL_END
