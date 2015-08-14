//
//  SimpleAnnotation.m
//  MapView
//
//  Created by Nuvvala on 8/12/15.
//  Copyright (c) 2015 Narasimha. All rights reserved.
//

#import "SimpleAnnotation.h"

@implementation SimpleAnnotation


- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle
                  subTitle:(NSString *)paramSubTitle{
    self = [super init];
    if (self != nil){
        self.coordinate = paramCoordinates;
        _title = paramTitle;
        _subTitle = paramSubTitle;
    }
    return(self);

}
@end
