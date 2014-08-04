//
// Copyright (c) 2013 XING AG (http://xing.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "XNGAPIClient.h"

@interface XNGAPIClient (Recommendations)

/**
 Returns a list of users the specified user might know.

 https://dev.xing.com/docs/get/users/:user_id/network/recommendations
 */
- (void)getContactRecommendationsWithLimit:(NSInteger)limit
                                    offset:(NSInteger)offset
                           similarToUserID:(NSString *)similarUserID
                                userFields:(NSString *)userFields
                                   success:(void (^)(id JSON))success
                                   failure:(void (^)(NSError *error))failure;

/**
 Block recommendation for user with given id.

 https://dev.xing.com/docs/delete/users/:user_id/network/recommendations/user/:id
 */
- (void)deleteContactRecommendationsForUserIDToIgnore:(NSString*)userIDToIgnore
                                      success:(void (^)(id JSON))success
                                      failure:(void (^)(NSError *error))failure;

/**
 Cancel all recommendations-calls that are currently running/queued.
 */
- (void)cancelAllGetContactRecommendationsHTTPOperations;

@end
