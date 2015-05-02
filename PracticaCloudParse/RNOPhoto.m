#import "RNOPhoto.h"

@interface RNOPhoto ()

// Private interface goes here.

@end

@implementation RNOPhoto

+(instancetype) photoWithImageData:(NSData *) data
                           context:(NSManagedObjectContext*) context{
    
    RNOPhoto *p = [self insertInManagedObjectContext:context];
    
    p.imageData = data;
    
    return p;
    
}

-(void) setImage:(UIImage *)image{
    
    // Convertir la UIImage en un NSData
    self.imageData = UIImageJPEGRepresentation(image, 0.9);
}

-(UIImage *) image{
    
    // Convertir la NSData en UIImage
    return [UIImage imageWithData:self.imageData];
}

@end
