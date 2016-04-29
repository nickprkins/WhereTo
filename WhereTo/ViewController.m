//
//  ViewController.m
//  WhereTo
//
//  Created by Nick Perkins on 4/27/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import "ViewController.h"
#import "Landmark.h"
// Frameworks are in <> and not ""
#import <MapKit/MapKit.h>
#import "popupViewController.h"


@interface ViewController () <CLLocationManagerDelegate,UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) UIBarButtonItem *addButton;
@property (strong, nonatomic) UIPopoverPresentationController *popController;
- (void)showPopover:(id)sender;
-(void)cancel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showPopover:)];
    
    self.navigationItem.leftBarButtonItem = self.addButton;
    
    //CGRect is a struct or value type. A vanilla container object that has some values in it.
    CGRect theFrame = self.view.frame;
    
    //draw the frame in pixels. anti-aliasing covers pixels with both colors that collide in that pixel.
    theFrame.origin.x = 1;
    theFrame.origin.y = 65;
    theFrame.size.width -= 2;
    theFrame.size.height -= 66;
    
    self.manager = [[CLLocationManager alloc]init];
    [self.manager requestAlwaysAuthorization];
    
    //Since it is a map it wants a frame!
    self.mapView = [[MKMapView alloc]initWithFrame:theFrame];
    
    self.mapView.showsUserLocation = YES;
    
    [self.view addSubview:self.mapView];
    
    //initialize function called inside another inside initialize function
    Landmark * capitalBuilding = [[Landmark alloc] initWithCoord:CLLocationCoordinate2DMake(35.7804, -78.6391) title:@"Capital Building" subtitle:@"The place where the capital is"];
    
    [self.mapView addAnnotation:capitalBuilding];
    
    self.manager.delegate = self;
    
    [self.manager startUpdatingLocation];
    
    
    
    CLLocation * capitalLocation = [[CLLocation alloc]initWithLatitude:capitalBuilding.coordinate.latitude longitude:capitalBuilding.coordinate.longitude];
    
    CLLocation * currentLocation = self.mapView.userLocation.location;
    
    if (currentLocation && capitalLocation) {
        
        [self zoomMapToRegionEncapsulatingLocation:capitalLocation andLocation:currentLocation];
        
        //Get Directions MKDirectionsRequest?

        
    }
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)centerMapOnLocation:(CLLocationCoordinate2D)location{
    
    
    
}

-(void)zoomMapToRegionEncapsulatingLocation:(CLLocation*)firstLoc andLocation:(CLLocation*)secondLoc{
    
    float lat =(firstLoc.coordinate.latitude + secondLoc.coordinate.latitude) /2;
    
    float longitude = (firstLoc.coordinate.longitude + secondLoc.coordinate.longitude) /2;
    
    
    CLLocationDistance distance = [firstLoc distanceFromLocation:secondLoc];
    
    CLLocation *centerLocation = [[CLLocation alloc]initWithLatitude:lat longitude:longitude];
    
    //    MKCoordinateSpan span = MKCoordinateSpanMake(2000, 2000);
    
    if (CLLocationCoordinate2DIsValid(centerLocation.coordinate)){
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerLocation.coordinate, distance,distance);
        
        [self.mapView setRegion:region animated:YES];
        
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * firstLocation = [locations firstObject];
    CLLocation * lastLocation = [locations lastObject];
    
    if([firstLocation isEqual:lastLocation]){
        NSLog(@"same place");
    }else{
        NSLog(@"who knows");
    }
    
    Landmark * capitalBuilding = [[Landmark alloc] initWithCoord:CLLocationCoordinate2DMake(35.7804, -78.6391) title:@"Capital Building" subtitle:@"The place where the capital is"];
    
    CLLocation * capitalLocation = [[CLLocation alloc]initWithLatitude:capitalBuilding.coordinate.latitude longitude:capitalBuilding.coordinate.longitude];
    
    CLLocation * currentLocation = firstLocation;
    
    if (currentLocation && capitalLocation) {
        
        [self zoomMapToRegionEncapsulatingLocation:capitalLocation andLocation:currentLocation];
        
    }
    
    [manager stopUpdatingLocation];
}

- (void)showPopover:(id)sender{
    
    popupViewController *popup = [[popupViewController alloc] init];
    popup.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popController = [popup popoverPresentationController];
    self.popController = popController;
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = sender;
    popController.delegate = self;

    [self presentViewController:popup animated:YES completion:nil];
    
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationFullScreen; // required, otherwise delegate method below is never called.
}

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style {
    // If you don't want a nav controller when it's a popover, don't use one in the storyboard and instead return a nav controller here
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:controller.presentedViewController];
    nc.navigationBar.topItem.rightBarButtonItem = bbi;
    return nc;
}




@end
