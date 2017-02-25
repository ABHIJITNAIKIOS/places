//
//  ViewController.m
//  googlemaps
//
//  Created by Felix-ITS 004 on 12/02/17.
//  Copyright © 2017 felix. All rights reserved.
//

#import "ViewController.h"
#import "newTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager =[[CLLocationManager alloc]init];
    [manager requestAlwaysAuthorization] ;
    [manager requestWhenInUseAuthorization];
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    manager.distanceFilter = kCLDistanceFilterNone;
    manager.delegate = self;
    [manager startUpdatingLocation];
    NSLog(@"%f", manager.location.coordinate.longitude);
    NSLog(@"%f", manager.location.coordinate.latitude);
    [self paresplist];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)paresplist{
    
    
    NSBundle *mainbundle = [NSBundle mainBundle];
    
    NSString *str =[mainbundle pathForResource:@"Property List" ofType:@"plist"];
    
   
    
     arr =[[NSArray alloc]initWithContentsOfFile:str];
    NSLog(@"%@", arr);
    
    if(arr.count)
    {
        [locationtable reloadData];
     
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arr.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    newTableViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"newTableViewController"];
    obj.strType = [arr objectAtIndex:indexPath.row];
    obj.latitude = manager.location.coordinate.latitude;
    obj.longitude = manager.location.coordinate.longitude;

    [self.navigationController pushViewController:obj animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
