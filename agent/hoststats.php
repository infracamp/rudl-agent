#!/usr/bin/php
<?php

namespace App;

require __DIR__ . "/../vendor/autoload.php";

$clusterName = "arnold";


while (1) {


    $data = phore_exec(__DIR__ . "/source.d/system_info.sh");
    $data = phore_json_decode($data);

    $message = [
        "host" => $data["host"],
        "cluster" => $clusterName,
        "system" => $data
    ];


    phore_http_request("http://10.0.10.230/v1/push/node")->withPostBody($message)->send();

    sleep (5);

}



