//
//  WaypointLibrary.m
//  lab9TableViews
//
//  @author: Brandon Espana mailto:biespana@asu.edu
//  @Version: March 30, 2015
//  Copyright (c) 2015 Brandon Espana.
//  The professor and TA have the right to build and evaluate this software package

#import "WaypointLibrary.h"
@interface WaypointLibrary()

@property (strong,nonatomic) NSMutableArray* waypoints;
@end

@implementation WaypointLibrary
- (id)initWithArray:(NSMutableArray *)initialWaypoints{
    //NSLog(@"Inside outside init");
    self = [super init];
    if(self){
        self.waypoints = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < initialWaypoints.count; i++){
            [self.waypoints addObject:initialWaypoints[i]];
        }
    }
    return self;
}

-(void) addWaypoint:(Waypoint*)waypoint{
    [self.waypoints addObject:waypoint];
}

-(BOOL) removeWaypointNamed:(NSString*) wpName {
    BOOL removed = FALSE;
    for(int i = 0; i < self.waypoints.count; i++){
        Waypoint* currentWP = [self.waypoints objectAtIndex:i];
        NSString* currentWPName = currentWP.name;
        if([currentWPName isEqualToString:wpName]){
            [self.waypoints removeObjectAtIndex:i];
            NSLog(@"Removed this waypoint: %@",currentWPName);
            removed = TRUE;
            break;
        }
    }
    return removed;
}

-(Waypoint*) getWaypointNamed:(NSString*) wpName {
    for(int i = 0; i < self.waypoints.count; i++){
        Waypoint* currentWP = [self.waypoints objectAtIndex:i];
        NSString* currentWPName = currentWP.name;
        if([currentWPName isEqualToString:wpName]){
            return currentWP;
            
        }
    }
    return nil;
}

-(NSArray*) getNames{
    NSMutableArray* wpNames = [[NSMutableArray alloc] init];
    NSArray* names = [[NSArray alloc]init];
    for(int i = 0; i < self.waypoints.count; i++){
        Waypoint* currentWP = [self.waypoints objectAtIndex:i];
        NSString* currentWPName = currentWP.name;
        [wpNames addObject:currentWPName];
    }
    names = [wpNames copy];
    return names;
}

-(NSArray*) getCategories{
    NSMutableArray* growingList = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < self.waypoints.count; i++){
        Waypoint* currentWP = [self.waypoints objectAtIndex:i];
        NSString* currentCategory = currentWP.category;
        NSInteger index = [growingList indexOfObject:currentCategory];
        
        if (index == NSNotFound) {
            [growingList addObject:currentCategory];
        }
    }
    
    NSArray* categories = [[NSArray alloc]init];
    categories = [growingList copy];
    //NSLog([NSString stringWithFormat:@"Category count: %lu",(unsigned long)[categories count]]);
    return categories;
}

-(NSArray*) getWaypointsInCategory:(NSString *)categoryName{
    NSMutableArray* growingList = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < self.waypoints.count; i++){
        Waypoint* currentWP = [self.waypoints objectAtIndex:i];
        if([currentWP.category isEqualToString:categoryName]){
            [growingList addObject:currentWP];
        }
    }
    
    NSArray* waypointsInCategory = [[NSArray alloc]init];
    waypointsInCategory = [growingList copy];
    //NSLog([NSString stringWithFormat:@"Waypoint in Category count: %lu",(unsigned long)[waypointsInCategory count]]);
    return waypointsInCategory;
}



@end
