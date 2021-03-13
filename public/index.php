<?php

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;

require __DIR__ . '/../vendor/autoload.php';

$app = AppFactory::create();

$app->get('/', function (Request $request, Response $response, array $args) {
    $payload = json_encode([
        'name' => 'wandersonwhcr/hello',
        'description' => 'Hello, World!',
        'version' => '1.0.0-alpha',
    ]);

    $response->getBody()
        ->write($payload);

    return $response
        ->withHeader('Content-Type', 'application/json');
});

$app->addRoutingMiddleware();
$app->addErrorMiddleware(true, true, true);

$app->run();
