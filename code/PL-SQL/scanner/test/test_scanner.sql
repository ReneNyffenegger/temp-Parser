declare

  prog clob;
  scanner scanner_clob;


begin

  prog := q'{.
fo0
bar }';

  prog := prog                  ||
          rpad('*', 10000, '*') ||
          rpad('*', 10000, '*') ||
          rpad('*', 10000, '*') ||
          rpad('*', 10000, '*') ||
          rpad('*', 10000, '*') ||
          rpad('*', 10000, '*') ||
          rpad('*', 10000, '*') ||
          rpad('*', 10000, '*') ||
          rpad('*', 10000, '*') ||
          rpad('*', 10000, '*');

  scanner := new scanner_clob(prog);

  scanner.next_char; if scanner.current_character_ <> '.'      then dbms_output.put_line('nok 1'); dbms_output.put_line(scanner.current_character_); end if;
  scanner.next_char; if scanner.current_character_ <> chr(10)  then dbms_output.put_line('nok 2'); dbms_output.put_line(scanner.current_character_); end if;
  scanner.next_char; if scanner.current_character_ <> 'f'      then dbms_output.put_line('nok f'); end if;
  scanner.next_char; if scanner.current_character_ <> 'o'      then dbms_output.put_line('nok o'); end if;
  scanner.next_char; if scanner.current_character_ <> '0'      then dbms_output.put_line('nok 0'); end if;
  scanner.next_char; if scanner.current_character_ <> chr(10)  then dbms_output.put_line('nok 6'); end if;
  scanner.next_char; if scanner.current_character_ <> 'b'      then dbms_output.put_line('nok b'); end if;
  scanner.next_char; if scanner.current_character_ <> 'a'      then dbms_output.put_line('nok a'); end if;
  scanner.next_char; if scanner.current_character_ <> 'r'      then dbms_output.put_line('nok r'); end if;
  scanner.next_char; if scanner.current_character_ <> ' '      then dbms_output.put_line('nok'  ); end if;

  for i in 1 .. 1e5 loop
    begin

      scanner.next_char;
      if scanner.current_character_ <> '*' then dbms_output.put_line('*'); end if;

    exception when others then
      dbms_output.put_line('i = ' || i);
      raise;
    end;
  end loop;

  dbms_output.put_line('reading past last character');

  scanner.next_char; if scanner.current_character_ is not null then dbms_output.put_line('nok null'); end if;

  dbms_output.put_line('finished');

end;
/
