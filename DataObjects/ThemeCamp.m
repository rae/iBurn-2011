// 
//  ThemeCamp.m
//  iBurn
//
//  Created by Anna Hentzel on 8/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ThemeCamp.h"
#import "iBurnAppDelegate.h"
#import "MyCLController.h"
#import <CoreLocation/CoreLocation.h>

#import "Favorite.h"

@implementation ThemeCamp 

@dynamic zoom;
@dynamic longitude;
@dynamic url;
@dynamic latitude;
@dynamic desc;
@dynamic location;
@dynamic bm_id;
@dynamic year;
@dynamic name;
@dynamic contactEmail;
@dynamic Favorite;
@dynamic simpleName;
@dynamic playaLocation;

- (void)awakeFromFetch {
  geolocation = nil;
}


+ (NSCharacterSet*) getNonAlphaNumericCharacterSet {
  static NSCharacterSet* cs;
  if (!cs) {
    cs = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    cs = [cs retain];
  }
  return cs;
}


+ (NSString*) createSimpleName:(NSString*) name {
  NSString* simpleName = [[name componentsSeparatedByCharactersInSet:[ThemeCamp getNonAlphaNumericCharacterSet]] componentsJoinedByString:@""];
  
  return [simpleName lowercaseString];

}

+ (ThemeCamp*) campForSimpleName:(NSString*) sName {
  
  
  NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	iBurnAppDelegate *t = (iBurnAppDelegate *)[[UIApplication sharedApplication] delegate];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"ThemeCamp" inManagedObjectContext:[t managedObjectContext]];
  [fetchRequest setEntity:entity];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"simpleName = %@", sName];
  [fetchRequest setPredicate:predicate];	
  NSError *error;
  NSArray *objects = [[t managedObjectContext] executeFetchRequest:fetchRequest error:&error];
  	
  if ([objects count] > 0) {
    return [objects objectAtIndex:0];
  }
  return nil;

}

- (void) dealloc {
  [geolocation release];
  geolocation = nil;
  [super dealloc];
}

- (CLLocation *)geolocation {
  if (!geolocation) {
    geolocation = [[CLLocation alloc] initWithLatitude:[self.latitude floatValue] 
                                          longitude:[self.longitude floatValue]];
  }
  return geolocation;
}

- (float) distanceAway {
	// prevent crash at start-up sometimes
  CLLocationManager* locationManager = [[MyCLController sharedInstance] locationManager];
  
  if (!locationManager.location) return 0;
  
  if (geolocation && distanceAway > 0 && lastLatitude == locationManager.location.coordinate.latitude) {
    return distanceAway;
  }
  
  lastLatitude = locationManager.location.coordinate.latitude;
  distanceAway = [locationManager.location distanceFromLocation:[self geolocation]];
  return distanceAway;
}
@end
