//
//  COMapViewController.m
//  CodeOwlApp
//
//  Created by Ayuna Vogel on 10/31/15.
//  Copyright © 2015 Ayuna Vogel. All rights reserved.
//

#import "COMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface COMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;

@property (nonatomic) BOOL firstTime;

@property (weak, nonatomic) IBOutlet UIButton *showMyLocationButton;

- (IBAction)showMyLocationButton:(id)sender;


@end

@implementation COMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create location manager
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    
    self.showMyLocationButton.tintColor = [UIColor colorWithRed:83.00/255.0 green:123.00/255.0 blue:53.00/255.0 alpha:1.0]; 
}


- (void)locationManager:(CLLocationManager * _Nonnull)manager
     didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations
{
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    [self.mapView setRegion:MKCoordinateRegionMake(center, span)];
    self.mapView.zoomEnabled = true;
    self.mapView.scrollEnabled = true;
    
}
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    if (self.firstTime) {
//        self.firstTime = NO;
//        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
//        [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, span)];
//    }
//}

- (IBAction)showMyLocationButton:(id)sender {
    
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc]init];
    mapPin.title = @"The Location";
    //    mapPin.subtitle = @"Sub-title";
    mapPin.coordinate = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    [self.mapView addAnnotation:mapPin];
    
    NSLog(@"Pin Location");
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:@"This is an alert."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Send Message"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

}
@end
