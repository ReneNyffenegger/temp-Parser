declare
  vc2_scanner scanner_varchar2 := new scanner_varchar2(
q'{.
fo0
bar }');

begin

  vc2_scanner.next_char; if vc2_scanner.current_character_ <> '.'      then dbms_output.put_line('nok 1'); dbms_output.put_line(vc2_scanner.current_character_); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ <> chr(10)  then dbms_output.put_line('nok 2'); dbms_output.put_line(vc2_scanner.current_character_); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ <> 'f'      then dbms_output.put_line('nok f'); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ <> 'o'      then dbms_output.put_line('nok o'); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ <> '0'      then dbms_output.put_line('nok 0'); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ <> chr(10)  then dbms_output.put_line('nok 6'); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ <> 'b'      then dbms_output.put_line('nok b'); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ <> 'a'      then dbms_output.put_line('nok a'); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ <> 'r'      then dbms_output.put_line('nok r'); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ <> ' '      then dbms_output.put_line('nok'); end if;
  vc2_scanner.next_char; if vc2_scanner.current_character_ is not null then dbms_output.put_line('nok null'); end if;
end;
/

