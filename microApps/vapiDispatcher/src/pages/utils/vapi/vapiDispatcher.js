const getScheme = () => {
    const protocol = window.location.protocol;
    if (/^http/.test(protocol)) return "omp";
    return "microapp";
};

export const scheme = getScheme();

export const flatParams = query => {
    let str = "?";
    for (let key in query) {
        str += key + "=" + query[key] + "&";
    }
    return str.slice(0, -1);
};

export function parseActionStr(actionStr) {
    let [action, argStr] = actionStr.split("?");
    let argMap = argStr.split("&").reduce((p, m) => {
        let [k, v] = m.split("=");
        p[k] = v;
        return p;
    }, {});

    return {
        action,
        argMap
    }
}