Step 3: Dart ecosystem
======================

**Estimated time**: 1 day

These steps describe the common [Dart] tooling, packages and ecosystem approaches, proven to be especially useful and commonly used when building modern modular [Dart] applications.




## Project structure

> The Dart ecosystem uses _packages_ to manage shared software such as libraries and tools. To get Dart packages, you use the **pub package manager**. You can find publicly available packages on the [pub.dev site][pub.dev], or you can load packages from the local file system or elsewhere, such as Git repositories. Wherever your packages come from, pub manages version dependencies, helping you get package versions that work with each other and with your SDK version.
> 
> Most [Dart-savvy IDEs][11] offer support for using pub that includes creating, downloading, updating, and publishing packages. Or you can use [`dart pub` on the command line][12].

[Dart] project represents a [Dart] package when it has a [`pubspec.yaml`] manifest file.
```yaml
name: task
description: A sample command-line application.
version: 1.0.0
# repository: https://github.com/my_org/my_repo

environment:
  sdk: ^3.0.2

# Add regular dependencies here.
dependencies:
  # path: ^1.8.0

# Add development dependencies here.
dev_dependencies:
  lints: ^2.0.0
  test: ^1.21.0
```

> To import libraries found in packages, use the `package:` prefix:
> ```dart
> import 'package:js/js.dart' as js;
> import 'package:intl/intl.dart';
> ```

The initial files layout of a [Dart] project looks like this:
```
lib/
├── ...
└── main.dart
pubspec.yaml
```
However, real-world [Dart] projects, depending on their needs, may also include a `test/` directory for [unit testing][13], an `example/` directory providing usage examples (if it's a library), and [other similar ones][16].

To learn more about packages, dependencies and project structure in [Dart], read through the following articles:
- [Dart Guides: How to use packages][14]
- [Dart Guides: Creating packages][15]
- [Dart Docs: Package layout conventions][16]
- [Dart Docs: Package dependencies][17]




## Tooling

When it comes to sharing [Dart] code with anyone, it's necessary to follow some core guidelines in order for the source code to be readable and consistent in its style. Such core guidelines in [Dart] are called [Effective Dart].

[Dart] provides several [CLI tools][20] for maintaining project source code and helping following project guidelines.


### Formatter

[`dart format`] tool formats source code according to [Effective Dart] style.

However, this tool is not as smart as it could be. In order for it to format the code in a more readable and beautiful way, [`dart format`] relies [on commas][21].

For better understanding of [`dart format`] purpose, capabilities and usage, read through the following articles:
- [Dart Tools: `dart format`][`dart format`]
- [Dart Tools: Code formatting][21]
- [Official `dart_style` package docs][`dart_style`]
- [Official `dart_style` package FAQ][22]


### Analyzer

[`dart analyze`] tool uses the [`analyzer`] package to perform the basic source code [static analysis][32] and to [lint][33] it against [Effective Dart] guidelines or any other custom code style rules.

For better understanding of [`dart analyze`] purpose, capabilities and usage, read through the following articles:
- [Dart Tools: `dart analyze`][`dart analyze`]
- [Dart Guides: Customizing static analysis][31]
- [Official `analyzer` package docs][`analyzer`]


### Documentation

[`dart doc`] tool uses the [`dartdoc`] package to generates an [HTML] documentation right from the project source code.

For better understanding of [`dart doc`] purpose, capabilities and usage, read through the following articles:
- [Dart Tools: `dart doc`][`dart doc`]
- [Dart Docs: Documentation comments][41]
- [Effective Dart: Documentation][42]
- [Official `dartdoc` package docs][`dartdoc`]




## Task

Create a [Dart] package (`dart create -t package task`) implementing a simple `Calculator` class having `sum`, `subtract`, `multiply` and `divide` methods.
- Use [`dart format`] to format the code.
- Configure the [`analyzer`] package and use [`dart analyze`].
- Generate its [API] documentation using [`dart doc`].




## Questions

After completing everything above, you should be able to answer (and understand why) the following questions:
- What is pub? What it does? Why do we need it?
  pub is Dart’s package and dependency manager.
  It installs, updates, and runs project dependencies automatically, ensuring your Dart app or package is easy to build, share, and maintain.
- What is pub spec? Which purpose does it serve?
  pubspec.yaml is the heart of every Dart project — it declares your app’s name, environment, dependencies, and build configuration.
  It allows the pub tool to install, manage, and build your project consistently.
- What is the purpose of `pubspec.lock` file? When and why it should be stored in [VCS], and when not? 
  pubspec.lock locks your dependencies to exact versions for stable, repeatable builds.
  Commit it for apps, ignore it for packages — that’s the Dart ecosystem standard.
- What does "version range" mean? How is it useful for dependencies?
  A version range specifies which versions of a dependency your Dart project can accept.
  It gives you the balance between stability (avoiding breaking changes) and flexibility (allowing safe updates).
- Where is pub able to get dependencies from?
  pub can fetch dependencies from pub.dev, local paths, Git repositories, custom hosted servers, or the Dart/Flutter SDK — giving you flexibility to manage both public and private packages efficiently.
- What is the difference between development dependencies and regular one? Which ones should be used and when?
  Regular dependencies are needed when your app runs.
  Development dependencies are needed when your app is built, tested, or analyzed.
  Use each appropriately to keep your build lightweight, faster, and clean.
- How [Dart] projects are structured in files? Which are common conventions and what for?
  Dart projects follow a standard file and folder structure (lib/, bin/, test/, etc.) to keep code organized, testable, and reusable.
  This convention helps both tools and developers work seamlessly across projects in the Dart ecosystem.
- What do we need [Effective Dart] for? Why is it vital?
  Effective Dart is like good manners for Dart developers — it keeps your code neat, consistent, and easy to work with, no matter who joins the project.
- What is `dart format` used for? What are the benefits of using it?
  dart format automatically makes your code follow Dart’s official style.
  It keeps your project consistent, readable, and professional — while saving you time and avoiding team arguments about formatting.
- How commas are used to guide code formatting in [Dart]?
  Commas in Dart — especially trailing commas — guide how the formatter arranges your code into clean, multi-line structures.
  They make your code more readable, consistent, and effortless to maintain — especially in large widget trees or function calls.
- What is static analysis? What is linting? How they are represented in [Dart]? Why should we use them?
  Static analysis means checking your code without running it — the Dart analyzer looks at your code and finds potential problems early.
  It analyzes your program’s structure, types, and syntax to catch errors before runtime.
  Linting is a special kind of static analysis focused on style, readability, and best practices rather than correctness.
  It’s about how you write code, not just whether it works.
  Together, they keep your codebase reliable, readable, and professional — the backbone of high-quality Dart development.
- Why source code documentation matters? How is it represented in [Dart]?
  Source code documentation explains why and how your code works.
  In Dart, it’s written using triple-slash /// comments and processed by tools like DartDoc.
  It’s vital because it turns your code from “just working” into something understandable, teachable, and maintainable.
- Which are good practices for documenting code and [API]s in [Dart]? 
  In Dart, use /// comments to document what your code does and why.
  Keep docs short, consistent, and accurate; link related symbols with [brackets]; and focus on public APIs.
  Good documentation turns code into something anyone can understand — even months or years later.
- How can one publish and serve [API] documentation in [Dart]? 
  In Dart, you generate API documentation using dart doc, which creates HTML files from your /// comments.
  You can view it locally, publish it automatically on pub.dev, or host it yourself (e.g., GitHub Pages).
  It’s an easy way to turn your code into a clear, navigable reference site — no extra tools needed.





[`analyzer`]: https://pub.dev/packages/analyzer
[`crypto`]: https://pub.dev/packages/crypto
[`dart analyze`]: https://dart.dev/tools/dart-analyze
[`dart doc`]: https://dart.dev/tools/dart-doc
[`dart format`]: https://dart.dev/tools/dart-format
[`dart_style`]: https://pub.dev/documentation/dart_style
[`dartdoc`]: https://pub.dev/documentation/dartdoc
[`pubspec.yaml`]: https://dart.dev/tools/pub/pubspec
[API]: https://en.wikipedia.org/wiki/API
[Dart]: https://dart.dev
[Effective Dart]: https://dart.dev/guides/language/effective-dart
[Flutter]: https://flutter.dev
[HTML]: https://en.wikipedia.org/wiki/HTML
[pub.dev]: https://pub.dev
[VCS]: https://en.wikipedia.org/wiki/Version_control

[11]: https://dart.dev/tools#ides-and-editors
[12]: https://dart.dev/tools/pub/cmd
[13]: https://en.wikipedia.org/wiki/Unit_testing
[14]: https://dart.dev/guides/packages
[15]: https://dart.dev/guides/libraries/create-library-packages
[16]: https://dart.dev/tools/pub/package-layout
[17]: https://dart.dev/tools/pub/dependencies
[20]: https://dart.dev/tools/dart-tool
[21]: https://docs.flutter.dev/tools/formatting#using-trailing-commas
[22]: https://github.com/dart-lang/dart_style/wiki/FAQ
[31]: https://dart.dev/guides/language/analysis-options
[32]: https://en.wikipedia.org/wiki/Static_program_analysis
[33]: https://en.wikipedia.org/wiki/Lint_(software)
[41]: https://dart.dev/language/comments#documentation-comments
[42]: https://dart.dev/effective-dart/documentation
