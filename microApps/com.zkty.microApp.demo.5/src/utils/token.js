import jsCookies from 'js-cookie';
import store from 'store';
/**
 * 设置登录token
 * @param userId 用户id
 * @param token 登录token
 */
export const setToken = (userId, token) => {
    const {userIdKey, userTokenKey, expiresDays, domain} = appConfig.cookie;

    store.set(userIdKey, userId);
    store.set(userTokenKey, token);

    jsCookies.set(userIdKey, userId, {
        expires: expiresDays,
        domain
    });

    jsCookies.set(userTokenKey, token, {
        expires: expiresDays,
        domain
    });
};

/**
 * 清空用户token
 * 登录状态token
 */
export const clearToken = () => {
    const {userIdKey, userTokenKey, domain} = appConfig.cookie;
    store.remove(userIdKey);
    store.remove(userTokenKey);
    jsCookies.remove(userIdKey, {domain});
    jsCookies.remove(userTokenKey, {domain});
};