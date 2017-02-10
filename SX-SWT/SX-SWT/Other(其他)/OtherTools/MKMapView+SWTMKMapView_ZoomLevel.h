//
//  MKMapView+SWTMKMapView_ZoomLevel.h
//  SX-SWT
//
//  Created by 何键键 on 16/9/5.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (SWTMKMapView_ZoomLevel)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
@end
