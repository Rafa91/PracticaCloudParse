#import "_RNONews.h"

@import CoreData;

@class RNOPhoto;
@class RNOLocation;

@interface RNONews : _RNONews {}

+(instancetype) newWithTitle:(NSString *) aTitle
                      author:(NSString *) anAuthor
                        text:(NSString *) someText
                       state:(double) aState
                       photo:(RNOPhoto *) aPhoto
                    location:(RNOLocation *) aLocation
                     context:(NSManagedObjectContext *)context;


@end
