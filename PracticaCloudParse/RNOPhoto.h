#import "_RNOPhoto.h"

@import CoreData;
@import UIKit;

@interface RNOPhoto : _RNOPhoto {}

@property (nonatomic, strong) UIImage *image;

+(instancetype) photoWithImageData:(NSData *) data
                           context:(NSManagedObjectContext*) context;

@end
