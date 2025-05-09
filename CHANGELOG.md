# Changelog

## 1.10.2

* CVE-2025-46727 Unbounded parameter parsing in Rack::QueryParser can lead to memory exhaustion.

## 1.10.1

* CVE-2025-27610 Local file inclusion in Rack::Static.
* CVE-2025-27111 Possible Log Injection in Rack::Sendfile.
* CVE-2025-25184 Possible Log Injection in Rack::CommonLogger.

## 1.10.0

* Switch back to Ruby 3.3 by adding rubygems-generate_index
* Bump puma to 6.5.0

## 1.9.1

* Update puma to 6.4.3

## 1.9.0

* Lower Ruby version because in 3.3 the rubygems/indexer.rb file is missing

## 1.8.1

* Update rack to 2.2.8.1 for CVE-2024-26146, CVE-2024-25126, CVE-2024-26141

## 1.8.0

* Update docker image to 3.3

## 1.7.2

* Update puma 6.4.2

## 1.7.1

* Update puma 6.3.1

## 1.7.0

* Update puma 6.1.1
* Update rack (CVE-2023-27530)

## 1.6.1

* Update gems

## 1.6.0

* Update puma 6.0.0
* Update sinatra (CVE-2022-36359)

## 1.5.1

* Update rack (CVE-2022-30123)

## 1.5.0

* Update puma (CVE-2022-24790)

## v1.4.0

* Update Puma (CVE-2022-23634)

## v1.3.0

* Update Puma (CVE-2021-41136)

## v1.2.0

* Use Puma as handler

## v1.1.0

* Bump to ruby version 3.0

## v1.0.3

* Update gems

## v1.0.2

* Update gems with security fixes
* Bump to ruby version 2.7

## v1.0.1

* Update gems

## v1.0.0

* Initial release
