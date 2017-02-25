//
//  ViewController.h
//  googlemaps
//
//  Created by Felix-ITS 004 on 12/02/17.
//  Copyright © 2017 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>{
    
    NSArray *arr;
    
    CLLocationManager *manager;
   
    __weak IBOutlet UITableView *locationtable;
    
    
    
    
}


@end

