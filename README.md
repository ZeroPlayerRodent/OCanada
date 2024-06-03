# OCanada
![screenshot-1](https://github.com/ZeroPlayerRodent/OCanada/blob/main/OCanada_Logo.png)

OCanada is a programming language with syntax inspired by Canadian slang, eh?

It functions similarly to Lisp or Ruby, so if you know those languages you should be able to learn OCanada pretty easily, eh?

# Examples

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
