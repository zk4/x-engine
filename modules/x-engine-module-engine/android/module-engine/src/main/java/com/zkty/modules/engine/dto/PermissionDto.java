package com.zkty.modules.engine.dto;

import java.util.List;
import java.util.Map;

public class PermissionDto {


    /**
     * id
     */
    /**
     * id : com.zkty.microapp.xxx
     * version : 2
     * engine_version : 1.0.0
     * router : {"navBar":{"hide":true},"statusBar":{"color":"#fff000"}}
     * sitemap : {}
     * permission : {"secrect":["key"],"module":{"modulename":{"scope":"all"}},"network":{"method":"native"}}
     */

    private String id;
    /**
     * version
     */
    private int version;
    /**
     * engine_version
     */
    private String engine_version;
    /**
     * router
     */
    private RouterBean router;
    /**
     * sitemap
     */
    private SitemapBean sitemap;
    /**
     * permission
     */
    private PermissionBean permission;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    public String getEngine_version() {
        return engine_version;
    }

    public void setEngine_version(String engine_version) {
        this.engine_version = engine_version;
    }

    public RouterBean getRouter() {
        return router;
    }

    public void setRouter(RouterBean router) {
        this.router = router;
    }

    public SitemapBean getSitemap() {
        return sitemap;
    }

    public void setSitemap(SitemapBean sitemap) {
        this.sitemap = sitemap;
    }

    public PermissionBean getPermission() {
        return permission;
    }

    public void setPermission(PermissionBean permission) {
        this.permission = permission;
    }

    public static class RouterBean {
        /**
         * navBar
         */
        /**
         * navBar : {"hide":true}
         * statusBar : {"color":"#fff000"}
         */

        private NavBarBean navBar;
        /**
         * statusBar
         */
        private StatusBarBean statusBar;

        public NavBarBean getNavBar() {
            return navBar;
        }

        public void setNavBar(NavBarBean navBar) {
            this.navBar = navBar;
        }

        public StatusBarBean getStatusBar() {
            return statusBar;
        }

        public void setStatusBar(StatusBarBean statusBar) {
            this.statusBar = statusBar;
        }

        public static class NavBarBean {
            /**
             * hide
             */
            /**
             * hide : true
             */

            private boolean hide;

            public boolean isHide() {
                return hide;
            }

            public void setHide(boolean hide) {
                this.hide = hide;
            }
        }

        public static class StatusBarBean {
        }
    }

    public static class SitemapBean {
    }

    public static class PermissionBean {
        /**
         * module
         */
        /**
         * secrect : ["key"]
         * module : {"modulename":{"scope":"all"}}
         * network : {"method":"native"}
         */

        private Map<String, Map<String, String>> module;
        /**
         * network
         */
        private NetworkBean network;
        /**
         * secrect
         */
        private List<String> secrect;

        public Map<String, Map<String, String>> getModule() {
            return module;
        }

        public void setModule(Map<String, Map<String, String>> module) {
            this.module = module;
        }

        public NetworkBean getNetwork() {
            return network;
        }

        public void setNetwork(NetworkBean network) {
            this.network = network;
        }

        public List<String> getSecrect() {
            return secrect;
        }

        public void setSecrect(List<String> secrect) {
            this.secrect = secrect;
        }


        public static class NetworkBean {
            /**
             * method
             */
            /**
             * method : native
             */

            private String method;

            public String getMethod() {
                return method;
            }

            public void setMethod(String method) {
                this.method = method;
            }
        }
    }
}
