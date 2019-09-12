# Which is the fastest?

[![Build Status](https://travis-ci.com/the-benchmarker/web-frameworks.svg?branch=master)](https://travis-ci.com/the-benchmarker/web-frameworks)
[![Join the chat at https://gitter.im/which_is_the_fastest/Lobby](https://badges.gitter.im/which_is_the_fastest/Lobby.svg)](https://gitter.im/which_is_the_fastest/Lobby)

> DISCLAIMER : performance could mean several things, please see http://steve.vinoski.net/pdf/IEEE-The_Performance_Presumption.pdf for more information


<div align="center">
	<div>
		:warning::warning::warning::warning::warning::warning::warning::warnin
	</div>
	<div>
  		Results are not <b>production-ready</b> <i>yet</i>
	</div>
	<div>
		:warning::warning::warning::warning::warning::warning::warning::warning:
	</div>
</div>



## Motivation(s)

### Context

Web technologies are growing quickly. It is a _fair_ **reward** to promote the wonderful innovation in this `domain`. This pro




### Main goal

+ Helping decide between languages, depending on use case
+ Learning languages, best practices, devops culture ...
+ Having fun :heart:

### Additional purposes

## Why re-inventing the wheel ?

#### KISS
#### Community driven
#### Real-word


## Requirements


+ [Crystal](https://crystal-lang.org) as `built-in` tools are made in this language
+ [Docker](https://www.docker.com) as **frameworks** are `isolated` into _containers_
+ [wrk](https://github.com/wg/wrk) as benchmarking tool

:information_source: you need `wrk` **stable**

~~~sh
git clone --branch 4.1.0 https://github.com/wg/wrk
~~~

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

+ Make `neph` configuration, [neph](https://tbrand.github.io/neph) is a **make** replacement by the original author of this project

~~~sh
bin/make neph_config
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

<!-- Result from here -->
<!-- Result till here -->

## Can I contribute ?

In any way you want ...

+ Make an implementation, please start with [flagged ones](https://github.com/the-benchmarker/web-frameworks/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+label%3Astatus%3Aconsent-given+-label%3Astatus%3Apending-approval)
+ Request a framework addition
+ Report a bug (on any implementation)
+ Suggest an idea
+ ...

Any kind of idea is :heart:
