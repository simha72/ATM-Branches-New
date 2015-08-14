//
//  ViewController.h
//  BranchLocator
//
//  Created by Nuvvala on 8/12/15.
//  Copyright (c) 2015 Narasimha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface ViewController : UIViewController<MKMapViewDelegate>
{

}

@property (nonatomic, strong)IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSArray *atmsArray;

@end

