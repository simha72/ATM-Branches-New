//
//  ViewController.m
//  BranchLocator
//
//  Created by Nuvvala on 8/12/15.
//  Copyright (c) 2015 Narasimha. All rights reserved.
//

#import "ViewController.h"
#import "BLLocationManager.h"
#import "BLATMObject.h"
#import "DetailedViewController.h"

#define METERS_PER_MILE 1609.344


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[BLLocationManager sharedManager] getATMsNearTomMeWithDelegate:self];
    
    self.mapView = [[MKMapView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.view addSubview:self.mapView];
    self.mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"ATM Locator";
}
-(void)listOfAtms:(NSArray *)array
{
    _atmsArray = [NSArray arrayWithArray:array];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([BLLocationManager sharedManager].currentLocation.coordinate, 1*METERS_PER_MILE, 1*METERS_PER_MILE);
    
    NSLog(@"the loc details:%f,,,%f",[BLLocationManager sharedManager].currentLocation.coordinate.latitude,[BLLocationManager sharedManager].currentLocation.coordinate.longitude);
    
    [_mapView showsUserLocation];
    
    MKCoordinateSpan span;
    span.latitudeDelta =  0.2;
    span.longitudeDelta = 0.2;
    viewRegion.span = span;
    [_mapView setRegion:viewRegion animated:YES];
    
    
    for (BLATMObject *atmObject in array) {
        double lat = [atmObject.latitude doubleValue];
        double longitude = [atmObject.longitude doubleValue];
        
        CLLocationCoordinate2D coordinate;
        coordinate.longitude= longitude;
        coordinate.latitude = lat;
        
        [self addPinWithTitle:atmObject.name subTitle:atmObject.address andCoordinate:coordinate];
        
    }
    
    

}


-(void)addPinWithTitle:(NSString *)title subTitle:(NSString *)subTitle andCoordinate:(CLLocationCoordinate2D )coordinate
{
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
    
    
    mapPin.title = title;
    mapPin.subtitle = subTitle;
    mapPin.coordinate = coordinate;
    
    [self.mapView addAnnotation:mapPin];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id < MKAnnotation >)annotation
{
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MKPointAnnotation *annotation = view.annotation;

    
    NSPredicate *checkPredicate = [NSPredicate predicateWithFormat:@"name == %@",annotation.title];
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:_atmsArray];
    tempArr = (NSMutableArray*)[tempArr filteredArrayUsingPredicate:checkPredicate];
    if ([tempArr count]>0) {
        
        BLATMObject *atmObject = [tempArr lastObject];
        [self performSegueWithIdentifier:@"DetailsIphone" sender:atmObject];

    }
    

}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    BLATMObject *atmObject = (BLATMObject *)sender;
    
    DetailedViewController *detailedController = (DetailedViewController *)segue.destinationViewController;
    
    detailedController.namee = atmObject.name;
    detailedController.bankLabel = atmObject.bankName;
    detailedController.address = atmObject.state;
    
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
