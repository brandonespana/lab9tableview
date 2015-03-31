//
//  AddWaypointController.h
//  lab9TableViews
//
//  @author: Brandon Espana mailto:biespana@asu.edu
//  @Version: March 30, 2015
//  Copyright (c) 2015 Brandon Espana.
//  The professor and TA have the right to build and evaluate this software package

#import <UIKit/UIKit.h>
#import "Waypoint.h"
#import "WaypointLibrary.h"

@interface AddWaypointController : UIViewController <UITextFieldDelegate>
@property(strong,nonatomic)UITableView *theTable;
@property(strong,nonatomic)WaypointLibrary* waypointLibrary;
@end
