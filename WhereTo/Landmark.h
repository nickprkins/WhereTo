//
//  Landmark.h
//  WhereTo
//
//  Created by Nick Perkins on 4/27/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Landmark : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;

-(nullable instancetype) initWithCoord: (CLLocationCoordinate2D) coord title: (nullable NSString*)titleString subtitle:(nullable NSString* ) subtitleString;


@end
