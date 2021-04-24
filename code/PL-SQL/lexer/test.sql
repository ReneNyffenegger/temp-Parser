declare

  s  scanner_clob := scanner_clob (

     '  IDentifier1.IDEnT2'        || chr(10) || -- {
     '+42'                         || chr(13) || chr(10) ||
     ' func(bla);'                 || chr(10) ||
     '  here -- is a comment'      || chr(13) || chr(10) ||
     '  and /* another # ! ( / * ' || chr(10) ||
     'comment */ '                 || chr(13) || chr(10) ||
     'b:=c;'                       || chr(10) ||
     '  label: goto label;'        || chr(10) ||
     '  string'                    || chr( 9) || ' := ''stringvalue'' || ''more''''string'';' || chr(10) ||
     '  qab :=  4.4;q := .98;q1:=q''!foo'' ! bar!'';' || chr(10) ||
     '  "xne"."two" (42.0,-24)'    || chr(10) ||
     '  C_FOO foo_tab%ROWTYPE > <  bcd<=efg>=hij   != <> << >> >< => ' || chr(10) ||
--   q'['foo']'
     q'[q'{qqq'}QQQ}']'
     -- }

  );

  l lexer := lexer(s);

  procedure check_token(type_ in varchar2 /*, position_ in number */ , line in number, col in number, token_ in varchar2) is -- {

      function addr return varchar2 is
      begin
          return l.current_token_.line_start || '/' || l.current_token_.col_start;
      end addr;

  begin

      if l.current_token_.type_ != type_ then
         raise_application_error(-20800, 'expected type: ' || type_ || ', but is: ' || l.current_token_.type_ || '. ' || addr);
      end if;

--    if nvl(l.current_token_.pos_, -1) != position_ then
--       raise_application_error(-20800, 'expected position: >' || position_ || '<, but is: >' || l.current_token_.pos_ || '<');
--    end if;

      if nvl(l.current_token_.line_start, -1) != line then
         raise_application_error(-20800, 'expected line: >' || line || '<, but is: >' || addr || '<');
      end if;

      if nvl(l.current_token_.col_start, -1) != col then
         raise_application_error(-20800, 'expected column: >' || col || '<, but is: >' || addr || '<');
      end if;

      if l.current_token_.token_ != token_ then
         raise_application_error(-20800, 'expected token: ' || token_ || ', but is: ' || l.current_token_.token_ || '. ' || addr);
      end if;

      l.next_token;

  end check_token; -- }

begin

  check_token('WS'  ,/*   0,*/    1,   1, '  ');                       -- Line 0 -- {
  check_token('ID'  ,/*   2,*/    1,   3, 'IDentifier1');
  check_token('SYM' ,/*  13,*/    1,  14, '.');
  check_token('ID'  ,/*  14,*/    1,  15, 'IDEnT2');
  check_token('WS'  ,/*  20,*/    1,  21, chr(10));
   -- }
  check_token('SYM' ,/*  21,*/    2,   1, '+');                        -- Line 1 -- {
  check_token('NUM' ,/*  22,*/    2,   2, '42');
  check_token('WS'  ,/*  24,*/    2,   4, chr(13) || chr(10) || ' ');
   -- }
  check_token('ID'  ,/*  27,*/    3,   2, 'func');                     -- Line 2 -- {
  check_token('SYM' ,/*  31,*/    3,   6, '(');
  check_token('ID'  ,/*  32,*/    3,   7, 'bla');
  check_token('SYM' ,/*  35,*/    3,   10, ')');
  check_token('SYM' ,/*  36,*/    3,  11, ';');
  check_token('WS'  ,/*  37,*/    3,  12, chr(10) || '  ');
   -- }
  check_token('ID'  ,/*  40,*/    4,   3, 'here');                     -- Line 3 -- {
  check_token('WS'  ,/*  44,*/    4,   7, ' ');
  check_token('REM' ,/*  45,*/    4,   8, '-- is a comment' || chr(13) || chr(10));
  check_token('WS'  ,/*  62,*/    5,   1, '  ');
   -- }
  check_token('ID'  ,/*  64,*/    5,   3, 'and');                      -- Line 4 -- {
  check_token('WS'  ,/*  67,*/    5,   6, ' ');
  check_token('REM' ,/*  68,*/    5,   7, '/* another # ! ( / * ' || chr(10) || 'comment */');
   -- }
  check_token('WS'  ,/* 100,*/    6,   11, ' ' || chr(13) || chr(10)); -- Line 5 -- {
   -- }
  check_token('ID'  ,/* 103,*/    7,    1, 'b');                       -- Line 6 -- {
  check_token('SYM' ,/* 104,*/    7,    2, ':=');
  check_token('ID'  ,/* 106,*/    7,    4, 'c');
  check_token('SYM' ,/* 107,*/    7,    5, ';');
  check_token('WS'  ,/* 108,*/    7,    6, chr(10) || '  ');
   -- }
  check_token('ID'  ,/* 111,*/    8,    3, 'label');                   -- Line 7 -- {
  check_token('SYM' ,/* 116,*/    8,    8, ':');
  check_token('WS'  ,/* 117,*/    8,    9, ' ');
  check_token('ID'  ,/* 118,*/    8,    10, 'goto');
  check_token('WS'  ,/* 122,*/    8,   14, ' ');
  check_token('ID'  ,/* 123,*/    8,   15, 'label');
  check_token('SYM' ,/* 128,*/    8,   20, ';');
  check_token('WS'  ,/* 129,*/    8,   21, chr(10) || '  ');
   -- }
  check_token('ID'  ,/* 132,*/    9,    3, 'string');                  -- Line 8 -- {
  check_token('WS'  ,/* 138,*/    9,    9, chr(9) || ' ');
  check_token('SYM' ,/* 140,*/    9,   11, ':=');
  check_token('WS'  ,/* 142,*/    9,   13, ' ');
  check_token('STR' ,/* 143,*/    9,   14, '''stringvalue''');
  check_token('WS'  ,/* 156,*/    9,   27, ' ');
  check_token('SYM' ,/* 157,*/    9,   28, '||');
  check_token('WS'  ,/* 159,*/    9,   30, ' ');
  check_token('STR' ,/* 160,*/    9,   31, '''more''''string''');
  check_token('SYM' ,/* 174,*/    9,   45, ';');
   -- }
  check_token('WS'  ,/* 175,*/    9,   46, chr(10) || '  ');           -- Line 9 -- {
  check_token('ID'  ,/* 178,*/   10,    3, 'qab');
  check_token('WS'  ,/* 181,*/   10,    6, ' ');
  check_token('SYM' ,/* 182,*/   10,    7, ':=');
  check_token('WS'  ,/* 184,*/   10,    9, '  ');
  check_token('FLT' ,/* 186,*/   10,   11, '4.4');
  check_token('SYM' ,/* 189,*/   10,   14, ';');
  check_token('ID'  ,/* 190,*/   10,   15, 'q');
  check_token('WS'  ,/* 191,*/   10,   16, ' ');
  check_token('SYM' ,/* 192,*/   10,   17, ':=');
  check_token('WS'  ,/* 194,*/   10,   19, ' ');
  check_token('FLT' ,/* 195,*/   10,   20, '.98');
  check_token('SYM' ,/* 198,*/   10,   23, ';');
  check_token('ID'  ,/* 199,*/   10,   24, 'q1');
--check_token('WS'  ,/* 201,*/   10,   26, ' ');
  check_token('SYM' ,/* 201,*/   10,   26, ':=');
  check_token('STR' ,/* 203,*/   10,   28, 'q''!foo'' ! bar!''');
  check_token('SYM' ,/* 218,*/   10,   43, ';');
  check_token('WS'  ,/* 219,*/   10,   44, chr(10) || '  ');
 -- }
  check_token('Id'  ,/* 222,*/   11,    3, '"xne"');                   -- Line 10 -- {
  check_token('SYM' ,/* 227,*/   11,    8, '.');
  check_token('Id'  ,/* 228,*/   11,    9, '"two"');
  check_token('WS'  ,/* 233,*/   11,   14, ' ');
  check_token('SYM' ,/* 234,*/   11,   15, '(');
  check_token('FLT' ,/* 235,*/   11,   16, '42.0');
  check_token('SYM' ,/* 239,*/   11,   20, ',');
  check_token('SYM' ,/* 240,*/   11,   21, '-');
  check_token('NUM' ,/* 241,*/   11,   22, '24');
  check_token('SYM' ,/* 243,*/   11,   24, ')');
  check_token('WS'  ,/* 244,*/   11,   25, chr(10) || '  ');
 -- }
  check_token('ID'  ,/* 247,*/   12,    3, 'C_FOO');                   -- Line 11 -- {
  check_token('WS'  ,/* 252,*/   12,    8, ' ');
  check_token('ID'  ,/* 253,*/   12,    9, 'foo_tab');
  check_token('SYM' ,/* 260,*/   12,   16, '%');
  check_token('ID'  ,/* 261,*/   12,   17, 'ROWTYPE');
  check_token('WS'  ,/* 268,*/   12,   24, ' ');
  check_token('SYM' ,/* 269,*/   12,   25, '>');
  check_token('WS'  ,/* 270,*/   12,   26, ' ');
  check_token('SYM' ,/* 271,*/   12,   27, '<');
  check_token('WS'  ,/* 272,*/   12,   28, '  ');
  check_token('ID'  ,/* 274,*/   12,   30, 'bcd');
  check_token('SYM' ,/* 277,*/   12,   33, '<=');
  check_token('ID'  ,/* 279,*/   12,   35, 'efg');
  check_token('SYM' ,/* 282,*/   12,   38, '>=');
  check_token('ID'  ,/* 284,*/   12,   40, 'hij');
  check_token('WS'  ,/* 287,*/   12,   43, '   ');
  check_token('SYM' ,/* 290,*/   12,   46, '!=');
  check_token('WS'  ,/* 292,*/   12,   48, ' ');
  check_token('SYM' ,/* 293,*/   12,   49, '<>');
  check_token('WS'  ,/* 295,*/   12,   51, ' ');
  check_token('SYM' ,/* 296,*/   12,   52, '<<');
  check_token('WS'  ,/* 298,*/   12,   54, ' ');
  check_token('SYM' ,/* 299,*/   12,   55, '>>');
  check_token('WS'  ,/* 301,*/   12,   57, ' ');
  check_token('SYM' ,/* 302,*/   12,   58, '>' );
  check_token('SYM' ,/* 303,*/   12,   59, '<' );
  check_token('WS'  ,/* 304,*/   12,   60, ' ');
  check_token('SYM' ,/* 305,*/   12,   61, '=>' );
  check_token('WS'  ,/* 307,*/   12,   63, ' ' || chr(10)); -- }

--dbms_output.put_line('aaax');
  check_token('STR' ,/*    ,*/   13,    1, q'[q'{qqq'}QQQ}']');
--check_token('STR' ,/*    ,*/   13,    1, q'['foo']');
--dbms_output.put_line('yyyy');

  if l.current_token_ is not null then -- {
     raise_application_error(-20800, 'Current token should be null but is: ' || l.current_token_.token_);
  end if; -- }

  dbms_output.put_line('Test ok: lexer varchar2');

end;
/
