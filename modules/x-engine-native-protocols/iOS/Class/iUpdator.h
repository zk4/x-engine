//
//  iUpdator.h
//  Updator
//

#ifndef iUpdator_h
#define iUpdator_h




@protocol iUpdator <NSObject>

/**
 * 离线包
 * @url 请求后台地址
 */
- (void)updateMicroappsFromUrl:(NSString *)url;
- (NSString*)getPath:(NSString*) microappId;
@end
#endif /* iUpdator_h */
