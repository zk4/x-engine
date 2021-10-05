{
  "swagger": "2.0",
  "info": {
    "description": "GM-M 前端接口",
    "version": "1.0",
    "title": "GM-M 前端接口"
  },
  "host": "10.115.91.71:32563",
  "basePath": "/bff-m",
  "schemes": [],
  "consumes": [
    "*/*"
  ],
  "produces": [
    "*/*"
  ],
  "paths": {
    "/gm/general/appVersion/checkUpdate": {
      "post": {
        "tags": [
          "APP版本相关"
        ],
        "summary": "校验更新版本 ",
        "operationId": "checkUpdateUsingPOST",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "*/*"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "request",
            "description": "request",
            "required": true,
            "schema": {
              "$ref": "#/definitions/校验更新APP版本请求",
              "originalRef": "校验更新APP版本请求"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/校验更新APP版本的返回",
              "originalRef": "校验更新APP版本的返回"
            }
          },
          "201": {
            "description": "Created"
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
          }
        }
      }
    }
  },
  "definitions": {
    "校验更新APP版本请求": {
      "type": "object",
      "required": [
        "os",
        "platform"
      ],
      "properties": {
        "os": {
          "type": "string",
          "description": "操作系统（Android、IOS）",
          "refType": null
        },
        "platform": {
          "type": "string",
          "description": "平台（App、POS等）",
          "refType": null
        },
        "versionCode": {
          "type": "integer",
          "format": "int32",
          "description": "版本号",
          "refType": null
        },
        "versionName": {
          "type": "string",
          "description": "版本名称",
          "refType": null
        }
      },
      "title": "校验更新APP版本请求",
      "description": "请求参数类"
    },
    "校验更新APP版本的返回": {
      "type": "object",
      "properties": {
        "digest": {
          "type": "string",
          "description": "更新摘要"
        },
        "externalUrl": {
          "type": "string",
          "description": "外部地址"
        },
        "isUpdate": {
          "type": "boolean",
          "description": " 是否有更新"
        },
        "remark": {
          "type": "string",
          "description": "备注"
        },
        "resUrl": {
          "type": "string",
          "description": "更新包资源URL"
        },
        "title": {
          "type": "string",
          "description": " 更新标题"
        },
        "type": {
          "type": "integer",
          "format": "int32",
          "description": "更新类型（1、软更新；2、强制更新；3、热更新）"
        }
      },
      "title": "校验更新APP版本的返回",
      "description": "返回参数类"
    }
  }
}
