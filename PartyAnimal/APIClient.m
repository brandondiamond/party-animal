//
//  APIClient.m
//  PartyAnimal
//
//  Created by Cole Diamond on 2/3/14.
//  Copyright (c) 2014 Facebook Inc. All rights reserved.
//

#import "APIClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"

@implementation APIClient


+ (APIClient *)sharedClient
{
    static APIClient *sharedClient;
    
    @synchronized(self)
    {
        if (!sharedClient)
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:BASE_URL];
        return sharedClient;
    }
}

-(void)getRequestForURL:(NSString *)url params:(NSDictionary *)params {
    AFHTTPRequestOperationManager *apiClient = [APIClient sharedClient];
}





@end
