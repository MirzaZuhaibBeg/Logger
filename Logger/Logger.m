//
//  Logger.m
//  MirzaZuhaib
//
//  Created by Mirza Zuhaib Beg on 12/02/20.
//  Copyright © MirzaZuhaib. All rights reserved.
//

#import "Logger.h"

// Add start and end text so that all logs are readable.
static NSString *startIdentifierText = @"Start=======\n";
static NSString *endIdentifierText = @"\nEnd=======\n\n";

@implementation Logger

/**
 Method to get sharedLogger
 @return shared Logger object
 */
+ (Logger *)sharedLogger
{
    static dispatch_once_t onceToken;
    static Logger* logger;
    dispatch_once(&onceToken, ^{
        logger = [[self alloc] init];
    });
    return logger;
}

/**
 Method to log Text
 @param text text
 */
-(void)logText:(NSString*) text {
    [self writeToFile:startIdentifierText];
    [self writeToFile:text];
    [self writeToFile:endIdentifierText];
}

/**
 Method to write To File
 @param text text
 */
-(void)writeToFile:(NSString*) text {
    // Log Text so that it can be printed in xcode console
    NSLog(@"%@",text);
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self pathLogger]];
    if (fileHandle == nil) {
        [[NSFileManager defaultManager] createFileAtPath:[self pathLogger] contents:nil attributes:nil];
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self pathLogger]];
    }
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
}

#pragma mark - Private Methods

/**
 Method to get documents Directory
 @return NSString
 */
- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

/**
 Method to path of Logger
 @return NSString
 */
- (NSString *)pathLogger {
    NSString *path = [[self documentsDirectory] stringByAppendingPathComponent:@"logger.txt"];
    // Log Path of Logger so that it can be printed in xcode console, and it will be used to get path for logger file.
    NSLog(@"Path of Logger %@",path);
    return path;
}

@end
