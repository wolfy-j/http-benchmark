# Which is the fastest?

[![Build Status](https://travis-ci.com/the-benchmarker/web-frameworks.svg?branch=master)](https://travis-ci.com/the-benchmarker/web-frameworks)
[![Join the chat at https://gitter.im/which_is_the_fastest/Lobby](https://badges.gitter.im/which_is_the_fastest/Lobby.svg)](https://gitter.im/which_is_the_fastest/Lobby)

This project aims to be a load benchmarking suite, no more, no less

> Measuring response times (routing times) for each framework (middleware).


<div align="center">
  :warning::warning::warning::warning::warning::warning::warning::warning:
</div>

<div align="center">Results are not <b>production-ready</b> <i>yet</i></div>

<div align="center">
  :warning::warning::warning::warning::warning::warning::warning::warning:
</div>

### Additional purposes :

+ Helping decide between languages, depending on use case
+ Learning languages, best practices, devops culture ...
+ Having fun :heart:

## Requirements

+ [Crystal](https://crystal-lang.org) as `built-in` tools are made in this language
+ [Docker](https://www.docker.com) as **frameworks** are `isolated` into _containers_
+ [wrk](https://github.com/wg/wrk) as benchmarking tool, `>= 4.1.0`

:information_source: you need `wrk` **stable**

~~~sh
git clone --branch 4.1.0 https://github.com/wg/wrk
~~~

:warning: `docker` is used for **development** purpose, `production` results will be computed on [DigitalOcean](https://www.digitalocean.com) :warning:

## Usage

+ Install all dependencies

~~~sh
shards install
~~~

+ Build internal tools

~~~sh
shards build
~~~

+ Initialize `sqlite` database

~~~sh
bin/db init
~~~

+ Make configuration

~~~sh
bin/make config
~~~

+ Build containers

> jobs are either languages (example : crystal) or frameworks (example : router.cr)

~~~sh
bin/neph [job1] [job2] [job3] ...
~~~

+ Export all results readme

~~~sh
bin/db to_readme
~~~

## Results

| Language | Framework | Average | 50th percentile | 90th percentile | 99th percentile | 99.9th percentile | Standard deviation | Requests / s | Throughput |
|----|----|---------|-------------|---------|----------|----------|------|------|-------|
| rust | nickel | 0.06 ms | **0.05** ms | 0.06 ms | 0.24 ms  | 9.97 ms  | 151.00 | 79995.67 | 10.54 Mb |
| ruby | cuba | 1.97 ms | **0.20** ms | 2.65 ms | 35.24 ms  | 145.79 ms  | 6793.00 | 34237.67 | 2.68 Mb |
| ruby | roda | 1.78 ms | **0.23** ms | 1.78 ms | 32.48 ms  | 150.53 ms  | 6283.67 | 38069.00 | 2.41 Mb |
| rust | iron | 0.34 ms | **0.27** ms | 0.54 ms | 1.42 ms  | 39.38 ms  | 539.67 | 91851.00 | 7.67 Mb |
| ruby | rack-routing | 2.34 ms | **0.38** ms | 3.55 ms | 37.14 ms  | 180.88 ms  | 7206.00 | 28159.00 | 1.08 Mb |
| ruby | sinatra | 4.75 ms | **0.49** ms | 16.05 ms | 57.12 ms  | 184.69 ms  | 11538.67 | 13507.33 | 2.33 Mb |
| swift | swifter | 5.25 ms | **0.72** ms | 14.43 ms | 16.18 ms  | 2848.69 ms  | 37330.33 | 10493.67 | 0.89 Mb |
| ruby | hanami | 5.09 ms | **0.92** ms | 16.88 ms | 54.02 ms  | 197.06 ms  | 11230.33 | 12635.67 | 6.35 Mb |
| ruby | flame | 4.88 ms | **1.23** ms | 13.43 ms | 49.55 ms  | 198.96 ms  | 9985.33 | 13301.67 | 0.51 Mb |
| rust | rocket | 149.43 ms | **3.61** ms | 11.83 ms | 4089.96 ms  | 6595.37 ms  | 685118.67 | 23851.67 | 2.57 Mb |
| ruby | rails | 28.18 ms | **3.68** ms | 89.45 ms | 202.88 ms  | 525.19 ms  | 45493.33 | 2273.67 | 0.47 Mb |
| c | agoo-c | 5.12 ms | **4.96** ms | 9.01 ms | 15.39 ms  | 58.02 ms  | 3334.33 | 187897.00 | 7.20 Mb |
| node | nanoexpress | 5.52 ms | **5.19** ms | 10.54 ms | 19.61 ms  | 45.79 ms  | 4227.33 | 179425.33 | 10.47 Mb |
| node | sifrr | 5.61 ms | **5.28** ms | 10.67 ms | 20.09 ms  | 50.76 ms  | 4334.33 | 177558.67 | 10.36 Mb |
| python | japronto | 5.52 ms | **5.48** ms | 9.29 ms | 16.09 ms  | 38.80 ms  | 3340.67 | 172792.00 | 13.71 Mb |
| go | fasthttprouter | 7.06 ms | **6.30** ms | 10.50 ms | 18.38 ms  | 185.19 ms  | 6135.67 | 138824.00 | 14.81 Mb |
| c | kore | 21.32 ms | **6.80** ms | 14.91 ms | 566.63 ms  | 2022.24 ms  | 114832.00 | 140425.33 | 24.18 Mb |
| java | rapidoid | 7.80 ms | **6.80** ms | 12.94 ms | 32.74 ms  | 238.69 ms  | 8515.33 | 132335.00 | 15.79 Mb |
| python | vibora | 8.29 ms | **7.47** ms | 15.02 ms | 25.44 ms  | 70.28 ms  | 5531.33 | 132248.33 | 9.95 Mb |
| cpp | evhtp | 8.65 ms | **7.78** ms | 12.56 ms | 22.57 ms  | 228.27 ms  | 8158.67 | 116820.00 | 7.51 Mb |
| rust | gotham | 8.22 ms | **7.85** ms | 13.21 ms | 20.05 ms  | 116.63 ms  | 4625.00 | 119323.67 | 16.20 Mb |
| crystal | router.cr | 8.28 ms | **7.88** ms | 12.03 ms | 18.13 ms  | 42.40 ms  | 3135.33 | 118946.67 | 7.41 Mb |
| java | act | 12.93 ms | **7.94** ms | 16.79 ms | 166.23 ms  | 667.04 ms  | 38101.33 | 107739.00 | 12.32 Mb |
| scala | akkahttp | 214.39 ms | **8.21** ms | 54.65 ms | 4933.73 ms  | 7948.47 ms  | 861659.67 | 58301.67 | 8.30 Mb |
| ruby | agoo | 12.00 ms | **8.27** ms | 19.49 ms | 92.93 ms  | 125.58 ms  | 15071.67 | 106254.67 | 4.07 Mb |
| crystal | raze | 8.90 ms | **8.51** ms | 12.97 ms | 19.09 ms  | 45.53 ms  | 3380.00 | 110770.33 | 6.90 Mb |
| crystal | kemal | 9.14 ms | **8.62** ms | 13.58 ms | 21.29 ms  | 48.47 ms  | 3707.33 | 107993.33 | 11.70 Mb |
| nim | jester | 9.82 ms | **8.69** ms | 13.63 ms | 24.59 ms  | 408.35 ms  | 10873.33 | 115394.00 | 15.37 Mb |
| crystal | spider-gazelle | 10.05 ms | **9.29** ms | 15.72 ms | 26.34 ms  | 71.15 ms  | 4854.33 | 97936.67 | 6.93 Mb |
| crystal | amber | 10.56 ms | **9.88** ms | 15.88 ms | 24.50 ms  | 54.80 ms  | 4433.33 | 94338.67 | 11.45 Mb |
| crystal | orion | 10.68 ms | **9.94** ms | 16.52 ms | 26.93 ms  | 50.89 ms  | 4896.67 | 93712.67 | 10.15 Mb |
| go | gorouter | 12.43 ms | **10.45** ms | 22.41 ms | 49.50 ms  | 228.05 ms  | 11760.00 | 86335.00 | 7.62 Mb |
| go | echo | 13.10 ms | **10.72** ms | 23.92 ms | 52.96 ms  | 396.55 ms  | 14186.00 | 83361.00 | 9.70 Mb |
| go | chi | 12.67 ms | **10.74** ms | 22.31 ms | 49.68 ms  | 269.09 ms  | 12060.00 | 84198.67 | 7.47 Mb |
| php | slim | 74.96 ms | **10.78** ms | 216.33 ms | 931.44 ms  | 7206.43 ms  | 281942.00 | 41232.33 | 13.55 Mb |
| php | zend-expressive | 79.99 ms | **10.96** ms | 226.68 ms | 1003.63 ms  | 7229.02 ms  | 314404.67 | 40287.33 | 13.25 Mb |
| go | gin | 15.13 ms | **11.04** ms | 24.36 ms | 106.30 ms  | 690.08 ms  | 31479.33 | 81695.00 | 9.50 Mb |
| go | violetear | 12.66 ms | **11.19** ms | 21.11 ms | 47.22 ms  | 321.18 ms  | 10747.33 | 82390.00 | 7.25 Mb |
| go | gorilla-mux | 13.64 ms | **11.36** ms | 25.82 ms | 56.60 ms  | 320.67 ms  | 12467.67 | 78883.67 | 6.99 Mb |
| node | 0http | 28.66 ms | **11.38** ms | 19.66 ms | 618.57 ms  | 1417.83 ms  | 104121.33 | 78441.33 | 7.79 Mb |
| csharp | aspnetcore | 28.56 ms | **11.41** ms | 18.01 ms | 587.65 ms  | 1214.81 ms  | 103121.67 | 79142.67 | 8.54 Mb |
| rust | actix-web | 12.43 ms | **11.46** ms | 20.63 ms | 35.56 ms  | 88.84 ms  | 6890.33 | 87444.00 | 8.35 Mb |
| go | beego | 13.90 ms | **11.52** ms | 25.09 ms | 63.51 ms  | 268.38 ms  | 13713.67 | 79302.00 | 7.07 Mb |
| go | kami | 13.13 ms | **11.56** ms | 22.04 ms | 55.20 ms  | 170.21 ms  | 10203.00 | 80509.00 | 7.10 Mb |
| node | polkadot | 27.77 ms | **11.69** ms | 21.57 ms | 590.86 ms  | 1346.22 ms  | 97090.00 | 75188.67 | 7.47 Mb |
| php | zend-framework | 75.41 ms | **11.99** ms | 251.18 ms | 774.80 ms  | 7240.19 ms  | 231730.00 | 37307.33 | 12.27 Mb |
| php | lumen | 72.85 ms | **12.18** ms | 238.71 ms | 674.34 ms  | 7177.64 ms  | 236916.00 | 35632.67 | 12.29 Mb |
| php | symfony | 80.75 ms | **12.79** ms | 252.57 ms | 942.80 ms  | 6065.13 ms  | 260139.33 | 36364.00 | 11.97 Mb |
| node | restana | 41.12 ms | **12.87** ms | 24.40 ms | 857.74 ms  | 1710.49 ms  | 145702.67 | 68214.67 | 6.77 Mb |
| go | gf | 15.88 ms | **13.37** ms | 29.54 ms | 66.17 ms  | 379.28 ms  | 15609.67 | 68568.33 | 6.89 Mb |
| node | polka | 39.81 ms | **14.36** ms | 26.73 ms | 872.90 ms  | 1776.32 ms  | 140881.00 | 60457.00 | 6.00 Mb |
| node | rayo | 32.22 ms | **14.56** ms | 26.44 ms | 640.49 ms  | 1466.96 ms  | 104688.67 | 58956.67 | 5.85 Mb |
| python | falcon | 16.68 ms | **14.63** ms | 25.02 ms | 44.06 ms  | 368.16 ms  | 11147.67 | 60699.33 | 9.43 Mb |
| kotlin | ktor | 22.73 ms | **14.75** ms | 33.52 ms | 303.32 ms  | 755.61 ms  | 55332.33 | 63932.67 | 6.61 Mb |
| node | muneem | 61.83 ms | **16.41** ms | 35.90 ms | 1314.30 ms  | 2317.00 ms  | 216030.33 | 52677.67 | 5.23 Mb |
| node | foxify | 59.28 ms | **16.68** ms | 33.71 ms | 1153.36 ms  | 2190.23 ms  | 198600.33 | 51014.67 | 7.11 Mb |
| node | fastify | 65.04 ms | **16.76** ms | 36.96 ms | 1402.85 ms  | 2426.31 ms  | 229097.67 | 53710.67 | 9.18 Mb |
| php | laravel | 114.43 ms | **16.92** ms | 384.49 ms | 1185.89 ms  | 7667.64 ms  | 331930.33 | 27201.33 | 9.44 Mb |
| swift | perfect | 17.07 ms | **16.95** ms | 19.40 ms | 22.52 ms  | 235.29 ms  | 6782.67 | 57739.67 | 3.60 Mb |
| scala | http4s | 29.77 ms | **17.24** ms | 33.75 ms | 418.70 ms  | 1754.60 ms  | 96688.33 | 50558.00 | 5.88 Mb |
| python | bottle | 23.01 ms | **17.30** ms | 37.39 ms | 88.75 ms  | 253.38 ms  | 15824.67 | 46735.33 | 7.63 Mb |
| node | koa | 89.10 ms | **18.58** ms | 40.67 ms | 1769.82 ms  | 2936.65 ms  | 302593.67 | 46295.33 | 6.50 Mb |
| python | blacksheep | 21.47 ms | **20.30** ms | 30.25 ms | 40.56 ms  | 83.66 ms  | 6497.33 | 46172.67 | 6.29 Mb |
| php | hyperf | 22.64 ms | **20.44** ms | 39.91 ms | 68.93 ms  | 211.13 ms  | 13858.33 | 45084.33 | 6.37 Mb |
| swift | vapor | 79.55 ms | **21.53** ms | 55.62 ms | 1746.82 ms  | 4337.01 ms  | 303946.00 | 37335.67 | 4.14 Mb |
| python | starlette | 23.96 ms | **22.25** ms | 38.96 ms | 54.73 ms  | 110.08 ms  | 10065.00 | 41642.00 | 5.95 Mb |
| python | hug | 28.06 ms | **23.52** ms | 43.95 ms | 84.06 ms  | 410.93 ms  | 16838.67 | 36208.33 | 5.95 Mb |
| node | express | 101.59 ms | **23.86** ms | 138.79 ms | 1732.17 ms  | 2926.99 ms  | 309269.33 | 35107.33 | 5.70 Mb |
| node | restify | 46.69 ms | **24.79** ms | 43.73 ms | 774.47 ms  | 1697.60 ms  | 124940.00 | 35321.33 | 4.11 Mb |
| java | spring-boot | 87.92 ms | **27.04** ms | 65.24 ms | 1594.16 ms  | 2644.93 ms  | 265311.67 | 31161.00 | 1.72 Mb |
| swift | kitura | 29.85 ms | **27.68** ms | 33.20 ms | 74.99 ms  | 1021.09 ms  | 34602.33 | 36005.00 | 4.44 Mb |
| crystal | onyx | 31.43 ms | **30.96** ms | 40.74 ms | 50.42 ms  | 73.20 ms  | 7188.33 | 31440.33 | 5.36 Mb |
| swift | kitura-nio | 93.56 ms | **32.03** ms | 57.88 ms | 1950.45 ms  | 4249.48 ms  | 342426.33 | 27588.00 | 3.46 Mb |
| crystal | lucky | 32.50 ms | **32.36** ms | 38.05 ms | 43.99 ms  | 465.61 ms  | 14515.67 | 30865.67 | 2.51 Mb |
| php | swoft | 45.27 ms | **34.04** ms | 80.02 ms | 182.30 ms  | 334.52 ms  | 32104.00 | 23819.00 | 4.15 Mb |
| node | hapi | 242.42 ms | **34.06** ms | 532.77 ms | 3674.19 ms  | 5232.33 ms  | 696424.33 | 24644.67 | 4.25 Mb |
| node | turbo_polka | 35.66 ms | **35.21** ms | 38.20 ms | 43.74 ms  | 580.73 ms  | 18855.33 | 27875.33 | 1.74 Mb |
| node | moleculer | 205.00 ms | **36.24** ms | 371.03 ms | 3261.80 ms  | 4978.32 ms  | 599169.00 | 23568.67 | 2.67 Mb |
| python | fastapi | 38.16 ms | **37.34** ms | 51.99 ms | 66.88 ms  | 483.35 ms  | 18211.00 | 25722.67 | 3.68 Mb |
| python | molten | 53.81 ms | **49.34** ms | 73.86 ms | 113.00 ms  | 727.46 ms  | 27872.00 | 18729.00 | 2.31 Mb |
| python | aiohttp | 56.01 ms | **51.89** ms | 87.46 ms | 125.24 ms  | 182.88 ms  | 23535.33 | 17826.00 | 2.68 Mb |
| crystal | athena | 67.50 ms | **54.66** ms | 58.60 ms | 573.69 ms  | 756.31 ms  | 82466.67 | 18140.67 | 1.51 Mb |
| python | flask | 62.57 ms | **56.60** ms | 78.28 ms | 190.33 ms  | 1073.30 ms  | 46737.00 | 16186.33 | 2.64 Mb |
| python | bocadillo | 60.20 ms | **58.69** ms | 80.58 ms | 122.42 ms  | 419.36 ms  | 22476.67 | 16397.33 | 2.10 Mb |
| python | sanic | 68.44 ms | **66.03** ms | 100.71 ms | 139.87 ms  | 402.58 ms  | 26855.33 | 14105.67 | 1.67 Mb |
| python | quart | 99.04 ms | **96.05** ms | 152.14 ms | 193.02 ms  | 425.62 ms  | 38774.33 | 9875.67 | 1.31 Mb |
| python | responder | 119.47 ms | **119.20** ms | 177.68 ms | 208.12 ms  | 547.60 ms  | 46545.33 | 8143.00 | 1.18 Mb |
| python | django | 163.27 ms | **135.06** ms | 158.00 ms | 1384.58 ms  | 3421.20 ms  | 228509.00 | 7098.67 | 1.37 Mb |
| python | masonite | 174.33 ms | **165.22** ms | 191.71 ms | 768.21 ms  | 1968.68 ms  | 120380.00 | 5808.00 | 0.95 Mb |
| python | tornado | 196.78 ms | **173.73** ms | 237.45 ms | 1149.40 ms  | 2931.78 ms  | 187778.00 | 5302.67 | 1.04 Mb |
| python | cyclone | 320.53 ms | **220.65** ms | 271.75 ms | 4194.62 ms  | 7209.00 ms  | 667385.67 | 2867.67 | 0.52 Mb |

## How to contribute ?

In any way you want ...

+ Request a framework addition
+ Report a bug (on any implementation)
+ Suggest an idea
+ ...

Any kind of idea is :heart:

## Contributors

- [Taichiro Suzuki](https://github.com/tbrand) - Author | Maintainer
- [OvermindDL1](https://github.com/OvermindDL1) - Maintainer
- [Marwan Rabbâa](https://github.com/waghanza) - Maintainer
