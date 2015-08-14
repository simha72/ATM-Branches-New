//
//  DetailedViewController.h
//  BranchLocator
//
//  Created by Nuvvala on 8/12/15.
//  Copyright (c) 2015 Narasimha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLATMObject.h"

@interface DetailedViewController : UIViewController


@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *bankNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;




@property(nonatomic,strong) NSString *namee;
@property(nonatomic,strong) NSString *bankLabel;
@property(nonatomic,strong) NSString *address;


@end
