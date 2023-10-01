<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit0772dc65df2ebd407916f4da723df223
{
    public static $fallbackDirsPsr4 = array (
        0 => __DIR__ . '/../..' . '/src',
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->fallbackDirsPsr4 = ComposerStaticInit0772dc65df2ebd407916f4da723df223::$fallbackDirsPsr4;
            $loader->classMap = ComposerStaticInit0772dc65df2ebd407916f4da723df223::$classMap;

        }, null, ClassLoader::class);
    }
}