//
//  iWebcache.h
//  Webcache
//

#ifndef iWebcache_h
#define iWebcache_h
@class WKWebView;
@protocol iWebcache <NSObject>
// 因为使用的 NSURL 全局代理,仅在webview在前台时用缓存,不要影响原生
-(void) enableCache;
// 当 webview 到后台时,应该关闭缓存
-(void) disableCache;
// wkwebview 的网络代理会使 postbody 丢失. 这个接口应该作相应补救处理, 但是应该更多,代理所有 xhr 请求.
-(void) enableXHRIntercept:(WKWebView*) webview;
@end
#endif /* iWebcache_h */
