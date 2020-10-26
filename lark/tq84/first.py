from lark import Lark

parser = Lark(        open('first.grammar').read())
parsed = parser.parse(open('first.program').read())

for i in parsed.children:
    rule     = i.data
    print('Rule {} was found, 1st child is {}'.format(rule, i.children[0]))
