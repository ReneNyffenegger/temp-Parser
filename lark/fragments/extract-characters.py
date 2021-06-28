import lark

parser = lark.Lark("""

start: CHAR*

CHAR: /./s

""")


#  parser = lark.Lark("""
#  //-----------------------------
#  start: item*
#  
#  item:    STRING
#         | CHAR
#  
#  // STRING: "\"" /[^\"]*/ "\""
#  STRING: "\"" /[abc]/ "\""
#  
#  CHAR: /.|\n|\r/x
#  
#  //-----------------------------
#  """)


parsed = parser.parse('''
foo bar baz
''')

for i in parsed.children:
    print(str(i.value))

#  parsed = parser.parse('''
#  hello you here is a "string" and
#  "a"
#  here is "a multi line
#  string
#  foo
#  bar baz"
#  etc.
#  ''')
#  