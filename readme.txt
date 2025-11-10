{ Existing parsers with source code

  PowerShell:
    scheme-lisp
      - https://github.com/ReneNyffenegger/scheme-lisp/blob/master/chap02pwsh/Tokenizer.ps1
      - https://github.com/ReneNyffenegger/scheme-lisp/blob/master/chap02pwsh/Parser.ps1


}
{ Parsing problem

  Take a string of characters and produce an abstract syntax tree.

  Parsing takes as input a context-free grammar G and some input string of
  length n, and produces a parse tree for the string according to G, if one
  exists. 

  For industrial programming languages, the gold standard is the hand-written recursive-descent
  parser, which typically runs in time O(n) with a very small constant factor, independent of |G|
}


https://blog.reverberate.org/2013/07/ll-and-lr-parsing-demystified.html

http://parsingintro.sourceforge.net/


DFA = Deterministic Finite Automation

Shunting-yard algorithm: 
  A method for parsing mathematical expressions specified in infix notation.
  It can produce either
    - a postfix notation string, also known as Reverse Polish notation (RPN), or
    - an abstract syntax tree (AST). 


Powerfullness: {

  SLR(1) < LALR(1) < LR(1)          - But they all use the same production rulesw

     our conclusion is that
     even LR(k)—the most general of this family—is, on its own, not sufficiently general to capture
     the grammars of real industrial languages in a tractable manner.

}
{ ETL Family

   Ear, Tom, Leo

}
Chomsky hierarchy {
----------------

  grammars
  --------
  Type-0  | all formal grammars (i. e. the most general class of grammars).
          | Can be recognized by a Turing machine - aka recursively enumerable or Turing-recognizable
          |
  Type-1  | generate context-sensitive languages
          |
  Type-2  | generate context-free languages.; Can be recognized by a non-deterministic pushdown automaton.
          | its subset of deterministic context-free language—are the theoretical basis for the phrase structure of most programming languages,
          | though their syntax also includes context-sensitive name resolution due to declarations and scope.
          | Often a subset of grammars is used to make parsing easier, such as by an LL parser.
          |
  Type-3  | generate "regular languages"

  
  Regular languages
  -----------------
 
     A regular language in the strict sense of the latter notion used in theoretical computer science
    (as opposed to many regular expressions engines provided by modern programming languages, which are augmented
     with features that allow recognition of languages that cannot be expressed by a classic regular expression). 
     
}
{ CFG = Context Free Grammar 

  …

}
LR Parser  {
---------
  In 1965, Donald Knuth invented the LR parser (
     Left to Right,
     Rightmost derivation
  )

  The LR parser can recognize any deterministic context-free language in
  linear-bounded time.

  Rightmost derivation has very large memory requirements and implementing an
  LR parser was impractical due to the limited memory of computers at that time

  The study of modern bottom-up (shift/reduce) parsing was pioneered by Knuth , who
  first defined the LR(k) class of grammars. Subsequent work by DeRemer  and others
  led to refinements including the definition of
     - SLR(k) and
     - LALR(k) grammars,
  which are less expressive than LR(k) but which enable much more efficient parser generation,
  and inspired the initial development of popular parser generation tools such as
    - Yacc  and
    - Bison

  { LR(1) means....

   LR(1) means that you can choose proper rule to reduce by knowing all tokens that will be reduced plus one token after them.
   There are no problems with AND in boolean queries and in BETWEEN operation. The following grammar, for example is LL(1), and thus is LR(1) too:
   
      expr ::= and_expr | between_expr | variable
      and_expr ::= expr "and" expr
      between_expr ::= "between" expr "and" expr
      variable ::= x
      
    I believe that the whole SQL grammar is even simpler than LR(1). Probably LR(0) or even LL(n).

  }

  { Additional ambiguity

    Within the category of online bottom-up parsing, there remains the question of what restrictions
    we may place on the input grammar, beyond simple unambiguity

    Knuth’s LR(k) is a reasonable starting point

  }

}
LL Parser {
---------

  LL Parser includes both the recursive descent parser and non-recursive descent parser.
  Its one type uses backtracking while another one uses parsing table. Theses are top down parser.

  There is no LL(0) Parser

  LL(1) is what you need to build a recursive-descent parser. 

 (But nobody is using an LL parser…)

 { Is this the problem of LL parsers?

   When I write a parser that cares about arithmetic precedence - which I do, sometimes - the logic goes like this:

    - ah, there's the number one
    - a plus sign!
    - the number two! Sweet! That's 1+2! It's an expression!
    - a multiplication sign. Uh oh.
    - the number three. Hmm. Well, now we have a problem.
    - (hacky hacky swizzle swizzle) Ta da! 1+(2*3).

 }
     
}
{ ANTLR

  ANTLR  which supports a superset of LL(k) grammars,

}
LL vs LR {
--------

  first letter (L) stands for Left to right
  second letters (L or R) stands for 'leftmost derivation' or 'rightmost derivation'

 
  LL is Top Down
  LR is Buttom Up

    - In top-down parsing (LL), we require the online parser, with k symbols of
      lookahead, to emit the name of each production when its occurrence
      begins in the input
    - in bottom-up parsing (LR), it is emitted when its occurence ends. 

  It is fairly clear that top-down parsing is not sufficiently general for
  practical programming languages: even in simple cases such as binary
  operator- precedence grammars, one does not know whether one is parsing the
  production “E → E + E” or the production “E → E ×E” until after seeing the
  entirety of the first occurrence of E.

  
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


  { Two actions

   During an LL parse, the parser continuously chooses between two actions:
      - Predict: Based on the leftmost nonterminal and some number of lookahead
                 tokens, choose which production ought to be applied to get closer to
                 the input string.
      - Match  : Match the leftmost guessed terminal symbol with the leftmost
                 unconsumed symbol of input.
      
   In an LR parser, there are two actions:
      - Shift :  Add the next token of input to a buffer for consideration.
      - Reduce:  Reduce a collection of terminals and nonterminals in this
                 buffer back to some nonterminal by reversing a production.   

  }
  { Stackoverflow answer - https://softwareengineering.stackexchange.com/a/419370/3406

    SO NO ONE ACTUALLY USES LL PARSERS - They seem simple but usually introduce more problems than they solve. They are not practical for most languages.

    True LL parsers are fast and simple – but also completely unable to parse
    many interesting languages.

    Many real-world programming languages are in
    the LALR class, which is closely related to LR but can be parsed far more
    efficiently. 

    These different approaches like LL, LALR, LR are not just different
    algorithms, but they also correspond to a different set of languages that
    can be parsed.

    For example, let's consider arithmetic expressions with this simple grammar:
      
      Expr ::= Expr "+" Term;
      Expr ::= Term;
      Term ::= Term "*" Factor;
      Term ::= Factor;
      Factor ::= Var;
      Factor ::= Num;

   This grammar would turn the input x * 3 + 2 into the parse tree
   Expr(Term(Term(Factor(Var(x)), "*", Factor(Num(3))), "+",
   Term(Factor(Num(2)))).

   While LL(k) is able to recognize this language, it cannot produce the
   correct parse tree because it cannot handle left-recursive productions
   directly.
   Where an LL parser is used, this frequently requires substantial
   post-processing of the parse tree to get a useful representation of the
   input. Also, massaging the grammar to fit the limitations of LL is very
   tedious, though some parser generators can do this automatically. 

   And to be clear: LR also has some restrictions that the grammar needs to be written around.
   post-processing of the parse tree to get a useful representation of the
   input.


  }


}
LALR ( = «Look-ahead LR» or «look-ahead, left-to-right, rightmost derivation parser» ) {
---------------------------------------------------------------

  Generally, the LALR parser refers to the LALR(1) parser,
  just as the LR parser generally refers to the LR(1) parser.

  Similarly, there is an LALR(2) parser with two-token lookahead,
  and LALR(k) parsers with k-token lookup, but these are rare in actual use. 

  The LALR parser is based on the LR(0) parser,
     so it can also be denoted
        LALR(1) = LA(1)LR(0) (1 token of lookahead, LR(0))
           or more generally
        LALR(k) = LA(k)LR(0) (k tokens of lookahead, LR(0)).

  There is in fact a two-parameter family of LA(k)LR(j) parsers for all
  combinations of j and k, which can be derived from the LR(j + k) parser,[9]
  but these do not see practical use.

  An LALR parser is a simplified version of a -> canonical LR parser.

  The LALR parser was invented by Frank DeRemer in his 1969 PhD dissertation,
  Practical Translators for LR(k) languages,[
  -
  He showed that the
    - LALR parser has more language recognition power than the LR(0) parser,
    - while requiring the same number of states as the LR(0) parser for a
      language that can be recognized by both parsers.
  This makes the LALR parser a memory-efficient alternative to the LR(1) parser for languages that are LALR.

  It was also proven that there exist LR(1) languages that are not LALR
     - Despite this weakness, the power of the LALR parser is sufficient for
       many mainstream computer languages, including Java

   LALR parsers can be automatically generated from a grammar by an LALR parser
   generator such as Yacc or GNU Bison.

}
{ Recursive descent parsers

  The prevailing consensus is that automatic parser generation is not
  practical for real programming languages:
    - LALR parsers—and even
    - the more general LR parsers, 
  in many cases—are considered to be far too restrictive in the grammars they support,
  and moreover, LR parsers are often considered too inefficient in practice.
  -
  As a result, virtually all modern languages use recursive- descent parsers
  written by hand, a lengthy and error-prone process that dramatically
  increases the barrier to new programming language development.

   It is well- known that SLR and LALR, while being highly efficient in their
   implementation, fail to capture many natural constructs for which it is easy
   to write recursive descent parsers by hand.


  { Lookahead

    Recursive descent parsers for usable languages hardly ever turn out to be
    perfectly LL(1) and often involve multiple lookahead tokens, backtracking,
    or some kind of bottom-up component in the form of precedence climbing or
    something similar.


  }

}
SLR - Simple LR Parser {
----------------------

}
{ BNF

  ? BNF is used for top-down grammars?

}
{ Specifying Grammars, EBNF, PEG

   PEG is a different way of specifying grammars and an different process for parsing them. If you're used to Bison/Yacc or LALR parsers modeled on Yacc (like Racc), the big things you notice with any PEG parser are:
     - You automatically get "EBNF"-style operators like "zero-or-more" or
       "one-or-more" instead of having to specify recursive nonterminals and
       epsilons.
     - You typically don't need a separate lexer; PEG parser productions
       resemble regular expressions.
     - PEGs use prioritized choice to deal with ambiguities such as
       dangling-else. PEG grammars are unambiguous.
   PEG parsers are much easier to build and work with than Yacc-style parsers. The learning curve on PEG is also way, way shorter than for shift-reduce parsers. You should probably be using PEG parsers whenever possible now.


}
Lookahead {
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

}
{ Predictive parsers

  A predictive parser is a type of top-down parser that constructs the parse
  tree without backtracking. Here are the key aspects of predictive parsers:

}
{ Grammar

  
  An unrestricted grammar G is a quadruple G = (V, T, S, P) where

    V is a finite set of (meta)symbols, or variables.  (sometimes also designated as N for Nonterminal symbols)
    T is a finite set of terminal symbols.
    S is a member of V is a distinguished element of V called the start symbol.
    P is a finite set of productions (or rules).

  { Productions

    A production has the form
        X -> Y
    where

      - X ∈ (V ∪ T)+ 

           X is a member of the set of strings composed of any mixture of
           variables and terminal symbols, but X is not the empty string.

      - Y ∈ (v ∪ T)*

           Y is a member of the set of strings composed of any mixture of
           variables and terminal symbols; y is allowed to be the empty string.

  }

}
{ Left recursion


  A production of grammar is said to haveleft recursion if the leftmost
  variable of its RHS is same as variable of its LHS.

  A grammar containing a production having left recursion is called as Left
  RECURSIVE GRAMMAR

  A Grammar G (V, T, P, S) is left recursive if it has a production in the form.

        X -> X n | y

    i.e. it is left recursive because the left of production is occurring at a
    first position on the right side of production.

       The following «sentences» can be produced by the grammar:

                    y                         or
                  X n =        y n            or
                X n n =      y n n            or
              X n n n =    y n n n            or
            X n n n n =  y n n n n …  

              


    { Elimination of left recursion

       Left recursion is considered to be problematic for TOP DOWN PARSERS.  
       Thus, there is an incentive to eliminate it

       Right recursion does not create any problem for the Top down parsers.

       left recursive:

          X -> n | y

       After elimination

         X  -> y X'
         X' -> n X' | ε


         X   =                   y X'
             =            y n X'  | y ε
             =          y n n X'  | y n ε
             =        y n n n X'  | y n n ε
                         …
           



    }

}
{ Automata theory


}


----------------------------------------------------------------------------------------------------------
Existing parsers etc:
  minimal c parser (interpreter?)
     - https://github.com/ReneNyffenegger/c4
     - http://www.t3x.org/subc/index.html     ( SubC - Its internals are described in detail in the book "Practical Compiler Cosntruction" - http://www.t3x.org/reload/index.html - must be bought)
     - https://github.com/icyfox168168/C--  A simple C-like grammar complier,Generate executable files for windows x86_64 platform. (seems to require an assembler)
     - https://github.com/Jamesbarford/holyc-lang (An implementation of Terry A. Davis's HolyC)
     - https://github.com/bonaert/tinyc-compiler

  Tutorials:
      - https://craftinginterpreters.com/contents.html
  




