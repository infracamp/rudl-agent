#!/usr/bin/php
<?php

namespace App;

use Phore\Log\Logger\PhoreEchoLoggerDriver;
use Phore\Log\PhoreLogger;
use Psr\Log\LogLevel;

require __DIR__ . "/../vendor/autoload.php";
require __DIR__ . "/../config.php";


$clusterName = CONF_CLUSTER_NAME;

$pushUrl = CONF_METRICS_HOST . "/v1/push/node";


PhoreLogger::Init(new PhoreEchoLoggerDriver());
phore_log()->setLogLevel(LogLevel::WARNING);


while (1) {


    $data = phore_exec(__DIR__ . "/source.d/system_info.sh");
    $data = phore_json_decode($data);

    $message = [
        "host" => $data["host"],
        "cluster" => $clusterName,
        "system" => $data
    ];


    try {
        phore_log()->notice("Push to $pushUrl...");
        phore_http_request($pushUrl)->withPostBody($message)->send();
        phore_log()->debug("Ok");
    } catch (\Exception $e) {
        phore_log()->warning("Push to $pushUrl failed: " . $e->getMessage());
        sleep (60);
    }

    sleep (5);

}



