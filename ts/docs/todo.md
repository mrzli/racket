- each file should have an 'output' variable, with a value of some string, and that will be written to the a file inside examples/my-project/result



- you can implement reader/expander like this
  - ts code will produce a syntax tree
  - the node in each tree will be expanded to something like
    (n 'binary-expression (n 'numeric-literal 2) '+ (n 'numeric-literal 3))
  - racket code inside the node will be left as is, and will be expected to return the same thing as an 'n' expression, meaning a node for the final syntax tree to be used for generating the output
    - racket code can generate a list of nodes
      - have this be a separate function, like n-list, or just an 'n' with a special flag, such as 'quasi-list, or 'fragment or 'container, or whatever, provided it cannot be confused with an actual typescript node
    - racket code can switch back to typescript mode, this needs to be handled by the reader



- lexer
  - comment
    - single line
    - multi line
  - identifier
  - numeric literal
  - string literal
    - single quote
    - double quote
  - template literal
    - no interpolation
    - interpolation
      - template head
      - template middle
      - template tail
  - punctuator

- comment
  - single line
    - //
    - followed by 0 or more characters until the next \n or EOF
  - multi line
    - /*
    - followed by 0 or more characters
    - followed by */
- identifier
  - starts with
    - $ or _ or a-z or A-Z
  - can be followed by 0 or more
    - the above or 0-9
- number
  - hex
    - starts with 0x
    - digits 0-9, a-f, A-F
  - octal
    - starts with 0o
    - digits 0-7
  - binary
    - starts with 0b
    - digits 0-1
  - decimal
    - 0 or 1-9 followed by 0 or more digits 0-9
    - optional decimal point followed by 1 or more digits 0-9
    - optional exponent part
      - e or E
      - optional sign
        - + or -
      - 1 or more digits 0-9
  - can have underscores in between digits
    - not at the beginning or end
    - not consecutive


- state machine
  - expression-start
  - punctuator-start