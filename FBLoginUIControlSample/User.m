//
//  User.m
//  PartyAnimal
//
//  Created by Cole Diamond on 1/26/14.
//  Copyright (c) 2014 Facebook Inc. All rights reserved.
//

#import "User.h"


@implementation User

+ (User *)currentUser
{
    static User *currentUser;
    
    @synchronized(self)
    {
        if (!currentUser)
            currentUser = [[User alloc] init];
        return currentUser;
    }
}

-(void)setId:(NSString *)id_ name:(NSString *)name_ link:(NSString *)link_ username:(NSString *)username_ birthday: (NSString *)birthday_ location:(id<FBGraphPlace>)location_
{
    self.id = id_;
    self.name = name_;
    self.link = link_;
    self.username = username_;
    self.birthday = birthday_;
    self.location = location_;
}

-(UIImage *)profile_picture{
    NSString* user_id = [[User currentUser] id];
    NSURL *prof_pic_url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", user_id]];
    NSData *data = [NSData dataWithContentsOfURL:prof_pic_url];
    return [[UIImage alloc] initWithData:data];
}

@end
