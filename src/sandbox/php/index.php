<?php

echo phpinfo();

//function createRedisClient($host): Redis
//{
//    $redis = new Redis();
//    $redis->connect($host, 6379);
//    return $redis;
//}
//
//$redisNode1 = createRedisClient('redis_node1');
//$redisNode2 = createRedisClient('redis_node2');
//$redisNode3 = createRedisClient('redis_node3');
//
//if ($redisNode1->setnx('test_lock:test_item1', 1)) {
//    echo 'test_lock:test_item1 ok', PHP_EOL;
//}
//if ($redisNode2->setnx('test_lock:test_item1', 1)) {
//    echo 'test_lock:test_item1 ok', PHP_EOL;
//}
//if ($redisNode3->setnx('test_lock:test_item1', 1)) {
//    echo 'test_lock:test_item1 ok', PHP_EOL;
//}
//
//$redisNode1->del('test_lock:test_item1');
//$redisNode2->del('test_lock:test_item1');
//$redisNode3->del('test_lock:test_item1');