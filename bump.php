#!/usr/bin/env php
<?php
$buffer = file_get_contents('https://github.com/bebbo/amigaos-cross-toolchain');
$prefix = '<a class="commit-tease-sha" href="/bebbo/amigaos-cross-toolchain/commit/';
$sha1   = substr($buffer, strpos($buffer, $prefix) + strlen($prefix), 40);

$buffer = '';
$prefix = '    git checkout -qf ';

foreach (file(__DIR__ . '/Dockerfile') as $line) {
    if (strpos($line, $prefix) === 0) {
        $line = $prefix . $sha1 . ' && \\' . PHP_EOL;
    }

    $buffer .= $line;
}

file_put_contents(__DIR__ . '/Dockerfile', $buffer);

