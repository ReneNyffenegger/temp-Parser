from lark import Lark

parser = Lark(open('first.grammar').read())
parsed = parser.parse(open('first.program').read())

for i in parsed.children:
#   print(i)
    print('{} {} was found'.format(i.data, i.children[0]))
