# OCanada
![OCanada Logo](https://github.com/ZeroPlayerRodent/OCanada/blob/main/OCanada_Logo.png)

OCanada is a general-purpose programming language with syntax inspired by Canadian slang, eh?

With functions and keywords named after `hosers`, `canucks` and `mounties`, OCanada provides the most authentic Canadian programming experience, eh?

It functions similarly to [Lisp](https://lisp-lang.org/) or [Ruby](https://www.ruby-lang.org/en/), so if you know those languages you should be able to learn OCanada pretty easily, eh?

## Examples

Here's some examples of OCanada code, eh?

Hello, World:
```
o_canada main []
  apologize "Hello, World!"
eh?

please main []
```

Recursive Factorial:
```
o_canada factorial [value]
  oot mountie[value 1]
    1
  aboot canuck
    (value * please factorial [(value - 1)])
  eh?
eh?

o_canada main []
  apologize please factorial [10]
eh?

please main []
```

Fibonacci Sequence:
```
o_canada fibonacci [times]
  syrup {numbers} [0 1]
  syrup {temp} 0
  syrup {i} 0
  play_hockey not mountie[{i} times]
    apologize loonie 0 {numbers}
    apologize puck 10
    syrup {temp} loonie 0 {numbers}
    syrup {numbers} tuque {numbers} loonie 0 {numbers}
    poutine {numbers}
    syrup loonie 0 {numbers} (loonie 0 {numbers} + {temp})
    syrup {i} ({i}+1)
  eh?
eh?

o_canada main []
  please fibonacci [99]
eh?

please main []
```
## Features

- Arbitrary precision integers and floats
- A built-in function for saving your programs as executables
- A standard library filled with useful utility functions
- Dynamic typing
- Eval function for metaprogramming shenanigans
- Local and global variables
- The ability to define custom structures

## Get Started!

How to set up OCanada:

1. Clone the OCanada repo to your local machine.
2. Compile OCanada by running `build.lisp` in [SBCL](https://www.sbcl.org/).
3. Keep the executable in the same directory as the `lib` and `programs` directories.
6. Type `./ocanada.exe programs/filename.canada` in your terminal to run a program.

Now that you have OCanada set up, refer to the [Language Specification](https://github.com/ZeroPlayerRodent/OCanada/blob/main/specification.txt) to learn how to write programs!
