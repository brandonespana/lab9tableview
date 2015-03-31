//
//  ViewController.m
//  lab9TableViews
//
//  @author: Brandon Espana mailto:biespana@asu.edu
//  @Version: March 30, 2015
//  Copyright (c) 2015 Brandon Espana.
//  The professor and TA have the right to build and evaluate this software package

#import "ViewController.h"
#import "Waypoint.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *wpName;
@property (weak, nonatomic) IBOutlet UITextField *wpAddress;
@property (weak, nonatomic) IBOutlet UITextField *wpCategory;
@property (weak, nonatomic) IBOutlet UITextField *wpLat;
@property (weak, nonatomic) IBOutlet UITextField *wpLon;
@property (weak, nonatomic) IBOutlet UITextField *wpElevation;
@property (weak, nonatomic) IBOutlet UITextField *toTV;
@property (weak, nonatomic) IBOutlet UITextField *distTV;
@property (strong, nonatomic)UIPickerView *toPicker;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationTitle;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationTitle setTitle:self.selectedWaypoint.name];
    //[self.wpTitle setText:self.selectedWaypoint.name];
    [self.navigationTitle setTitle:self.selectedWaypoint.name];
    [self.wpAddress setText:self.selectedWaypoint.address];
    [self.wpCategory setText:self.selectedWaypoint.category];
    [self.wpLat setText:[NSString stringWithFormat:@"%lf",self.selectedWaypoint.lat]];
    [self.wpLon setText:[NSString stringWithFormat:@"%lf",self.selectedWaypoint.lon]];
    [self.wpElevation setText:[NSString stringWithFormat:@"%lf",self.selectedWaypoint.elevation]];
    
    self.toPicker = [[UIPickerView alloc]init];
    self.toPicker.delegate = self;
    self.toPicker.dataSource = self;
    self.toTV.inputView = self.toPicker;
    
    //self.wpName.delegate = self;
    self.wpAddress.delegate = self;
    self.wpCategory.delegate = self;
    self.wpLat.delegate = self;
    self.wpLon.delegate = self;
    self.wpElevation.delegate = self;
    
    self.wpLat.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.wpLon.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.wpElevation.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
}
- (IBAction)savedClicked:(id)sender {
    NSLog(@"Will save the edits");
    //Get all fields and create a new Waypoint
    double lat = [self.wpLat.text doubleValue];
    double lon = [self.wpLon.text doubleValue];
    double ele = [self.wpElevation.text doubleValue];
    NSString *address = self.wpAddress.text;
    NSString *category = self.wpCategory.text;
    
    Waypoint* newWaypoint = [[Waypoint alloc]initWithLat:lat lon:lon elevation:ele name:self.navigationTitle.title address:address category:category];
    
    //Remove the waypoint, and add the new one
    [self.waypointLibrary removeWaypointNamed:[self.navigationTitle title]];
    [self.waypointLibrary addWaypoint:newWaypoint];
    [self.theTableView reloadData];
    
    UIAlertView* saveAlert = [[UIAlertView alloc] initWithTitle:@"Changes saved" message:@"Your changes have been saved" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
    [saveAlert show];
    
    NSLog(@"Removed the selected waypoint, waypoint count: %lu",(unsigned long)self.waypointLibrary.getNames.count);
}
- (IBAction)removeClicked:(id)sender {
    NSString* nameToDelete = [self.navigationTitle title];
    [self.waypointLibrary removeWaypointNamed:nameToDelete];
    [self.theTableView reloadData];
    UIAlertView* removeAlert = [[UIAlertView alloc]initWithTitle:@"Waypoint Removed" message:@"The waypoint has been removed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
    [removeAlert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController  popViewControllerAnimated:YES];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString*) pickerView:(UIPickerView *) pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray* wpNames = [self.waypointLibrary getNames];
    NSString* ret = @"unknown";
    if(row < wpNames.count){
        ret = wpNames[row];
    }
    return ret;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.waypointLibrary getNames].count;
}

-(void) pickerView:(UIPickerView *) pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView == self.toPicker){
        //load the toTV with the name of the selected waypoint, calculate the Distance and Bearing and show it on the Dist text field
        [self.toTV resignFirstResponder];
        NSString* selectedItem = [self pickerView:pickerView titleForRow:row forComponent:component];
        NSString* fromWPName = [self.navigationTitle title];
        Waypoint* fromWaypoint = [self.waypointLibrary getWaypointNamed:fromWPName];
        Waypoint* toWaypoint = [self.waypointLibrary getWaypointNamed:selectedItem];
        double distanceTo = [fromWaypoint distanceGCTo:toWaypoint.lat lon:toWaypoint.lon scale:Statute];
        double bearingTo = [fromWaypoint bearingGCInitTo:toWaypoint.lat lon:toWaypoint.lon];
        [self.toTV setText:selectedItem];
        [self.distTV setText:[NSString stringWithFormat:@"%lf Bearing: %lf",distanceTo,bearingTo]];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//UITextField Delegate method
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.wpLat resignFirstResponder];
    [self.wpLon resignFirstResponder];
    [self.wpElevation resignFirstResponder];
    [self.distTV resignFirstResponder];
    [self.toTV resignFirstResponder];
    [self.wpAddress resignFirstResponder];
    [self.wpCategory resignFirstResponder];
    
}
@end
