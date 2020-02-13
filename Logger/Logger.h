//
//  Logger.h
//  MirzaZuhaib
//
//  Created by Mirza Zuhaib Beg on 12/02/20.
//  Copyright © MirzaZuhaib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject

+ (Logger *)sharedLogger;

-(void)logText:(NSString*) text;

@end
