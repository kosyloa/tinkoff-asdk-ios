//
//  ASDKCard.m
//  ASDKCore
//
// Copyright (c) 2016 TCS Bank
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "ASDKCard.h"
#import "ASDKApiKeys.h"

@implementation ASDKCard

- (void)clearAllProperties
{
    _pan = nil;
    _cardId = nil;
    _rebillId = nil;
}

- (NSString *)pan
{
    if (!_pan)
    {
        _pan = _dictionary[kASDKPan];
    }
    
    return _pan;
}

- (NSString *)cardId
{
    if (!_cardId)
    {
        _cardId = _dictionary[kASDKCardId];
    }
    
    return _cardId;
}

- (NSNumber *)rebillId
{
    if (!_rebillId)
    {
        _rebillId = _dictionary[kASDKRebillId];
    }
    
    return _rebillId;
}

- (ASDKCardStatus)status
{
    NSString *cardStatusString = _dictionary[kASDKStatus];
    
    if ([cardStatusString isEqualToString:@"A"])
    {
        return ASDKCardStatusActive;
    }
    else if ([cardStatusString isEqualToString:@"I"])
    {
        return ASDKCardStatusInactive;
    }
    else if ([cardStatusString isEqualToString:@"D"])
    {
        return ASDKCardStatusDeleted;
    }
    else
    {
        return ASDKCardStatusUnknown;
    }
}

- (ASDKCardType)cardType
{
    if (!_cardType)
    {
        NSString *cardNumber = [self pan];
        char firstCardNumberSymbol;
        
        if (cardNumber.length > 0)
        {
            firstCardNumberSymbol = (char)[cardNumber characterAtIndex:0];
        }
        
        switch (firstCardNumberSymbol)
        {
            case ASDKCardTypeVisa:
            {
                _cardType = ASDKCardTypeVisa;
                break;
            }
            case ASDKCardTypeMastercard:
            {
                _cardType = ASDKCardTypeMastercard;
                break;
            }
            case ASDKCardTypeMaestro:
            {
                _cardType = ASDKCardTypeMaestro;
                break;
            }
                
        }
    }
    
    return _cardType;
}

#pragma mark - Helpers

- (NSString *)panExtraShort
{
    NSString *shortCardNumber = [NSString string];
    NSString *pan = [self pan];
    
    if (pan.length > 4)
    {
        shortCardNumber = [NSString stringWithFormat:@"%@", [pan substringFromIndex:[pan length] - 4]];
    }
    
    return shortCardNumber;
}

@end