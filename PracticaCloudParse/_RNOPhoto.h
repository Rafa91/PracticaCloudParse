// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNOPhoto.h instead.

@import CoreData;

extern const struct RNOPhotoAttributes {
	__unsafe_unretained NSString *imageData;
} RNOPhotoAttributes;

extern const struct RNOPhotoRelationships {
	__unsafe_unretained NSString *noticia;
} RNOPhotoRelationships;

@class RNONews;

@interface RNOPhotoID : NSManagedObjectID {}
@end

@interface _RNOPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RNOPhotoID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *noticia;

- (NSMutableSet*)noticiaSet;

@end

@interface _RNOPhoto (NoticiaCoreDataGeneratedAccessors)
- (void)addNoticia:(NSSet*)value_;
- (void)removeNoticia:(NSSet*)value_;
- (void)addNoticiaObject:(RNONews*)value_;
- (void)removeNoticiaObject:(RNONews*)value_;

@end

@interface _RNOPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (NSMutableSet*)primitiveNoticia;
- (void)setPrimitiveNoticia:(NSMutableSet*)value;

@end
