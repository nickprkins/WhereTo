//
//  popupViewController.m
//  WhereTo
//
//  Created by Nick Perkins on 4/28/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import "popupViewController.h"
#import "Landmark.h"
#import <MapKit/MapKit.h>

@interface popupViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *firstDestination;
@property (strong, nonatomic) UITextField *secondDestination;
- (void)giveMeCoordinates:(NSArray *)theAddresses;

@end

@implementation popupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //first one
    self.firstDestination = [[UITextField alloc] initWithFrame:CGRectMake(45, 120, 200, 40)];
    self.firstDestination.textColor = [UIColor darkGrayColor];
    self.firstDestination.font = [UIFont fontWithName:@"Apple SD-Gothic Neo" size:25];
    self.firstDestination.backgroundColor=[UIColor whiteColor];
    self.firstDestination.borderStyle = UITextBorderStyleRoundedRect;
    self.firstDestination.placeholder=@"City, State";
    self.firstDestination.returnKeyType = UIReturnKeyNext;
    self.firstDestination.enablesReturnKeyAutomatically = YES;
    self.firstDestination.delegate = self;
    
    //second one
    self.secondDestination = [[UITextField alloc] initWithFrame:CGRectMake(45, self.firstDestination.frame.origin.y+75, 200, 40)];
    self.secondDestination.textColor = [UIColor darkGrayColor];
    self.secondDestination.font = [UIFont fontWithName:@"Apple SD-Gothic Neo" size:25];
    self.secondDestination.backgroundColor=[UIColor whiteColor];
    self.secondDestination.borderStyle = UITextBorderStyleRoundedRect;
    self.secondDestination.placeholder=@"City, State";
    self.secondDestination.returnKeyType = UIReturnKeyRoute;
    self.secondDestination.enablesReturnKeyAutomatically = YES;
    self.secondDestination.delegate = self;
    
    //and so on adjust your view size according to your needs
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    view.backgroundColor = [UIColor grayColor];
    [view addSubview:self.firstDestination];
    [view addSubview:self.secondDestination];
    
    [self.view addSubview:view];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual: self.firstDestination]){
        [self.firstDestination resignFirstResponder];
        [self.secondDestination becomeFirstResponder];
        return YES;
    }else if ([textField isEqual: self.secondDestination]){
            [self.secondDestination resignFirstResponder];
        [self giveMeCoordinates:@[self.firstDestination.text, self.secondDestination.text]];
        
            return YES;
    }
        return NO;
    }


- (void)giveMeCoordinates:(NSArray *)theAddresses{
    
    NSLog(@"%@", theAddresses[0]);
    NSLog(@"%@", theAddresses[1]);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    geocoder
}

@end
