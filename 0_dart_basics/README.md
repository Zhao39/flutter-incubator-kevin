Step 0: Become familiar with Dart basics
========================================

**Estimated time**: 1 day

Read and firmly study the [Dart Overview], provided by the [Dart] team. Learn about the language basics (syntax, types, functions, classes, asynchronous programming).

Be sure to check out the [Effective Dart] guidelines for writing consistent [Dart] code.

Investigate the [Core Libraries] available in [Dart], and learn how to enable [Dart Packages] and dependencies to use in your [Dart] project. You may explore the [pub.dev] for community made packages.

To practice the theory you may pass the [Dart Cheatsheet].




## Questions

After completing the steps above, you should be able to answer (and understand why) the following questions:
- What runtime [Dart] has? Does it use a GC (garbage collector)?
  Dart has two main runtimes, depending on where it’s executed - Dart VM (JIT / AOT runtime), JavaScript Runtime
  Dart uses a Garbage Collector (GC)
- What is [Dart] VM? How [Dart] works natively and in a browser, and why?
  Dart uses its own runtime called the Dart VM, which runs Dart code directly on native platforms like Flutter or servers. In development it uses JIT for fast reloads, and in production it compiles AOT to native machine code for speed. In browsers, Dart is compiled to JavaScript, so it runs smoothly on any JS engine — giving it both native performance and web compatibility.
- What is JIT and AOT compilation? Which one [Dart] supports?
  JIT stands for Just-In-Time compilation, and AOT means Ahead-Of-Time compilation.
  With JIT, the code is compiled while the program is running — that’s great for development because it allows things like hot reload and quick iteration. You can make a change, and Dart compiles it instantly without restarting the app.
  AOT, on the other hand, compiles everything before the app runs — it turns Dart code into native machine code ahead of time. That gives much faster startup, better performance, and is what you want in production builds.
  Dart actually supports both — it uses JIT during development for flexibility, and AOT for production to get native speed.
- What statically typing means? What is a benefit of using it?
  Statically typing means that the type of each variable is known at compile time, not while the program is running. So, if you try to assign the wrong kind of value — like putting a string where a number is expected — the compiler catches it before the code even runs.
  The big benefit is early error detection and more reliable code. It also makes your code easier to understand and maintain, since the types tell you exactly what kind of data you’re working with. Plus, modern IDEs can give you better autocompletion and refactoring support when they know your types.
- What memory model [Dart] has? Is it single-threaded or multiple-threaded?
  Dart uses a single-threaded memory model by default — meaning all the code in one isolate runs in a single thread with its own memory. There’s no shared mutable state between isolates, which helps avoid common threading bugs like race conditions or deadlocks.
  But Dart can still run things in parallel using isolates — these are like lightweight, independent threads with their own memory heaps. They communicate by passing messages, not by sharing memory. So while each isolate is single-threaded, you can have multiple isolates running concurrently on different cores, which gives Dart safe parallelism without the complexity of shared-state multithreading.
- Does [Dart] has asynchronous programming? Parallel programming?
  Yep, Dart supports both asynchronous and parallel programming, but they work a bit differently.
  For asynchronous programming, Dart uses async/await and Futures, kind of like JavaScript’s Promises. This lets you run non-blocking tasks — for example, making API calls or reading files — without freezing the main thread.
  For parallel programming, Dart uses something called isolates. Each isolate has its own memory and event loop, so they can run truly in parallel on separate CPU cores. They don’t share memory — instead, they communicate by passing messages, which keeps things safe and avoids race conditions.
  So in short: async for concurrency (non-blocking tasks), and isolates for real parallelism.
- Is [Dart] OOP language? Does it have an inheritance?
  Yep, Dart is an object-oriented programming (OOP) language — everything in Dart is an object, even numbers and functions. It supports all the main OOP concepts like classes, objects, inheritance, polymorphism, and encapsulation.
  Dart uses single inheritance, meaning a class can only extend one other class, but it also supports mixins and interfaces to reuse code and share behavior across classes. So you can get the flexibility of multiple inheritance without the usual complexity.
  In short — yes, Dart is fully OOP, and inheritance is a big part of how you structure and organize code in it.

Once you're done, notify your mentor/lead in the appropriate [PR (pull request)][PR] (checkmark this step in [README](../README.md)), and he will examine what you have learned.




[Core Libraries]: https://dart.dev/guides/libraries
[Dart]: https://dart.dev
[Dart Cheatsheet]: https://dart.dev/codelabs/dart-cheatsheet
[Dart Overview]: https://dart.dev/overview
[Dart Packages]: https://dart.dev/guides/packages
[Effective Dart]: https://dart.dev/guides/language/effective-dart
[PR]: https://help.github.com/articles/github-glossary#pull-request
[pub.dev]: https://pub.dev
