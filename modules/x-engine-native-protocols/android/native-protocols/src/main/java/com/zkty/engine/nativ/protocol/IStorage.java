package com.zkty.engine.nativ.protocol;

public interface IStorage {
    /**
     * 这个模块不应该依赖本地 h5 id（microapp），这是一个通用原生组件。key 应该在外面传进来时，就已约定好相应关系。
     * 可以这样指定 key, 如果是本地 h5（microapp）
     * microapp:{id}
     **/


    // 返回值
    // 0， key 不存在，value 存储成功
    // 1， key 存在， 存储成功
    // -1， 存储失败
    int save(String key, String value);

    String read(String key);

}
