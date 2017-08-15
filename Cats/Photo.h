//
//  Photo.h
//  Cats
//
//  Created by Tye Blackie on 2017-08-14.
//  Copyright © 2017 Tye Blackie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString *photoID;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *server;
@property (nonatomic, assign) NSString *farm;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageURL;

//- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
