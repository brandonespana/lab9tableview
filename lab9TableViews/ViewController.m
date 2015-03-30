//
//  ViewController.m
//  lab9TableViews
//
//  Created by biespana on 3/26/15.
//  Copyright (c) 2015 biespana. All rights reserved.
//

#import "ViewController.h"
#import "Waypoint.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *wpName;
@property (weak, nonatomic) IBOutlet UITextField *wpAddress;
@property (weak, nonatomic) IBOutlet UITextField *wpCategory;
@property (weak, nonatomic) IBOutlet UITextField *wpLat;
@property (weak, nonatomic) IBOutlet UITextField *wpLon;
@property (weak, nonatomic) IBOutlet UITextField *wpElevation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.wpName setText:self.selectedWaypoint.name];
    [self.wpAddress setText:self.selectedWaypoint.address];
    [self.wpCategory setText:self.selectedWaypoint.category];
    [self.wpLat setText:[NSString stringWithFormat:@"%lf",self.selectedWaypoint.lat]];
    [self.wpLon setText:[NSString stringWithFormat:@"%lf",self.selectedWaypoint.lon]];
    [self.wpElevation setText:[NSString stringWithFormat:@"%lf",self.selectedWaypoint.elevation]];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
