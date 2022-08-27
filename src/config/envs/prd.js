/**
 * 放到正常服务器上安装
 */

module.exports = {
    // mysql 连接配置
    mysqlConf: {
        host: '39.105.4.104',
        user: 'root',
        password: 'weizai1992weizai',
        port: '3306',
        database: 'imooc_lego_course',
    },

    // mongodb 连接配置
    mongodbConf: {
        host: '39.105.4.105',
        port: '27017',
        dbName: 'imooc_lego_course',
        user: 'root',
        password: 'weizai1992weizai',
    },

    // redis 连接配置
    redisConf: {
        port: '6379',
        host: '39.105.4.104',
        password: '110',
    },

    // jwt 过期时间
    jwtExpiresIn: '1d', // 1. 字符串，如 '1h' '2d'； 2. 数字，单位是 s

    // cors origin
    corsOrigin: '*',
}
