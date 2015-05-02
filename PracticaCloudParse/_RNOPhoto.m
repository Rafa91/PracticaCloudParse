// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNOPhoto.m instead.

#import "_RNOPhoto.h"

const struct RNOPhotoAttributes RNOPhotoAttributes = {
	.imageData = @"imageData",
};

const struct RNOPhotoRelationships RNOPhotoRelationships = {
	.noticia = @"noticia",
};

@implementation RNOPhotoID
@end

@implementation _RNOPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (RNOPhotoID*)objectID {
	return (RNOPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageData;

@dynamic noticia;

- (NSMutableSet*)noticiaSet {
	[self willAccessValueForKey:@"noticia"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"noticia"];

	[self didAccessValueForKey:@"noticia"];
	return result;
}

@end

