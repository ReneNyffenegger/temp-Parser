create or replace package scanner_error as

    eof_reached    exception;
    unknown_source exception;

end scanner_error;
/
