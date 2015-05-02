// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNONews.h instead.

@import CoreData;

extern const struct RNONewsAttributes {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *textNew;
	__unsafe_unretained NSString *titleNew;
} RNONewsAttributes;

extern const struct RNONewsRelationships {
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *photo;
} RNONewsRelationships;

@class RNOLocation;
@class RNOPhoto;

@interface RNONewsID : NSManagedObjectID {}
@end

@interface _RNONews : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RNONewsID* objectID;

@property (nonatomic, strong) NSString* author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* state;

@property (atomic) double stateValue;
- (double)stateValue;
- (void)setStateValue:(double)value_;

//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* textNew;

//- (BOOL)validateTextNew:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* titleNew;

//- (BOOL)validateTitleNew:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RNOLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RNOPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _RNONews (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSString*)value;

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSNumber*)primitiveState;
- (void)setPrimitiveState:(NSNumber*)value;

- (double)primitiveStateValue;
- (void)setPrimitiveStateValue:(double)value_;

- (NSString*)primitiveTextNew;
- (void)setPrimitiveTextNew:(NSString*)value;

- (NSString*)primitiveTitleNew;
- (void)setPrimitiveTitleNew:(NSString*)value;

- (RNOLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(RNOLocation*)value;

- (RNOPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(RNOPhoto*)value;

@end
