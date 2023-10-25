#lang br/quicklang

(require jsonic/parser jsonic/tokenizer brag/support)

(parse-to-datum (apply-tokenizer-maker make-tokenizer "// line comment\n"))
(parse-to-datum (apply-tokenizer-maker make-tokenizer "@$ 42 $@"))
(parse-to-datum (apply-tokenizer-maker make-tokenizer "hi"))
(parse-to-datum (apply-tokenizer-maker make-tokenizer "hi\n// comment\n@$ 42 $@"))
