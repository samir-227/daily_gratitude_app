# AGENTS.md — WhatsApp First Order Manager

## Commands
```
flutter pub get          # install deps
flutter analyze          # lint + static analysis
flutter test             # run all tests
flutter test test/<file> # run single test
flutter run -d "iPhone 15"  # run on iOS simulator
```
Order: `analyze → test` before any commit.

## Architecture
- Clean Architecture: `presentation → domain → data` — never bypass layers or mix responsibilities
- Feature folders: `lib/features/{feature}/data|domain|presentation/`
- Shared code: `lib/core/` (utils, DI, errors, theme, router, extensions) and `lib/shared/` (models, widgets)
- Entry point: `lib/main.dart` — calls `setupDependencies()` then `runApp(MyApp())`
- DI: `get_it` via `sl` singleton, all registrations in `lib/core/di/injection.dart`
- Navigation: `go_router` in `lib/core/router/app_router.dart` — ShellRoute wraps Dashboard/Orders/Catalog/Customers

## State Management
- **Cubit only** (flutter_bloc). No Riverpod, Provider, or GetX.
- Cubits depend ONLY on use cases or repositories — never on data sources.
- States: use plain `abstract class` hierarchies (no Freezed, no codegen).
- `setState` only for local UI state (toggles, focus) — never business logic. Scope to smallest widget.
- All cubits are registered in `MultiBlocProvider` in `main.dart` and resolved via `sl<>()`.

## Error Handling
- Domain returns `Either<Failure, T>` (dartz package).
- Typed failures: `ServerFailure`, `NetworkFailure`, `AuthFailure`, `CacheFailure` in `lib/core/errors/failures.dart`.
- Data layer catches exceptions and maps to `Failure` — never let raw exceptions escape.
- Presentation maps failures to Arabic user-facing messages.
- Handle null, empty, loading, and error states explicitly — no silent failures.

## Critical Constraints
- **Cupertino only** — zero Material widgets. All UI uses `CupertinoTextField`, `CupertinoAlertDialog`, etc.
- **RTL always** — entire app wrapped in `Directionality(textDirection: TextDirection.rtl)`.
- **Domain layer purity** — NO `package:flutter/` imports in any `domain/` file.
- **No code generation** — no `build_runner`, no Freezed. Use Dart 3 sealed classes, records, switch expressions.
- **Supabase backend** — datasources use `SupabaseClient` directly (injected via get_it).
- **⚠️ Security**: Supabase URL and anon key are currently hardcoded in `lib/core/constants/app_constants.dart`. Never commit real keys; flag this if touched.

## Build Method Discipline
- Prefer `const` constructors wherever possible.
- NEVER create `TextEditingController`, `AnimationController`, `FocusNode` inside `build()` — instantiate in `initState()` or as `late final` fields.
- Dispose all controllers and focus nodes in `dispose()`.
- Use `BlocBuilder`/`BlocSelector` on the smallest widget that needs state — never at the top of the tree.
- Avoid heavy work inside `build()`.

## Shared Code
- Reusable logic used in 2+ places goes in `lib/core/`.
- Check `core/` before creating new shared code — never duplicate across features.

## Change Discipline
- Make the smallest change that solves the problem.
- Read relevant code before modifying — state assumptions when unclear.
- Never break existing functionality, APIs, flows, or UX unless explicitly instructed.

## Testing
- Framework: `flutter_test` with `mocktail` and `bloc_test`.
- Tests live in `/test/`. Existing: `smart_order_parser_test.dart`, `message_template_test.dart`, `widget_test.dart`.
- Bug fixes must include a reproducing test.
- Tests must be deterministic — no flaky or timing-dependent tests.
- One behavior per test case.

## Workflow
- Before marking task done → run `/code-review` skill.
- After approval → run `/create-pr` skill for branch, commit, and PR.
- PR descriptions in markdown.
