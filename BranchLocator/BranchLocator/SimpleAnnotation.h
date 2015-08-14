//
//  SimpleAnnotation.h
//  MapView
//
//  Created by Nuvvala on 8/12/15.
//  Copyright (c) 2015 Narasimha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SimpleAnnotation : NSObject<MKAnnotation>

@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,copy,readonly) NSString  *title;
@property(nonatomic,copy,readonly) NSString  *subTitle;

- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle
                  subTitle:(NSString *)paramSubTitle;

@end
