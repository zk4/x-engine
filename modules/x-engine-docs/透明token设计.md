##　当前问题

业务将会污染网络模块，两种隔离业务的方案，

1.　通过 js　传入业务登陆逻辑。
2.　将业务逻辑单独模块化。（当前解决方案）

``` mermaid
sequenceDiagram
    participant MicroApp
    participant Network
    participant Server
    
    MicroApp->>Network: Request
    Network->>Network: Get Token Process


    Network->>Server: Request
    
    Server->>Network: 403
    Network->>Network: Refresh Token Process
    Network->>Server: Request
		Server->>Network: 200
		Network->>MicroApp: 200

```





## 将业务逻辑单独模块化 （当前解决方案）

x-engine-module-timestoken

```mermaid
sequenceDiagram
    participant MicroApp
    participant Token
    participant Network
    participant Server
    MicroApp->>Token:Ask Token
    Token->>Token:Get Token Process
    Token->>MicroApp:Return Token
    MicroApp->>Network: Request
    Network->>Server: Request
    Server->>MicroApp: 403
    MicroApp->>Token : Ask Token and Tell Token Expired
    Token->>Token:Refresh Token Process
    Token->>MicroApp:Return Token
    MicroApp->>Network: Request
    Network->>Server: Request
    Server->>MicroApp: 200


```

