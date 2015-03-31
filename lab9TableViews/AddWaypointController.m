//
//  AddWaypointController.m
//  lab9TableViews
//
//  @author: Brandon Espana mailto:biespana@asu.edu
//  @Version: March 30, 2015
//  Copyright (c) 2015 Brandon Espana.
//  The professor and TA have the right to build and evaluate this software package

#import "AddWaypointController.h"

@interface AddWaypointController ()

@property (weak, nonatomic) IBOutlet UITextField *wpName;
@property (weak, nonatomic) IBOutlet UITextField *wpAddress;
@property (weak, nonatomic) IBOutlet UITextField *wpCategory;
@property (weak, nonatomic) IBOutlet UITextField *wpLat;
@property (weak, nonatomic) IBOutlet UITextField *wpLon;
@property (weak, nonatomic) IBOutlet UITextField *wpElevation;

@end

@implementation AddWaypointController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.wpAddress.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.wpLat.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.wpLon.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.wpElevation.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    self.wpAddress.delegate = self;
    self.wpName.delegate = self;
    self.wpCategory.delegate = self;
    self.wpLat.delegate = self;
    self.wpLon.delegate = self;
    self.wpElevation.delegate = self;
    
    
}
- (IBAction)doneClicked:(id)sender {
    NSString* name = [self.wpName text];
    NSString* address = [self.wpAddress text];
    NSString* category = [self.wpCategory text];
    double lat = [self.wpLat.text doubleValue];
    double lon = [self.wpLon.text doubleValue];
    double elevation = [self.wpElevation.text doubleValue];
    
    Waypoint* toAdd = [[Waypoint alloc]initWithLat:lat lon:lon elevation:elevation name:name address:address category:category];
    
    [self.waypointLibrary addWaypoint:toAdd];
    [self.theTable reloadData];
    
    UIAlertView* addAlert = [[UIAlertView alloc]initWithTitle:@"Waypoint Added" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
    [addAlert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//UITextField Delegate method
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.wpLat resignFirstResponder];
    [self.wpLon resignFirstResponder];
    [self.wpName resignFirstResponder];
    [self.wpAddress resignFirstResponder];
    [self.wpCategory resignFirstResponder];
    [self.wpElevation resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
