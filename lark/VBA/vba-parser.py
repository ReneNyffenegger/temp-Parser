# from lark import Lark
import lark

parser = lark.Lark("""
//-----------------------------
start: function*

function: IDENT stmt_body

stmt_body: "{" stmt* "}"

stmt:      for_loop

for_loop:  "for" "("  IDENT "=" expr ";"  expr ";" expr ")"  stmt_body

expr:      "expr"

IDENT:        /[a-z][a-z0-9]*/i

PUNCTUATION:  /[.,?()]/

%import common.ESCAPED_STRING -> STRING

%import common.WS
%import common.CPP_COMMENT
%import common.C_COMMENT

%ignore WS
%ignore CPP_COMMENT
%ignore C_COMMENT

//-----------------------------
""")

with open('test.in', 'r') as file:
     file_content = file.read().replace('\n', '')



parsed = parser.parse(file_content)

#hello {
#
#   for (i = expr; expr; expr) {
#
#      for (j = expr; expr; expr) {
#
#      }
#   }
#
#}
#
#""")

indent = 0

def out(t):
    None

out_stream = open('test.out', 'w')


def rule(rule_func):
 #  Decorotor for functions that implement rules

    def decorated_rule_func(*a, **kw):
        global indent
        dbg(' ' + rule_func.__name__)
        indent += 1
        rule_func(*a, **kw)
        indent -= 1

    return decorated_rule_func

def dbg(t):
    print(('  ' * indent) + str(t))

@rule
def stmt(s):
    dbg('stmt')

@rule
def stmts(ss):
    for s in ss.children:
        stmt(s)

@rule
def function(f):

    s = f.children[1]
    dbg('function type of s=' + str(type(s)))
    stmts(s)

for i in parsed.children:

    if isinstance(i, lark.Tree):

       if i.data == 'function':
          function(i)

    else:
       print(str(type(i)))