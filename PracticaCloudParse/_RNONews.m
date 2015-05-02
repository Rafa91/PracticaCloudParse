// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNONews.m instead.

#import "_RNONews.h"

const struct RNONewsAttributes RNONewsAttributes = {
	.author = @"author",
	.creationDate = @"creationDate",
	.state = @"state",
	.textNew = @"textNew",
	.titleNew = @"titleNew",
};

const struct RNONewsRelationships RNONewsRelationships = {
	.location = @"location",
	.photo = @"photo",
};

@implementation RNONewsID
@end

@implementation _RNONews

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"News" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"News";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"News" inManagedObjectContext:moc_];
}

- (RNONewsID*)objectID {
	return (RNONewsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"stateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"state"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic author;

@dynamic creationDate;

@dynamic state;

- (double)stateValue {
	NSNumber *result = [self state];
	return [result doubleValue];
}

- (void)setStateValue:(double)value_ {
	[self setState:@(value_)];
}

- (double)primitiveStateValue {
	NSNumber *result = [self primitiveState];
	return [result doubleValue];
}

- (void)setPrimitiveStateValue:(double)value_ {
	[self setPrimitiveState:@(value_)];
}

@dynamic textNew;

@dynamic titleNew;

@dynamic location;

@dynamic photo;

@end

