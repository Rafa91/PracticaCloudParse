#import "RNONews.h"
#import "RNOPhoto.h"
#import "RNOLocation.h"

@interface RNONews ()

// Private interface goes here.

@end

@implementation RNONews

+(instancetype) newWithTitle:(NSString *) aTitle
                      author:(NSString *) anAuthor
                        text:(NSString *) someText
                       state:(double) aState
                       photo:(RNOPhoto *) aPhoto
                    location:(RNOLocation *) aLocation
                     context:(NSManagedObjectContext *)context{
    
    
    RNONews *n = [self insertInManagedObjectContext:context];
    
    n.creationDate = [NSDate date];
    n.titleNew = aTitle;
    n.author = anAuthor;
    n.textNew = someText;
    n.stateValue = aState;
    n.photo = aPhoto;
    n.location = aLocation;
    
    return n;
    
    
}

@end
