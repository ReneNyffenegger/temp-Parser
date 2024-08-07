https://blog.reverberate.org/2013/07/ll-and-lr-parsing-demystified.html

http://parsingintro.sourceforge.net/


DFA = Deterministic Finite Automation

Shunting-yard algorithm: 
  A method for parsing mathematical expressions specified in infix notation.
  It can produce either
    - a postfix notation string, also known as Reverse Polish notation (RPN), or
    - an abstract syntax tree (AST). 


Chomsky hierarchy
----------------

  grammars
  --------
  Type-0  | all formal grammars. Can be recognized by a Turing machine | aka recursively enumerable or Turing-recognizable
  Type-1  | generate context-sensitive languages
  Type-2  | generate context-free languages. Can be recognized by a non-deterministic pushdown automaton.   its subset of deterministic context-free language—are the theoretical basis for the phrase structure of most programming languages, though their syntax also includes context-sensitive name resolution due to declarations and scope. Often a subset of grammars is used to make parsing easier, such as by an LL parser.
  Type-3  | generate "regular languages"
  
 Regular languages
 -----------------
 
     A regular language in the strict sense of the latter notion used in theoretical computer science
     (as opposed to many regular expressions engines provided by modern programming languages, which are augmented
     with features that allow recognition of languages that cannot be expressed by a classic regular expression). 

LL Parser
---------

  LL Parser includes both the recursive descent parser and non-recursive descent parser.
  Its one type uses backtracking while another one uses parsing table. Theses are top down parser.
     
LL vs LR
--------
  first letter (L) stands for Left to right
  second letters (L or R) stands for 'leftmost derivation' or 'rightmost derivation'
  
  LL                                               LR
  constructed in top down                          bottom up
  non-terminals are expanded.                      are compressed
  Starts with the start symbol(S).                 ends with start symbol
  Ends when stack used becomes empty.              Starts with empty stack
  Pre-order traversal of the parse tree.           Post-order traversal of the parser tree.
  Terminal is read after popping out of stack.  	 Terminal is read before pushing into the stack.
  It may use backtracking or dynamic programming.  It uses dynamic programming.
  LL is easier to write.                           LR is difficult to write.
  examples: LL(0), LL(1)                           LR(0), SLR(1), LALR(1), CLR(1)
    
    It may use backtracking or dynamic programming.  It uses dynamic programming.
    LL is easier to write.                           LR is difficult to write.
    examples: LL(0), LL(1)                           LR(0), SLR(1), LALR(1), CLR(1)


LR parsers can handle more grammars
LR parsers can also handle left recursion, which LL parsers cannot.

LL parsers can support regex-like operators in grammars
   This is a really nice advantage of LL, because grammars are often more readable with these rich
   grammar extensions. In practice this helps mitigate the more restrictive grammar rules of LL,
   since many things that you’d want left-recursion for you can use repetition operators instead.
   
   
The primary difference between how LL and LR parsers operate is
that an LL parser outputs a pre-order traversal of the parse tree and an LR parser outputs a post-order traversal.   
   
                                            | 1 + 2 * 3
                                            + ------------
LL parsing corresponds to Polish Notation,  | + 1 * 2 3  // Polish (prefix) expression; pre-order traversal.
   whereas
LR corresponds to Reverse Polish Notation.  | 1 2 3 * +  // Reverse Polish (postfix) expression; post-order traversal.  

****

There is no LL(0) Parser

LL(1) is what you need to build a recursive-descent parser. 

*****


During an LL parse, the parser continuously chooses between two actions:
   - Predict: Based on the leftmost nonterminal and some number of lookahead tokens, choose which production ought to be applied to get closer to the input string.
   - Match: Match the leftmost guessed terminal symbol with the leftmost unconsumed symbol of input.
   
In an LR parser, there are two actions:
   - Shift: Add the next token of input to a buffer for consideration.
   - Reduce: Reduce a collection of terminals and nonterminals in this buffer back to some nonterminal by reversing a production.   

Lookahead
----------
   LL and LR parsers are “on-line,” meaning that they can start producing output while they are still consuming input.

   But in many cases the tokens prior to a stream position do not contain enough information for the parser to know whether it should insert a rule or
   not (or if so, which rule it should insert). So the parser will “look ahead” in the stream to see what the next token(s) are before it makes a decision.
   When you see designations like LL(1), LR(0), etc. the number in parentheses is the number of tokens of lookahead.
   
   
   LL lookahead counts from the beginning of the rule’s tokens,
   whereas LR lookahead counts from the end.
   
   This gives LR parsers a huge advantage, because they get to see all of the rule’s tokens
   (and maybe some lookahead) before they have to commit to a decision, whereas LL parsers only get to see the first few tokens of the rule.
   
                                 +---- LL look ahead starts here
                                 |
                                 |             +--- LR look ahead starts here
                                 V             V
   token stream:     T1 T2 T3 T4 T5 ....    Tw Tx Ty Tz
                                |             |   
                                |  tokens     |
                                |  for rule R |
                                +-------------+


    This is why there is such a thing as an LR(0) parser, whereas an LL(0) parser would be impossible
    
    Since LR lookahead starts from the end of a rule, a LR(1) parser has strictly more information available
    to it when making a decision than an LL(1) parser. It follows that LR(1) parsers can parse strictly more grammars than LL(1)
    (modulo LL-only grammar extensions; see below). LR parsers can also handle left recursion, which LL parsers cannot.
    
    On the other hand, since LL parsers commit to what rule they are parsing before they parse that rule’s tokens,
    and LL parser knows the context of what it is parsing whenever it parses a token.
    While that is more difficult job (since they have less information to go on), it also leads to some important advantages.

***

LR(1) means that you can choose proper rule to reduce by knowing all tokens that will be reduced plus one token after them.
There are no problems with AND in boolean queries and in BETWEEN operation. The following grammar, for example is LL(1), and thus is LR(1) too:

   expr ::= and_expr | between_expr | variable
   and_expr ::= expr "and" expr
   between_expr ::= "between" expr "and" expr
   variable ::= x
   
I believe that the whole SQL grammar is even simpler than LR(1). Probably LR(0) or even LL(n).


----------------------------------------------------------------------------------------------------------
Existing parsers etc:
  minimal c parser (interpreter?)
     - https://github.com/ReneNyffenegger/c4
     - http://www.t3x.org/subc/index.html     ( SubC - Its internals are described in detail in the book "Practical Compiler Cosntruction" - http://www.t3x.org/reload/index.html - must be bought)

  Tutorials:
      - https://craftinginterpreters.com/contents.html
  




