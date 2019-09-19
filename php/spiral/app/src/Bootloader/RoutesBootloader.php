<?php
namespace App\Bootloader;

use Spiral\Boot\Bootloader\Bootloader;
use Spiral\Router\Route;
use Spiral\Router\RouterInterface;
use Spiral\Router\Target;

class RoutesBootloader extends Bootloader
{
    /**
     * @param RouterInterface $router
     */
    public function boot(RouterInterface $router)
    {
        $route = new Route('/', new Target\Action(BenchmarkController::class, 'index'));

        $router->addRoute(
            'index',
            $route->withVerbs('GET')
        );

        $router->addRoute(
            'user',
            new Route('/user[/<id>]', new Target\Action(BenchmarkController::class, 'user'))
        );
    }
}
