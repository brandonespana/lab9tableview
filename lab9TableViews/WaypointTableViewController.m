//
//  WaypointTableViewController.m
//  lab9TableViews
//
//  @author: Brandon Espana mailto:biespana@asu.edu
//  @Version: March 30, 2015
//  Copyright (c) 2015 Brandon Espana.
//  The professor and TA have the right to build and evaluate this software package

#import "WaypointTableViewController.h"
#import "WaypointLibrary.h"
#import "ViewController.h"
#import "AddWaypointController.h"

//improt viewController because we'll use it's properties when preparing the segue

@interface WaypointTableViewController ()
@property(strong, nonatomic)WaypointLibrary* waypointLibrary;
@property (strong, nonatomic) IBOutlet UITableView *waypointTableView;
@end

@implementation WaypointTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"In viewDidLoad method");
    self.waypointTableView.dataSource = self;
    [self.waypointTableView reloadData];
    for (int i = 0; i < self.waypointLibrary.getNames.count;i++){
        
    }
    Waypoint * ny = [[Waypoint alloc] initWithLat:40.7127 lon:-74.0059 elevation:1000 name:@"New-York" address:@"123 NY Street" category:@"Cities"];
    Waypoint * asup = [[Waypoint alloc] initWithLat:33.3056 lon:-111.6788 elevation:2000 name:@"ASUP" address:@"4212 North ASU St" category:@"Campuses"];
    Waypoint * asub = [[Waypoint alloc] initWithLat:33.4235 lon:-111.9389 elevation:3000 name:@"ASUB" address:@"9889 West Ave" category:@"Campuses"];
    Waypoint * paris = [[Waypoint alloc] initWithLat:48.8567 lon:2.3508 elevation:4000 name:@"Paris" address:@"3212 East Street" category:@"Cities"];
    Waypoint * moscow = [[Waypoint alloc] initWithLat:55.75 lon:37.6167 elevation:5000 name:@"Moscow" address:@"1221 South Oak" category:@"Cities"];
    
    NSMutableArray* initialWaypoints = [[NSMutableArray alloc]initWithObjects:ny,asup,asub,paris,moscow, nil];
    
    //WaypointLibrary is initialized with 5 predefined waypoints.
    self.waypointLibrary = [[WaypointLibrary alloc]initWithArray:initialWaypoints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"memorywarning");
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"in numberofsections");
    // Return the number of sections.
    //NSLog(@"Inside numberOfSections method");
    return [self.waypointLibrary getCategories].count;
    //return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"in numberofrowsinsection");
   // NSLog(@"Inside numberOfRowsInSection method");
    // Return the number of rows in the section.
    //return 0;
    NSArray* categories = [self.waypointLibrary getCategories];
    NSString* sectionName = [categories objectAtIndex:section];
    NSArray* sectionWaypoints = [self.waypointLibrary getWaypointsInCategory:sectionName];
    
    return sectionWaypoints.count;
    
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSLog(@"in titleforheadersection");
    NSArray* categories = [self.waypointLibrary getCategories];
    NSString* sectionName = [categories objectAtIndex:section];
    return sectionName;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"in cellforrowatindex");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"waypointCell" forIndexPath:indexPath];
    if (cell == nil){
        NSLog(@"Cell is nil");
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"waypointCell"];
    }
    //[tableView reloadData];
    NSLog(@"Waypoint count in cellForRowIndexPath is: %lu",(unsigned long)self.waypointLibrary.getNames.count);
    NSArray* categories = [self.waypointLibrary getCategories];
    NSString* sectionName = [categories objectAtIndex:indexPath.section];
    NSArray* sectionWaypoints = [self.waypointLibrary getWaypointsInCategory:sectionName];
    Waypoint* cellWaypoint = [sectionWaypoints objectAtIndex:indexPath.row];
    cell.textLabel.text = cellWaypoint.name;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"in prepareforsegue");
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"detailWaypointSegue"]){
        
        NSIndexPath* indexPath = [self.waypointTableView indexPathForSelectedRow];
        NSArray* categories = [self.waypointLibrary getCategories];
        NSString* sectionName = [categories objectAtIndex:indexPath.section];
        NSArray* sectionWaypoints = [self.waypointLibrary getWaypointsInCategory:sectionName];
        Waypoint* selectedWaypoint = [sectionWaypoints objectAtIndex:indexPath.row];
        
        ViewController* theDestination = segue.destinationViewController;
        theDestination.selectedWaypoint = selectedWaypoint;
        theDestination.waypointLibrary = self.waypointLibrary;
        theDestination.theTableView = self.waypointTableView;
    }
    else if ([segue.identifier isEqualToString:@"addWaypointSegue"]){
        AddWaypointController* theDestination = segue.destinationViewController;
        theDestination.waypointLibrary = self.waypointLibrary;
        theDestination.theTable = self.waypointTableView;
    }
    
    
    
}












@end
