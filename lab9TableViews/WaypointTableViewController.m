//
//  WaypointTableViewController.m
//  lab9TableViews
//
//  Created by biespana on 3/30/15.
//  Copyright (c) 2015 biespana. All rights reserved.
//

#import "WaypointTableViewController.h"
#import "WaypointLibrary.h"
#import "ViewController.h"

//improt viewController because we'll use it's properties when preparing the segue

@interface WaypointTableViewController ()
@property(strong, nonatomic)WaypointLibrary* waypointLibrary;
@property (strong, nonatomic) IBOutlet UITableView *waypointTableView;
@end

@implementation WaypointTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.waypointTableView.dataSource = self;
    //self.waypointTableView.delegate = self;
    
    
    Waypoint * ny = [[Waypoint alloc] initWithLat:40.7127 lon:-74.0059 elevation:1000 name:@"New-York" address:@"123 NY Street" category:@"Cities"];
    Waypoint * asup = [[Waypoint alloc] initWithLat:33.3056 lon:-111.6788 elevation:2000 name:@"ASUP" address:@"4212 North ASU St" category:@"Campuses"];
    Waypoint * asub = [[Waypoint alloc] initWithLat:33.4235 lon:-111.9389 elevation:3000 name:@"ASUB" address:@"9889 West Ave" category:@"Campuses"];
    Waypoint * paris = [[Waypoint alloc] initWithLat:48.8567 lon:2.3508 elevation:4000 name:@"Paris" address:@"3212 East Street" category:@"Cities"];
    Waypoint * moscow = [[Waypoint alloc] initWithLat:55.75 lon:37.6167 elevation:5000 name:@"Moscow" address:@"1221 South Oak" category:@"Cities"];
    
    NSMutableArray* initialWaypoints = [[NSMutableArray alloc]initWithObjects:ny,asup,asub,paris,moscow, nil];
    
    //WaypointLibrary is initialized with 5 predefined waypoints.
    self.waypointLibrary = [[WaypointLibrary alloc]initWithArray:initialWaypoints];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    //NSLog(@"Inside numberOfSections method");
    return [self.waypointLibrary getCategories].count;
    //return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // NSLog(@"Inside numberOfRowsInSection method");
    // Return the number of rows in the section.
    //return 0;
    NSArray* categories = [self.waypointLibrary getCategories];
    NSString* sectionName = [categories objectAtIndex:section];
    NSArray* sectionWaypoints = [self.waypointLibrary getWaypointsInCategory:sectionName];
    
    return sectionWaypoints.count;
    
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray* categories = [self.waypointLibrary getCategories];
    NSString* sectionName = [categories objectAtIndex:section];
    return sectionName;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"waypointCell" forIndexPath:indexPath];
    
    NSArray* categories = [self.waypointLibrary getCategories];
    NSString* sectionName = [categories objectAtIndex:indexPath.section];
    NSArray* sectionWaypoints = [self.waypointLibrary getWaypointsInCategory:sectionName];
    Waypoint* cellWaypoint = [sectionWaypoints objectAtIndex:indexPath.row];
    cell.textLabel.text = cellWaypoint.name;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //UIViewController* destination = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"detailWaypointSegue"]){
        
        NSIndexPath* indexPath = [self.waypointTableView indexPathForSelectedRow];
        NSArray* categories = [self.waypointLibrary getCategories];
        NSString* sectionName = [categories objectAtIndex:indexPath.section];
        NSArray* sectionWaypoints = [self.waypointLibrary getWaypointsInCategory:sectionName];
        Waypoint* selectedWaypoint = [sectionWaypoints objectAtIndex:indexPath.row];
        //NSString*  waypointName = selectedWaypoint.name;
        
        ViewController* theDestination = segue.destinationViewController;
        //ViewController* destination = [navigator];
        //NSLog([NSString stringWithFormat:@"Clicked on this waypoint: %@", waypointName]);
        theDestination.selectedWaypoint = selectedWaypoint;
    }
    
    
}












@end
