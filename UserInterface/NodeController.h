//
//  NodeController.h
//  TrailTracker
//
//  Created by Andrew Johnson on 7/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BurnDataObject.h"
@class ASIHTTPRequest;

@protocol NodeFetchDelegate<NSObject>
- (void) requestDone;
@end


@interface NodeController : NSObject  {
  id<NodeFetchDelegate> delegate;
}

- (id) init;
- (void) getNodes;
- (void) getNodes:(NSString*) url;
- (void) getNodesFromJson:(NSObject*) jsonNodes;
- (void) requestDone:(ASIHTTPRequest *)request;
- (void) requestWentWrong:(ASIHTTPRequest *)request;
- (NSString*) nullStringOrString:(NSString*)str;
- (NSArray*) getNamesFromDicts:(NSArray*)dicts;
- (NSArray*)getObjectsForType:(NSString*)type 
                        names:(NSArray*)names
                    upperLeft:(CLLocationCoordinate2D)upperLeft 
                   lowerRight:(CLLocationCoordinate2D)lowerRight;
- (void) createAndUpdate:(NSArray*)knownObjects 
             withObjects:(NSArray*)objects 
            forClassName:(NSString*)className 
								fromFile:(BOOL)fromFile;
- (NSObject*) nullOrObject:(NSObject*)str;
- (NSDictionary*) getLocationDictionary:(NSDictionary*) dict;
- (void) saveObjects:(NSArray*)objects;
- (void) updateObject:(id)object withDict:(NSDictionary*)dict;
- (void) updateObjectFromFile:(id<BurnDataObject>)object withDict:(NSDictionary*)dict;
  
@property (nonatomic, retain) NSArray *nodes;
@property (nonatomic, assign) id<NodeFetchDelegate> delegate;

@end
