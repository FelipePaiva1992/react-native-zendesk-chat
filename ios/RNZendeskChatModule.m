//
//  RNZendeskChat.m
//  Tasker
//
//  Created by Jean-Richard Lai on 11/23/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RNZendeskChatModule.h"
#import <ZDCChat/ZDCChat.h>

static NSString * const RNZendeskNameKey = @"name";
static NSString * const RNZendeskEmailKey = @"email";
static NSString * const RNZendeskPhoneKey = @"phone";
static NSString * const RNZendeskShouldPersistKey = @"shouldPersist";
static NSString * const RNZendeskDepartmentKey = @"departemnt";
static NSString * const RNZendeskTagsKey = @"tags";
static NSString * const RNZendeskEmailNotRequiredKey = @"emailNotRequired";
static NSString * const RNZendeskPhoneNotRequiredKey = @"phoneNotRequired";
static NSString * const RNZendeskDepartmentNotRequiredKey = @"departmentNotRequired";
static NSString * const RNZendeskMessageNotRequiredKey = @"messageNotRequired";

@implementation RNZendeskChatModule

RCT_EXPORT_MODULE(RNZendeskChatModule);

RCT_EXPORT_METHOD(setVisitorInfo:(NSDictionary *)options) {
  [ZDCChat updateVisitor:^(ZDCVisitorInfo *visitor) {
    if (options[RNZendeskNameKey]) {
      visitor.name = options[RNZendeskNameKey];
    }
    if (options[RNZendeskEmailKey]) {
      visitor.email = options[RNZendeskEmailKey];
    }
    if (options[RNZendeskPhoneKey]) {
      visitor.phone = options[RNZendeskPhoneKey];
    }
    visitor.shouldPersist = options[RNZendeskShouldPersistKey] || NO;
  }];
}

RCT_EXPORT_METHOD(startChat:(NSDictionary *)options) {
  [self setVisitorInfo:options];

  dispatch_sync(dispatch_get_main_queue(), ^{
    [ZDCChat startChat:^(ZDCConfig *config) {
      if (options[RNZendeskDepartmentKey]) {
        config.department = options[RNZendeskDepartmentKey];
      }
      if (options[RNZendeskTagsKey]) {
        config.tags = options[RNZendeskTagsKey];
      }
      config.preChatDataRequirements.name = ZDCPreChatDataRequired;
      config.preChatDataRequirements.email = options[RNZendeskEmailNotRequiredKey] ? ZDCPreChatDataNotRequired : ZDCPreChatDataRequired;
      config.preChatDataRequirements.phone = options[RNZendeskPhoneNotRequiredKey] ? ZDCPreChatDataNotRequired : ZDCPreChatDataRequired;
      config.preChatDataRequirements.department = options[RNZendeskDepartmentNotRequiredKey] ? ZDCPreChatDataNotRequired : ZDCPreChatDataRequiredEditable;
      config.preChatDataRequirements.message = options[RNZendeskMessageNotRequiredKey] ? ZDCPreChatDataNotRequired : ZDCPreChatDataRequired;
    }];
  });
}

@end
