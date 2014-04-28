//
//  REDCloseScreen2.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 09.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDCloseScreen2.h"
#import "REDCloseScreen3.h"

#import "REDFontManager.h"
#import "REDSettings.h"

#import "BBAES.h"
#import "AFNetworking.h"

#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

@interface REDCloseScreen2 ()
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *bodyLabel;
    
    REDCloseScreen3 *closeScreen3;
    AFHTTPClient *httpClient;
}

@end

@implementation REDCloseScreen2

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://assist-pilot.uran.in.ua"];
    httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    closeScreen3 = [[REDCloseScreen3 alloc] initWithNibName:@"REDCloseScreen3" bundle:nil];
    [headerLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:34.0]];
    [bodyLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:26.0]];
}

#pragma mark - IBAction Methods

- (IBAction)pressNextButton:(id)sender {
    [self sendToServer];
    [self.navigationController pushViewController:closeScreen3 animated:YES];
}

- (IBAction)pressPrevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
    return YES;
}

#pragma mark - SendToServer

- (void)sendToServer
{
    REDSettings *settings = [REDSettings sharedSettings];
    NSLog(@"participant name: %@", settings.participantName);
    NSLog(@"participant age: %@", settings.participantAge);
    NSLog(@"participant gender: %@", settings.participantGender);
    NSLog(@"participant educational program: %@", settings.participantDegree);
    NSLog(@"have you vaginal intercourse: %@", settings.participantHadVaginal);
    NSLog(@"have you anal intercourse: %@", settings.participantHadAnal);
    
    NSMutableDictionary *resultsTesting = [[NSMutableDictionary alloc] initWithDictionary:[settings allAnswers]];
    [resultsTesting setObject:[NSString stringWithFormat:@"%@", settings.participantHadVaginal] forKey:@"sexQuestion1"];
    [resultsTesting setObject:[NSString stringWithFormat:@"%@", settings.participantHadAnal] forKey:@"sexQuestion2"];
    [resultsTesting setObject:[NSString stringWithFormat:@"%@", settings.sexQuestion3] forKey:@"sexQuestion3"];
    [resultsTesting setObject:[NSString stringWithFormat:@"%@", settings.sexQuestion4] forKey:@"sexQuestion4"];
    [resultsTesting setObject:[NSString stringWithFormat:@"%@", settings.sexQuestion5] forKey:@"sexQuestion5"];
    [resultsTesting setObject:[NSString stringWithFormat:@"%@", settings.sexQuestion6] forKey:@"sexQuestion6"];
    [resultsTesting setObject:[NSString stringWithFormat:@"%@", settings.consent] forKey:@"consent"];
    
    NSLog(@"testing data: %@", [resultsTesting description]);
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:resultsTesting
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            settings.participantName, @"name",
                            settings.participantAge, @"age",
                            settings.participantGender, @"gender",
                            settings.participantDegree, @"degree",
                            [self pressEncrypt:jsonString], @"testResult",
                            nil];
    [httpClient postPath:@"/api/sendTestResult" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
//         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//         NSError * error=nil;
//         NSData * jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
//         NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (NSString *)pressEncrypt:(NSString *)message {
//    //NSData* salt = [BBAES randomDataWithLength:BBAESSaltDefaultLength];
//    //NSData *key = [BBAES keyBySaltingPassword:@"password" salt:salt keySize:BBAESKeySize256 numberOfIterations:BBAESPBKDF2DefaultIterationsCount];
//    
//    NSData *key2 = [BBAES keyByHashingPassword:@"1607" keySize:BBAESKeySize128];
//    NSLog(@"key2 %@", key2);
//    
//    NSString *secretMessage = @"My secret message";
//    NSString *utfString = [secretMessage stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"Original message: %@", utfString);
//    
//    //+ (NSString *)encryptedStringFromData:(NSData *)data IV:(NSData *)iv key:(NSData *)key options:(BBAESEncryptionOptions)options;
//    
//    //NSString *encryptedString2 = [BBAES encryptedStringFromData:[BBAES dataFromString:secretMessage encoding:BBAESDataEncodingBase64] IV:[BBAES randomIV] key:key2 options:BBAESEncryptionOptionsIncludeIV];
//    NSString *encryptedString2 = [BBAES encryptedStringFromData:[secretMessage dataUsingEncoding:NSUTF8StringEncoding]  IV:[BBAES IVFromString:@""] key:key2 options:BBAESEncryptionOptionsIncludeIV];
//    //NSData *encryptedString2 = [BBAES encryptedDataFromData:[secretMessage dataUsingEncoding:NSUTF8StringEncoding] IV:[BBAES randomIV] key:key2 options:BBAESEncryptionOptionsIncludeIV];
//    //NSString* newStr = [[NSString alloc] initWithData:encryptedString2 encoding:NSUTF8StringEncoding];
//
//    //NSString *encryptedString = [secretMessage bb_AESEncryptedStringForIV:[BBAES randomIV] key:key options:BBAESEncryptionOptionsIncludeIV];
//    //NSString *encryptedString2 = [secretMessage bb_AESEncryptedStringForIV:[BBAES randomIV] key:key2 options:BBAESEncryptionOptionsIncludeIV];
//    //NSString *encriptingString = [BBAES stringFromData:encryptedString2 encoding:BBAESDataEncodingBase64];
//    NSLog(@"Encrypted message: %@", encryptedString2);
//    
//    NSData *Decriptdata = [BBAES decryptedDataFromString:encryptedString2 IV:nil key:key2];
////    
//    NSString *decryptedMessage = [BBAES stringFromData:Decriptdata encoding:BBAESDataEncodingBase64];
//    NSLog(@"Decrypted message: %@", decryptedMessage);
//    
//    return encryptedString2;
    //NSData* salt = [BBAES randomDataWithLength:BBAESSaltDefaultLength];
    //NSData *key = [BBAES keyByHashingPassword:@"1607" keySize:BBAESKeySize128];
    
    //NSString *secretMessage = @"123456789012345678901234567890";
    
//    NSLog(@"Original message: %@", secretMessage);
//    NSString *encryptedString = [BBAES encryptedStringFromData:[secretMessage dataUsingEncoding:NSUTF8StringEncoding] IV:[BBAES IVFromString:@""] key:key options:BBAESEncryptionOptionsIncludeIV];
//    NSString *encryptedString = [BBAES encryptedStringFromData:[secretMessage dataUsingEncoding:NSUTF8StringEncoding] IV:[BBAES IVFromString:@""] key:key options:BBAESEncryptionOptionsIncludeIV];
//    NSString *encryptedString = [secretMessage bb_AESEncryptedStringForIV:[BBAES IVFromString:@""] key:key options:BBAESEncryptionOptionsIncludeIV];
//    NSLog(@"Encrypted message: %@", encryptedString);
////    encryptedString = @"oGb/k5MgkzJJ1ctISHFl5OzmUcLYLP27gWgUL0AXdPw=";
//    NSString *decryptedMessage = [encryptedString bb_AESDecryptedStringForIV:nil key:key];
//    NSLog(@"Decrypted message: %@", decryptedMessage);
    
    NSData *messageData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Original message: %@", messageData);
//    messageData = [self AES128EncryptWithKey:@"1607" andData:messageData];
    messageData = [self AES128EncryptWithKey:@"1607" theData:messageData];
    NSLog(@"Original message: %@", messageData);
    //    NSData *data = dataFromBase64EncodedString(string);
    NSString *encryptedString = base64EncodedStringFromData(messageData);
    //NSString *encryptedString = [messageData base64EncodedStringWithOptions:0];
    NSLog(@"Encrypted message: %@", encryptedString);
    return encryptedString;
}

//- (NSData *)AES128EncryptWithKey:(NSString *)key andData:(NSData*)messageData
//{
//    char keyPtr[kCCKeySizeAES128+1];
//    bzero(keyPtr, sizeof(keyPtr));
//    
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    
//    int dataLength = [messageData length];
//    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
//    int newSize = 0;
//    
//    if(diff > 0)
//    {
//        newSize = dataLength + diff;
//    }
//    
//    char dataPtr[newSize];
//    memcpy(dataPtr, [messageData bytes], [messageData length]);
//    for(int i = 0; i < diff; i++)
//    {
//        dataPtr[i + dataLength] = 0x20;
//    }
//    
//    size_t bufferSize = newSize + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
//                                          kCCAlgorithmAES128,
//                                          0x0000, //No padding
//                                          keyPtr,
//                                          kCCKeySizeAES128,
//                                          NULL,
//                                          dataPtr,
//                                          sizeof(dataPtr),
//                                          buffer,
//                                          bufferSize,
//                                          &numBytesEncrypted);
//    
//    if(cryptStatus == kCCSuccess)
//    {
//        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//    }
//    
//    return nil;
//}

- (NSData *)AES128EncryptWithKey:(NSString *)key theData:(NSData *)Data {
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused) // oorspronkelijk 256
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [Data length];
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionECBMode +kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES128, // oorspronkelijk 256
                                          nil, /* initialization vector (optional) */
                                          [Data bytes],
                                          dataLength, /* input */
                                          buffer,
                                          bufferSize, /* output */
                                          &numBytesEncrypted);
    
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer); //free the buffer;
    return nil;
}

//static NSData * dataFromBase64EncodedString(NSString* string) {
//	// Copyright (C) 2012 Charcoal Design (https://github.com/nicklockwood/Base64)
//    const char lookup[] =
//    {
//        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
//        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
//        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 62, 99, 99, 99, 63,
//        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 99, 99, 99, 99, 99, 99,
//        99,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
//        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 99, 99, 99, 99, 99,
//        99, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
//        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 99, 99, 99, 99, 99
//    };
//    
//    NSData *inputData = [string dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    long long inputLength = [inputData length];
//    const unsigned char *inputBytes = [inputData bytes];
//    
//    long long maxOutputLength = (inputLength / 4 + 1) * 3;
//    NSMutableData *outputData = [NSMutableData dataWithLength:(NSUInteger)maxOutputLength];
//    unsigned char *outputBytes = (unsigned char *)[outputData mutableBytes];
//	
//    int accumulator = 0;
//    long long outputLength = 0;
//    unsigned char accumulated[] = {0, 0, 0, 0};
//    for (long long i = 0; i < inputLength; i++) {
//        unsigned char decoded = lookup[inputBytes[i] & 0x7F];
//        if (decoded != 99) {
//            accumulated[accumulator] = decoded;
//            if (accumulator == 3) {
//                outputBytes[outputLength++] = (accumulated[0] << 2) | (accumulated[1] >> 4);
//                outputBytes[outputLength++] = (accumulated[1] << 4) | (accumulated[2] >> 2);
//                outputBytes[outputLength++] = (accumulated[2] << 6) | accumulated[3];
//            }
//            accumulator = (accumulator + 1) % 4;
//        }
//    }
//    
//    if (accumulator > 0) outputBytes[outputLength] = (accumulated[0] << 2) | (accumulated[1] >> 4);
//    if (accumulator > 1) outputBytes[++outputLength] = (accumulated[1] << 4) | (accumulated[2] >> 2);
//    if (accumulator > 2) outputLength++;
//    
//    outputData.length = (CFIndex)outputLength;
//    return outputLength? outputData: nil;
//}

static NSString * base64EncodedStringFromData(NSData* data) {
	// Copyright (C) 2012 Charcoal Design (https://github.com/nicklockwood/Base64)
    const NSUInteger wrapWidth = 0;
    const char lookup[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    long long inputLength = [data length];
    const unsigned char *inputBytes = [data bytes];
    
    long long maxOutputLength = (inputLength / 3 + 1) * 4;
    maxOutputLength += wrapWidth? (maxOutputLength / wrapWidth) * 2: 0;
    unsigned char *outputBytes = (unsigned char *)malloc((size_t)maxOutputLength);
    
    long long i;
    long long outputLength = 0;
    for (i = 0; i < inputLength - 2; i += 3) {
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
        outputBytes[outputLength++] = lookup[((inputBytes[i + 1] & 0x0F) << 2) | ((inputBytes[i + 2] & 0xC0) >> 6)];
        outputBytes[outputLength++] = lookup[inputBytes[i + 2] & 0x3F];
        
        if (wrapWidth && (outputLength + 2) % (wrapWidth + 2) == 0) {
            outputBytes[outputLength++] = '\r';
            outputBytes[outputLength++] = '\n';
        }
    }
    
    if (i == inputLength - 2) {
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
        outputBytes[outputLength++] = lookup[(inputBytes[i + 1] & 0x0F) << 2];
        outputBytes[outputLength++] =   '=';
    }
    else if (i == inputLength - 1) {
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0x03) << 4];
        outputBytes[outputLength++] = '=';
        outputBytes[outputLength++] = '=';
    }
    outputBytes = realloc(outputBytes, (size_t)outputLength);
    NSString *result = [[NSString alloc] initWithBytesNoCopy:outputBytes length:(NSUInteger)outputLength encoding:NSASCIIStringEncoding freeWhenDone:YES];
	
    return (outputLength >= 4) ? result: nil;
}

- (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

@end