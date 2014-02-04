//
//  Constants.h
//  PartyAnimal
//
//  Created by Cole Diamond on 2/3/14.
//  Copyright (c) 2014 Facebook Inc. All rights reserved.
//

extern NSString * const BASE_URL;

#ifdef DEBUG
#define DEF_BASE_URL "http://party-animal.herokuapp.com/"
#else
#define DEF_BASE_URL "http://localhost:5000/"
#endif

NSString * const BASE_URL = (NSString*)CFSTR(DEF_BASE_URL);
