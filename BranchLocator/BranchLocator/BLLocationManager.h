//
//  BLLocationManager.h
//  BranchLocator
//
//  Created by Nuvvala on 8/12/15.
//  Copyright (c) 2015 Narasimha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol BLLocationManagerDelegate <NSObject>

-(void)listOfAtms:(NSArray *)array;

@end

@interface BLLocationManager : NSObject<CLLocationManagerDelegate>
{
    

}
@property(nonatomic, assign) id <BLLocationManagerDelegate> delegate;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
+ (instancetype)sharedManager;
- (void) getATMsNearTomMeWithDelegate:(id)delegate;
@end
