// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNOLocation.h instead.

@import CoreData;

extern const struct RNOLocationAttributes {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
} RNOLocationAttributes;

extern const struct RNOLocationRelationships {
	__unsafe_unretained NSString *noticia;
} RNOLocationRelationships;

@class RNONews;

@interface RNOLocationID : NSManagedObjectID {}
@end

@interface _RNOLocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RNOLocationID* objectID;

@property (nonatomic, strong) NSString* address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* latitude;

@property (atomic) double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* longitude;

@property (atomic) double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *noticia;

- (NSMutableSet*)noticiaSet;

@end

@interface _RNOLocation (NoticiaCoreDataGeneratedAccessors)
- (void)addNoticia:(NSSet*)value_;
- (void)removeNoticia:(NSSet*)value_;
- (void)addNoticiaObject:(RNONews*)value_;
- (void)removeNoticiaObject:(RNONews*)value_;

@end

@interface _RNOLocation (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;

- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;

- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;

- (NSMutableSet*)primitiveNoticia;
- (void)setPrimitiveNoticia:(NSMutableSet*)value;

@end
