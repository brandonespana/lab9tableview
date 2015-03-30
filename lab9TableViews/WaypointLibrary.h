//
//  WaypointLibrary.h
//  lab9TableViews
//
//  Created by biespana on 3/30/15.
//  @author: Brandon Espana mailto:biespana@asu.edu
//  The professor and the TA have the right to build and evalute this software package
//  Copyright (c) 2015 Brandon Espana
//

#import <Foundation/Foundation.h>
#import "Waypoint.h"
@interface WaypointLibrary : NSObject

-(id)initWithArray:(NSMutableArray*) waypointsArray;
-(void) addWaypoint:(Waypoint*) waypoint;
-(BOOL) removeWaypointNamed:(NSString*)wpName;
-(Waypoint*) getWaypointNamed:(NSString*)wpName;
-(NSArray*) getNames;
-(NSArray*) getCategories;
-(NSArray*) getWaypointsInCategory:(NSString*)categoryName;

@end