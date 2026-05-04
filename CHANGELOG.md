# Changelog

## [0.10.0] - 2026-05-04

### Breaking Changes

- Migrate AFS 1.0 to Captcha 2.0 (VerifyIntelligentCaptcha)
  - `call_afs/2` removed, use `call_captcha/2` instead
  - Config key `:afs` renamed to `:captcha`
  - Old endpoint `afs.aliyuncs.com` (version 2018-01-12) replaced by `captcha.cn-shanghai.aliyuncs.com` (version 2023-03-05)
  - Request params changed: `CaptchaVerifyParam` replaces `Token`/`Sig`/`SessionId`
  - Unified action `VerifyIntelligentCaptcha` replaces `AuthenticateSig`/`AnalyzeNvc`
  - Added captcha request/response typespecs for better documentation

### Features

- Upgrade dependencies, migrate to Tesla runtime configuration ([`42310d7`](https://github.com/alchemists-elixir/ex_aliyun_openapi/commit/42310d7))
- Add CI workflow with GitHub Actions ([`42310d7`](https://github.com/alchemists-elixir/ex_aliyun_openapi/commit/42310d7))
- Add dedicated test suite and improve test coverage to 100% ([`516bc11`](https://github.com/alchemists-elixir/ex_aliyun_openapi/commit/516bc11))

### Bug Fixes

- Remove unmaintained `timex` dependency ([`8a27706`](https://github.com/alchemists-elixir/ex_aliyun_openapi/commit/8a27706))
- Resolve stale documentation links ([`ed12821`](https://github.com/alchemists-elixir/ex_aliyun_openapi/commit/ed12821), [`7f47f27`](https://github.com/alchemists-elixir/ex_aliyun_openapi/commit/7f47f27))
