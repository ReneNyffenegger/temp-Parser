from lark import Lark


parser = Lark("""

start: item+
  item: DIGIT         -> dig
      | CHAR          -> chr


  CHAR:  ("a" .. "z")
  DIGIT: ("0" .. "9")

    %import common.WS
    %ignore WS
""")

parsed = parser.parse("""

  a b c 1
  2 3 x y
  999 qqq

""")

for i in parsed.children:
#   print(i)
    print('{} {} was found'.format(i.data, i.children[0]))
