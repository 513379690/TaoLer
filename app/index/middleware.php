<?php

return [
	\app\middleware\LoginCookie::class,
	\app\middleware\Install::class,
	\app\middleware\Browse::class,
	// 多语言加载
     \think\middleware\LoadLangPack::class,
	//app\middleware\LoginCheck::class,
    //app\middleware\CheckRegister::class,
	//'logedcheck' => \app\middleware\logedCheck::class,
];