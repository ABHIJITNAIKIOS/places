//
//  newTableViewController.m
//  googlemaps
//
//  Created by Felix-ITS 004 on 12/02/17.
//  Copyright © 2017 felix. All rights reserved.
//

#import "newTableViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface newTableViewController (){
    NSDictionary *dict;
    GMSMapView *mapView;
}

@end

@implementation newTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self googlemap];
    [self getResponse];
    // Do any additional setup after loading the view.
}
-(void)getResponse{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=500&types=%@&name=harbour&key=AIzaSyAfjlzR9827ekR_Lva9n_fSjf11pn3swSY",_latitude,_longitude,_strType]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *datatask = [session dataTaskWithURL:url completionHandler:^(NSData *data,NSURLResponse *responce,NSError *error){
        if (!error) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",dict);
            [self markerMethod];
            // [self performSelector:@selector(markerMethod) withObject:nil afterDelay:0.5];
        
        }
    }];
    [datatask resume];
}

-(void)googlemap{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_latitude
                                                            longitude:_longitude
                                                                 zoom:20];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(_latitude, _longitude);
    marker.title = @"I M Here";
    marker.snippet = @"India";
    marker.map = mapView;

}

-(void)markerMethod{
    NSArray *array = [dict valueForKey:@"results"];
    for (int i = 0; i<[array count];i++ ) {
        NSDictionary *dicttemp = [array objectAtIndex:i];
        NSString *str = [dicttemp valueForKey:@"name"];
        NSDictionary *dictGeometry = [dicttemp valueForKey:@"geometry"];
        NSDictionary *location = [dictGeometry valueForKey:@"location"];
        NSLog(@"%f",[[location valueForKey:@"lat"] doubleValue]);
        NSLog(@"%f",[[location valueForKey:@"lng"] doubleValue]);
        NSLog(@"%@",str);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Your main thread code goes in here
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([[location valueForKey:@"lat"] doubleValue], [[location valueForKey:@"lng"] doubleValue]);
            marker.title = _strType;
            marker.snippet = str;
            marker.map = mapView;
        
        
        });
        
        
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
