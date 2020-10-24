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

  4 f z 3 q 2 9 z

""")

for i in parsed.children:
#   print(i)
    print('{} {} was found'.format(i.data, i.children[0]))
