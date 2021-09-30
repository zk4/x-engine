
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_dto_Post.h"


@implementation PostReq
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
      if ([propertyName isEqualToString:@"tid"]) { return YES; }
      return NO;
    }
@end

  
@implementation PostReq_hello
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
      
      return NO;
    }
@end

  
@implementation PostReq_hello_helloworld
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
      
      return NO;
    }
@end

  
@implementation PostRes
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
      
      return NO;
    }
@end


@implementation gen_PostApi

NSError * errorWrapper(NSError * error , NSError* underlyingError ){
  if (!error) {
      return underlyingError;
  }
  if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
      return error;
  }
  NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
  mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
  return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

- (NSString*) getMethod{
    return @"POST";
}


- (NSString*) getUrl{
   return [NSString stringWithFormat:@"https://httpbin.org/post"];
}

- (void) request:(PostApiResponse) response{
    self.network = [NSMutableURLRequest new];
    self.network.URL =[NSURL URLWithString:[self getUrl]];
    self.network.HTTPMethod = [self getMethod];
    self.network.HTTPBody = self.postReq.toJSONData;
    [self addLocalFilter:self.network];
    [self.network send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSError* err;
        id resPost = [[PostRes alloc] initWithDictionary:data error:&err];
        response(resPost,res,errorWrapper(error,err));
    }];
}

- (FBLPromise<PostRes *>*) promise:(PostReq*) postReq{
    FBLPromise<PostRes *>* promise = [FBLPromise async:^(FBLPromiseFulfillBlock fulfill, FBLPromiseRejectBlock reject) {
        self.network = [NSMutableURLRequest new];
        self.network.URL =[NSURL URLWithString:[self getUrl]];
        self.network.HTTPMethod = [self getMethod];
        self.network.HTTPBody = postReq.toJSONData;
        [self addLocalFilter:self.network];
        [self.network send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            if(!error){
                NSError* err;
                id resPost = [[PostRes alloc] initWithDictionary:data error:&err];
                if(!err)
                 fulfill(resPost);
                else
                    reject(err);
            }else{
                reject(error);
            }
        }];
    }];
    return promise;
}

- (FBLPromise<PostRes *>*) promise{
    return [self promise:self.postReq];
}

@end


