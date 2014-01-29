//
//  User.h
//  PartyAnimal
//
//  Created by Cole Diamond on 1/26/14.
//  Copyright (c) 2014 Facebook Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBGraphPlace.h"

@interface User : NSObject

@property (retain, nonatomic) NSString *id;
@property (nonatomic, retain) NSString *name;
@property (retain, nonatomic) NSString *link;
@property (retain, nonatomic) NSString *username;
@property (retain, nonatomic) NSString *birthday;
@property (retain, nonatomic) id<FBGraphPlace> location;

+ (id)currentUser;
- (void)setId:(NSString *)id_ name:(NSString *)name_ link:(NSString *)link_ username:(NSString *)username_ birthday: (NSString *)birthday_ location:(id<FBGraphPlace>)location_;
- (UIImage *)profile_picture;
@end
