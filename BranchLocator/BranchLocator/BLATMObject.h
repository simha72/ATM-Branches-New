//
//  BLATMObject.h
//  BranchLocator
//
//  Created by Nuvvala on 8/12/15.
//  Copyright (c) 2015 Narasimha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLATMObject : NSObject
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSNumber *noOfAtms;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *distance;
@property (nonatomic,strong) NSString *label;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *zipCode;


-(instancetype)initWithData:(NSDictionary *)data;
@end
