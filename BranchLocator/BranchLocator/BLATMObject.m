//
//  BLATMObject.m
//  BranchLocator
//
//  Created by Nuvvala on 8/12/15.
//  Copyright (c) 2015 Narasimha. All rights reserved.
//

#import "BLATMObject.h"

@implementation BLATMObject

-(instancetype)initWithData:(NSDictionary *)data
{
    self = [ super init];
    if (self) {
        _address = data[@"address"];
        _noOfAtms =  data[@"atms"];
        _bankName =data[@"bank"];
        _city = data[@"city"];
        _distance = data[@"distance"];
        _label = data[@"label"];
        _latitude = data[@"lat"];
        _longitude = data[@"lng"];
        _name = data[@"name"];
        _phone =  data[@"phone"];
        _state = data[@"state"];
        _zipCode = data[@"zip"];

    }
    return self;
}


@end
