//
//  Landmark.m
//  WhereTo
//
//  Created by Nick Perkins on 4/27/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import "Landmark.h"

@implementation Landmark

-(nullable instancetype) initWithCoord: (CLLocationCoordinate2D)coord
                                 title: (nullable NSString*) titleString
                              subtitle: (nullable NSString*) subtitleString
{
    self = [super init];
    if (self) {
        _coordinate = coord;
        _title = titleString;
        _subtitle = subtitleString;
    }
    return self;
}

@end
