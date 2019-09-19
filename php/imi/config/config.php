<?php
return [
    // 项目根命名空间
    'namespace'    =>    'ImiApp',

    // 配置文件
    'configs'    =>    [
        'beans'        =>    __DIR__ . '/beans.php',
    ],

    // 扫描目录
    'beanScan'    =>    [],

    // 组件命名空间
    'components'    =>  [],

    // 主服务器配置
    'mainServer'    =>    [
        'namespace' =>  'ImiApp\ApiServer',
        'type'      =>  Imi\Server\Type::HTTP,
        'host'      =>  '0.0.0.0',
        'port'      =>  3000,
        'configs'   =>  [
            'worker_num'        => swoole_cpu_num() * 2,
            'open_tcp_nodelay'  => true,
            'tcp_fastopen'      => true,
        ],
    ],
];
