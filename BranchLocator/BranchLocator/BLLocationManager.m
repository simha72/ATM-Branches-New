//
//  BLLocationManager.m
//  BranchLocator
//
//  Created by Nuvvala on 8/12/15.
//  Copyright (c) 2015 Narasimha. All rights reserved.
//

#import "BLLocationManager.h"
#import "BLATMObject.h"


@implementation BLLocationManager

+ (instancetype)sharedManager
{
    static BLLocationManager *sharedManager = nil;
    static dispatch_once_t BLToken;
    dispatch_once(&BLToken, ^{
        sharedManager = [[BLLocationManager alloc] init];
    });
    return sharedManager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initializeLocationManager];
    }
    return self;
}

-(void)initializeLocationManager
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        
        if (_currentLocation == nil) {
            [_locationManager startUpdatingLocation];
        }
        else{
            [_locationManager stopUpdatingLocation];
        }
    }
}

- (void) getATMsNearTomMeWithDelegate:(id)delegate
{
    _delegate = delegate;
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    else
        [_locationManager startUpdatingLocation];
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    
    CLLocation *newLocation = [locations lastObject];
    
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    
    if (newLocation.horizontalAccuracy < 0) return;
    
    CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    double distance = [loc1 distanceFromLocation:loc2];
    
    
    if(distance > 20)
    {
        
    _currentLocation = newLocation;
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://m.chase.com/PSRWeb/location/list.action?lat=%f&lng=%f",_currentLocation.coordinate.latitude,_currentLocation.coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error = nil;
        
        if (!connectionError && data) {
            NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            NSArray *locations = responseJson[@"locations" ];
            
            if([locations isKindOfClass:[NSArray class]])
            {
                NSMutableArray *atmsArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dataDict in locations) {
                    BLATMObject *atmObject = [[BLATMObject alloc] initWithData:dataDict];
                    [atmsArray addObject:atmObject];
                }
                if (_delegate && [_delegate respondsToSelector:@selector(listOfAtms:)]) {
                    [_delegate listOfAtms:atmsArray];
                }
                
            }
        }

    }];
    }
    
    
}


@end
