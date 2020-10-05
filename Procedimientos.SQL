---------CREACION DE TABLAS----------
CREATE TABLE CABECERO(
    ID_CABECERO                     NUMBER(6) PRIMARY KEY,
    N_BUY_ORDER_CUSTOMER            VARCHAR(10),
    N_BUY_ORDER_PROVIDER            VARCHAR(10),
    FILE_REQUEST_CREATION_DATE      DATE,
    COMENTS                         VARCHAR(200)
    
);

CREATE TABLE LINEAS(
    ID_LINEAS                      NUMBER(6) PRIMARY KEY,
    N_ARTICLE_POSITION             NUMBER(10),
    ID_ARTICLE_CUSTOMER            NUMBER(6,6),
    ID_ARTICLE_PROVIDER            NUMBER(6,6),
    CANTIDAD_REQUEST_CUSTOMER      NUMBER(7),
    CANTIDAD_CONFIRM_PROVIDER      NUMBER(7),
    DATE_ENTREGA                   DATE,
    N_ALMACEN                      NUMBER(3),
    COMENTS                        VARCHAR(200),
    ID_CABECERO                    NUMBER(6)
);

---------------------------CREACION DE LA SECUENCIA---------------
CREATE SEQUENCE SECUENCIA_PRAC
  START WITH 1
  MAXVALUE 9999
  MINVALUE 1
  CYCLE
  NOCACHE
  NOORDER;

---------------------INICIALIZAR LA SECUENCIA---------------
SELECT SECUENCIA_PRAC.CURRVAL FROM CABECERO, LINEAS;

----------------------PROCEDIMIENTO DE INSERTAR DATOS CABECERO----------
CREATE OR REPLACE PROCEDURE INSERT_DATA_CABECERO(O_ID NUMBER, 
                                        O_N_BUY_OR_CUS VARCHAR2, 
                                        O_N_BUY_OR_PRO VARCHAR2, 
                                        O_FILE_REQ_CREAT_DATE DATE, 
                                        O_COMENTS VARCHAR2
                                        )
    IS
    --VARIABLES
    BEGIN
        INSERT INTO  CABECERO(
            ID_CABECERO, N_BUY_ORDER_CUSTOMER, N_BUY_ORDER_PROVIDER, FILE_REQUEST_CREATION_DATE, COMENTS
        )
        VALUES(
            O_ID, O_N_BUY_OR_CUS , O_N_BUY_OR_PRO , O_FILE_REQ_CREAT_DATE, O_COMENTS
        );

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: '||sqlcode||' _ '||sqlerrm);  
END INSERT_DATA_CABECERO;

----------------------PROCEDIMIENTO DE INSERTAR DATOS LINEAS----------
CREATE OR REPLACE PROCEDURE INSERT_DATA_LINEAS(O_ID_LINEAS NUMBER, 
                                               O_N_ARTIC_POS NUMBER, 
                                               O_ID_ART_CUST NUMBER, 
                                               O_ID_ART_PROV NUMBER, 
                                                O_CANT_REQ_CUST NUMBER, 
                                                O_CANT_CONF_PROV NUMBER, 
                                                O_DATE_ENTREGA DATE,
                                                O_N_ALMACEN NUMBER,
                                                O_COMENTS VARCHAR2
                                        )
    IS
    --VARIABLES
    BEGIN
        INSERT INTO  LINEAS(
            ID_LINEAS, N_ARTICLE_POSITION, ID_ARTICLE_CUSTOMER, ID_ARTICLE_PROVIDER, CANTIDAD_REQUEST_CUSTOMER, CANTIDAD_CONFIRM_PROVIDER, DATE_ENTREGA, N_ALMACEN, COMENTS
        )
        VALUES(
            O_ID_LINEAS, O_N_ARTIC_POS , O_ID_ART_CUST , O_ID_ART_PROV, O_CANT_REQ_CUST, O_CANT_CONF_PROV, O_DATE_ENTREGA, O_N_ALMACEN, O_COMENTS
        );

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: '||sqlcode||' _ '||sqlerrm);  
END INSERT_DATA_LINEAS;

    -------------INSERTAR LOS DATOS------------
SET SERVEROUTPUT ON;
BEGIN 
    INSERT_DATA_LINEAS();
END;

----------------PROCEDIMIENTO DE MOSTRAR TODOS LOS DATOS CON CURSOR DE CABECERO-----------------
CREATE OR REPLACE PROCEDURE SHOW_DATA_CABECERO
    IS CURSOR CURSOR_CABECERO
        IS SELECT
            ID_CABECERO, N_BUY_ORDER_CUSTOMER, N_BUY_ORDER_PROVIDER, FILE_REQUEST_CREATION_DATE, COMENTS
        FROM CABECERO;
        --WHERE ID_EMPLEADO = ID_EM;
    BEGIN
        FOR LISTA IN CURSOR_CABECERO LOOP
            DBMS_OUTPUT.PUT_LINE('ID :'||LISTA.ID_CABECERO||' -'||
                                '-NUMBER ORDER BUY CUSTOMER :'||LISTA.N_BUY_ORDER_CUSTOMER||' -'||
                                '-NUMBER ORDER BUY PROVIDER :'||LISTA.N_BUY_ORDER_PROVIDER||' -'||
                                '-COMENTS :'||LISTA.COMENTS
                                );
            --DBMS_OUTPUT.PUT_LINE('NOMBRE :'||LISTA.NOMBRE);
            --DBMS_OUTPUT.PUT_LINE('APELLIDO :'||LISTA.APELLIDO);
        END LOOP;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
END SHOW_DATA_CABECERO;


----------------PROCEDIMIENTO DE MOSTRAR TODOS LOS DATOS CON CURSOR DE LINEAS-----------------
CREATE OR REPLACE PROCEDURE SHOW_DATA_LINEAS
    IS CURSOR CURSOR_LINEAS
        IS SELECT
            ID_LINEAS, 
            N_ARTICLE_POSITION,
            ID_ARTICLE_CUSTOMER,
            ID_ARTICLE_PROVIDER,
            CANTIDAD_REQUEST_CUSTOMER,
            CANTIDAD_CONFIRM_PROVIDER,
            DATE_ENTREGA,
            N_ALMACEN,
            COMENTS
        FROM LINEAS;
        --WHERE ID_EMPLEADO = ID_EM;
    BEGIN
        FOR LISTA IN CURSOR_LINEAS LOOP
            DBMS_OUTPUT.PUT_LINE('ID :'||LISTA.ID_LINEAS||' -'||
                                '-NUMBER POSITION ARTICLES :'||LISTA.N_ARTICLE_POSITION||' -'||
                                '-KEY ARTICLE CUSTOMER :'||LISTA.ID_ARTICLE_CUSTOMER||' -'||
                                '-KEY ARTICLE PROVIDER :'||LISTA.ID_ARTICLE_PROVIDER||
                                '-CANTIDAD REQUEST CUSTOMER :'||LISTA.CANTIDAD_REQUEST_CUSTOMER||
                                '-CANTIDAD CONFIRM PROVIDER :'||LISTA.CANTIDAD_CONFIRM_PROVIDER||
                                '-DATE ENTREGA :'||LISTA.DATE_ENTREGA||
                                '-ALMACEN :'||LISTA.N_ALMACEN||
                                '-COMENTS :'||LISTA.COMENTS
                                );
            --DBMS_OUTPUT.PUT_LINE('NOMBRE :'||LISTA.NOMBRE);
            --DBMS_OUTPUT.PUT_LINE('APELLIDO :'||LISTA.APELLIDO);
        END LOOP;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
END SHOW_DATA_LINEAS;

---------------MOSTRAR TODOS LOS DATOS-----
SET SERVEROUTPUT ON;
BEGIN 
    SHOW_DATA_CABECERO();
END;

------------PROCEDIMIENTO DE ELIMINACION DE DATOS CABECERA-------------
CREATE OR REPLACE PROCEDURE DELETE_DATA_CABECERO(CODE NUMBER)
    IS
        ---DECLARAR VARIABLES
    BEGIN
        DELETE FROM CABECERO WHERE ID_CABECERO = CODE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
END DELETE_DATA_CABECERO;


------------PROCEDIMIENTO DE ELIMINACION DE DATOS LINEA-------------
CREATE OR REPLACE PROCEDURE DELETE_DATA_LINEAS(CODE NUMBER)
    IS
        ---DECLARAR VARIABLES
    BEGIN
        DELETE FROM LINEAS WHERE ID_LINEAS = CODE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
END DELETE_DATA_LINEAS;

    ---------------ELIMINAR DATOS-----
SET SERVEROUTPUT ON;
BEGIN 
    DELETE_DATA_LINEAS(2);
END;

------------PROCEDIMIENTO DE ACTUALIZACION DE DATOS CABECERO-------------
CREATE OR REPLACE PROCEDURE UPDATE_DATA_CABECERO(O_ID IN CABECERO.ID_CABECERO%TYPE,
                                        O_N_BUY_OR_CUS IN CABECERO.N_BUY_ORDER_CUSTOMER%TYPE,
                                        O_N_BUY_OR_PRO IN CABECERO.N_BUY_ORDER_PROVIDER%TYPE,
                                        O_FILE_REQ_CREAT_DATE IN CABECERO.FILE_REQUEST_CREATION_DATE%TYPE
                                        )
    AS
        ---DECLARAR VARIABLES
    BEGIN
        UPDATE CABECERO
        SET N_BUY_ORDER_CUSTOMER = O_N_BUY_OR_CUS,
            N_BUY_ORDER_PROVIDER = O_N_BUY_OR_PRO,
            FILE_REQUEST_CREATION_DATE = SYSDATE 
        WHERE O_ID = ID_CABECERO;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
END UPDATE_DATA_CABECERO;

------------PROCEDIMIENTO DE ACTUALIZACION DE DATOS LINEas-------------
CREATE OR REPLACE PROCEDURE UPDATE_DATA_LINEAS(O_ID IN LINEAS.ID_CABECERO%TYPE,
                                        O_N_ARTIC_POS IN LINEAS.N_ARTICLE_POSITION%TYPE,
                                        O_ID_ART_CUST IN LINEAS.ID_ARTICLE_CUSTOMER%TYPE,
                                        O_ID_ART_PROV IN LINEAS.ID_ARTICLE_PROVIDER%TYPE,
                                        O_CANT_REQ_CUST IN LINEAS.CANTIDAD_REQUEST_CUSTOMER%TYPE,
                                        O_CANT_CONF_PROV IN LINEAS.CANTIDAD_CONFIRM_PROVIDER%TYPE,
                                        O_DATE_ENTREGA IN LINEAS.DATE_ENTREGA%TYPE,
                                        O_N_ALMACEN IN LINEAS.N_ALMACEN%TYPE,
                                        O_COMENTS IN LINEAS.COMENTS%TYPE
                                        )
    AS
        ---DECLARAR VARIABLES
    BEGIN
        UPDATE LINEAS
        SET N_ARTICLE_POSITION = O_N_ARTIC_POS,
            ID_ARTICLE_CUSTOMER = O_ID_ART_CUST,
            ID_ARTICLE_PROVIDER = O_ID_ART_PROV, 
            CANTIDAD_REQUEST_CUSTOMER = O_CANT_REQ_CUST,
            CANTIDAD_CONFIRM_PROVIDER = O_CANT_CONF_PROV,
            DATE_ENTREGA = O_DATE_ENTREGA,
            N_ALMACEN = O_N_ALMACEN,
            COMENTS = O_COMENTS
        WHERE O_ID = ID_CABECERO;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
END UPDATE_DATA_LINEAS;


---------------ACTUALIZAR DATOS-----
SET SERVEROUTPUT ON;
BEGIN 
    UPDATE_DATA_LINEAS();
END;


------------------------------------------------------
----------------ARCHIVO DE TEXTO-----------
UTL_FILE.GET_LINE(
    FILE IN FILE_TYPE,
    BUFFER OUT VARCHAR2,
    LEN IN PLS_INTEGER DEFAULT NULL
);

CREATE OR REPLACE DIRECTORY DIR_READ AS 'C://Users//ferna//DB_ORACLE';

DECLARE 
    TYPE TYPE_REC IS RECORD(LINE NUMBER,
                            COL VARCHAR2(14));
    TYPE TYPE_FIELD IS TABLE OF TYPE_REC;

    O_FIELD TYPE_FIELD;
    O_LAST NUMBER := 0;
    O_FILE UTL_FILE.FILE_TYPE;
    O_LINE VARCHAR(500);
BEGIN 
    O_FILE := UTL_FILE:FOPEN(
                            'C://Users//ferna//DB_ORACLE',
                            'practica.txt',
                            'R'
                            );
    LOOP 
        BEGIN 
            O_FIELD := TYPE_FIELD();
            UTL_FIELD.GET_LINE(O_FILE, O_LINE);
            FOR I IN 1..6 LOOP
                O_FIELD.EXTEND;
                O_FIELD(I).LINE := INSTR(O_LINE,'|',O_LAST+1,1);
                CASE
                    WHEN I = 1 THEN 
                        O_FIELD(I).COL := ''
                    WHEN I = 2 THEN
                        O_FIELD(I).COL
                    ELSE
                        O_FIELD(I).COL := ''
                END CASE;
                O_LAST := O_FIELD(I).LINE;
            END LOOP;
            O_LAST := 0;
            DBMS_OUTPUT.PUT_LINE(RPAD('=',LENGTH(O_LINE),'='));
            DBMS_OUTPUT.PUT_LINE(O_LINE);
            DBMS_OUTPUT.PUT_LINE(RPAD('=',LENGTH(O_LINE),'='));
            DBMS_OUTPUT.PUT_LINE(O_FIELD(1).column||': '||SUBSTR(O_LINE,1,O_FIELD(1).LINE-1));
            FOR i IN 1..5 LOOP
                DBMS_OUTPUT.PUT_LINE(O_FIELD(I+1).column||': '||
                                        SUBSTR
                                            (
                                                O_LINE,O_FIELD(I).LINE+1,O_FIELD(I+1).LINE-O_FIELD(I).LINE-1
                                            )
                                    );
            END LOOP;

            DBMS_OUTPUT.PUT_LINE('VEHICLE: '||SUBSTR(O_LINE,O_FIELD(6).LINE+1,LENGTH(O_LINE)));

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXIT;
        END;
    END LOOP;

    UTL_FILE.FCLOSE(O_FILE);
 END;


-------GENERAR PERMISOS EN EL DIRECTORIO
CREATE OR REPLACE DIRECTORY dir_read
  AS  'C:\USERS\FERNA\DB_ORACLE/';

GRANT READ ON DIRECTORY dir_read TO DBA; 

GRANT WRITE ON DIRECTORY dir_read TO DBA;

--INSERTAR DATOS DE TXT
DECLARE
    TYPE    typ_rec IS RECORD
    (
        line    NUMBER,
        O_LIN    LINEAS%ROWTYPE
    );

    TYPE    typ_field
                IS TABLE OF typ_rec;

    v_field     typ_field;
    v_last      NUMBER  :=  0;
    v_file      UTL_FILE.FILE_TYPE;
    v_line      VARCHAR2(500);
BEGIN
    v_file      := UTL_FILE.FOPEN
                                 (
                                    'DIR_READ',      --Nombre del Directorio en Mayúsculas
                                    'practica.txt',
                                    'R'
                                 );
    LOOP
        BEGIN
           v_field     :=  typ_field();

             UTL_FILE.GET_LINE(v_file, v_line);

            FOR i IN 1..6 LOOP
                v_field.EXTEND;
                v_field(i).line  :=  INSTR(v_line,'|',v_last+1,1);
                v_last  :=  v_field(i).line;
            END LOOP;

            v_last  :=  0;

            v_field(1).O_LIN.N_ARTICLE_POSITION    := SUBSTR(v_line,1,v_field(1).line-1);

            v_field(1).O_LIN.ID_ARTICLE_CUSTOMER    := SUBSTR
                                            (
                                                v_line,v_field(1).line+1,v_field(2).line-v_field(1).line-1
                                            );

            v_field(1).O_LIN.ID_ARTICLE_PROVIDER := SUBSTR
                                            (
                                                v_line,v_field(2).line+1,v_field(3).line-v_field(2).line-1
                                            );

             v_field(1).O_LIN.CANTIDAD_REQUEST_CUSTOMER    := SUBSTR
                                            (
                                                v_line,v_field(3).line+1,v_field(4).line-v_field(3).line-1
                                            );

             v_field(1).O_LIN.CANTIDAD_CONFIRM_PROVIDER
                                        := SUBSTR
                                            (
                                                v_line,v_field(4).line+1,v_field(5).line-v_field(4).line-1
                                            );

            v_field(1).O_LIN.DATE_ENTREGA
                                        := SUBSTR
                                            (
                                                v_line,v_field(5).line+1,v_field(6).line-v_field(5).line-1
                                            );

            v_field(1).O_LIN.N_ALMACEN  :=  SUBSTR
                                            (
                                                v_line,v_field(6).line+1,LENGTH(v_line)-v_field(6).line
                                            );
            v_field(1).O_LIN.COMENTS
                                        := SUBSTR
                                            (
                                                v_line,v_field(5).line+1,v_field(6).line-v_field(5).line-1
                                            );

            INSERT INTO LINEAS
            VALUES  v_field(1).O_LIN;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXIT;
        END;
    END LOOP;

    UTL_FILE.FCLOSE(v_file);
END;

SELECT * FROM LINEAS

--------------------CREAR EL PAQUETE
CREATE OR REPLACE PACKAGE PAQUETE_UNO IS 
    PROCEDURE INSERT_DATA_CABECERO(O_ID NUMBER, 
                                        O_N_BUY_OR_CUS VARCHAR2, 
                                        O_N_BUY_OR_PRO VARCHAR2, 
                                        O_FILE_REQ_CREAT_DATE DATE, 
                                        O_COMENTS VARCHAR2
                                        );
    PROCEDURE INSERT_DATA_LINEAS(O_ID_LINEAS NUMBER, 
                                O_N_ARTIC_POS NUMBER, 
                                O_ID_ART_CUST NUMBER, 
                                O_ID_ART_PROV NUMBER, 
                                O_CANT_REQ_CUST NUMBER, 
                                O_CANT_CONF_PROV NUMBER, 
                                O_DATE_ENTREGA DATE,
                                O_N_ALMACEN NUMBER,
                                O_COMENTS VARCHAR2
                                        );
    PROCEDURE SHOW_DATA_CABECERO;
    PROCEDURE SHOW_DATA_LINEAS;
    PROCEDURE DELETE_DATA_CABECERO(CODE NUMBER);
    PROCEDURE DELETE_DATA_LINEAS(CODE NUMBER);
    PROCEDURE UPDATE_DATA_LINEAS(O_ID IN LINEAS.ID_CABECERO%TYPE,
                                O_N_ARTIC_POS IN LINEAS.N_ARTICLE_POSITION%TYPE,
                                O_ID_ART_CUST IN LINEAS.ID_ARTICLE_CUSTOMER%TYPE,
                                O_ID_ART_PROV IN LINEAS.ID_ARTICLE_PROVIDER%TYPE,
                                O_CANT_REQ_CUST IN LINEAS.CANTIDAD_REQUEST_CUSTOMER%TYPE,
                                O_CANT_CONF_PROV IN LINEAS.CANTIDAD_CONFIRM_PROVIDER%TYPE,
                                O_DATE_ENTREGA IN LINEAS.DATE_ENTREGA%TYPE,
                                O_N_ALMACEN IN LINEAS.N_ALMACEN%TYPE,
                                O_COMENTS IN LINEAS.COMENTS%TYPE
                                );
    PROCEDURE UPDATE_DATA_CABECERO(O_ID IN CABECERO.ID_CABECERO%TYPE,
                                    O_N_BUY_OR_CUS IN CABECERO.N_BUY_ORDER_CUSTOMER%TYPE,
                                    O_N_BUY_OR_PRO IN CABECERO.N_BUY_ORDER_PROVIDER%TYPE,
                                    O_FILE_REQ_CREAT_DATE IN CABECERO.FILE_REQUEST_CREATION_DATE%TYPE
                                    );
    RETURN NUMBER;
END;

--------------CREAR EL CUERPO DEL PAQUETE------
CREATE OR REPLACE PACKAGE BODY PAQUETE_UNO IS
    -------------PROCEDIMIENTO DE INSERTAR DATOS CABECERO---
    PROCEDURE INSERT_DATA_CABECERO(O_ID NUMBER, 
                                    O_N_BUY_OR_CUS VARCHAR2, 
                                    O_N_BUY_OR_PRO VARCHAR2, 
                                    O_FILE_REQ_CREAT_DATE DATE, 
                                    O_COMENTS VARCHAR2
                                    )
        IS
        --VARIABLES
        BEGIN
            INSERT INTO  CABECERO(
                ID_CABECERO, N_BUY_ORDER_CUSTOMER, N_BUY_ORDER_PROVIDER, FILE_REQUEST_CREATION_DATE, COMENTS
            )
            VALUES(
                O_ID, O_N_BUY_OR_CUS , O_N_BUY_OR_PRO , O_FILE_REQ_CREAT_DATE, O_COMENTS
            );

        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: '||sqlcode||' _ '||sqlerrm);  
    END INSERT_DATA_CABECERO;
    -------------PROCEDIMIENTO DE INSERTAR DATOS LINEAS---
    PROCEDURE INSERT_DATA_LINEAS(O_ID_LINEAS NUMBER, 
                                O_N_ARTIC_POS NUMBER, 
                                O_ID_ART_CUST NUMBER, 
                                O_ID_ART_PROV NUMBER, 
                                O_CANT_REQ_CUST NUMBER, 
                                O_CANT_CONF_PROV NUMBER, 
                                O_DATE_ENTREGA DATE,
                                O_N_ALMACEN NUMBER,
                                O_COMENTS VARCHAR2
                                )
        IS
        --VARIABLES
        BEGIN
            INSERT INTO  LINEAS(
                ID_LINEAS, N_ARTICLE_POSITION, ID_ARTICLE_CUSTOMER, ID_ARTICLE_PROVIDER, CANTIDAD_REQUEST_CUSTOMER, CANTIDAD_CONFIRM_PROVIDER, DATE_ENTREGA, N_ALMACEN, COMENTS
            )
            VALUES(
                O_ID_LINEAS, O_N_ARTIC_POS , O_ID_ART_CUST , O_ID_ART_PROV, O_CANT_REQ_CUST, O_CANT_CONF_PROV, O_DATE_ENTREGA, O_N_ALMACEN, O_COMENTS
            );

        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: '||sqlcode||' _ '||sqlerrm);  
    END INSERT_DATA_LINEAS;

    ------------PROCEDIMIENTO DE MOSTRAR DATOS------
    ----------------PROCEDIMIENTO DE MOSTRAR TODOS LOS DATOS CON CURSOR DE CABECERO-----------------
    PROCEDURE SHOW_DATA_CABECERO
        IS CURSOR CURSOR_CABECERO
            IS SELECT
                ID_CABECERO, N_BUY_ORDER_CUSTOMER, N_BUY_ORDER_PROVIDER, FILE_REQUEST_CREATION_DATE, COMENTS
            FROM CABECERO;
            --WHERE ID_EMPLEADO = ID_EM;
        BEGIN
            FOR LISTA IN CURSOR_CABECERO LOOP
                DBMS_OUTPUT.PUT_LINE('ID :'||LISTA.ID_CABECERO||' -'||
                                    '-NUMBER ORDER BUY CUSTOMER :'||LISTA.N_BUY_ORDER_CUSTOMER||' -'||
                                    '-NUMBER ORDER BUY PROVIDER :'||LISTA.N_BUY_ORDER_PROVIDER||' -'||
                                    '-COMENTS :'||LISTA.COMENTS
                                    );
                --DBMS_OUTPUT.PUT_LINE('NOMBRE :'||LISTA.NOMBRE);
                --DBMS_OUTPUT.PUT_LINE('APELLIDO :'||LISTA.APELLIDO);
            END LOOP;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
    END SHOW_DATA_CABECERO;

    ----------------PROCEDIMIENTO DE MOSTRAR TODOS LOS DATOS CON CURSOR DE LINEAS-----------------
    PROCEDURE SHOW_DATA_LINEAS
        IS CURSOR CURSOR_LINEAS
            IS SELECT
                ID_LINEAS, 
                N_ARTICLE_POSITION,
                ID_ARTICLE_CUSTOMER,
                ID_ARTICLE_PROVIDER,
                CANTIDAD_REQUEST_CUSTOMER,
                CANTIDAD_CONFIRM_PROVIDER,
                DATE_ENTREGA,
                N_ALMACEN,
                COMENTS
            FROM LINEAS;
            --WHERE ID_EMPLEADO = ID_EM;
        BEGIN
            FOR LISTA IN CURSOR_LINEAS LOOP
                DBMS_OUTPUT.PUT_LINE('ID :'||LISTA.ID_LINEAS||' -'||
                                    '-NUMBER POSITION ARTICLES :'||LISTA.N_ARTICLE_POSITION||' -'||
                                    '-KEY ARTICLE CUSTOMER :'||LISTA.ID_ARTICLE_CUSTOMER||' -'||
                                    '-KEY ARTICLE PROVIDER :'||LISTA.ID_ARTICLE_PROVIDER||
                                    '-CANTIDAD REQUEST CUSTOMER :'||LISTA.CANTIDAD_REQUEST_CUSTOMER||
                                    '-CANTIDAD CONFIRM PROVIDER :'||LISTA.CANTIDAD_CONFIRM_PROVIDER||
                                    '-DATE ENTREGA :'||LISTA.DATE_ENTREGA||
                                    '-ALMACEN :'||LISTA.N_ALMACEN||
                                    '-COMENTS :'||LISTA.COMENTS
                                    );
                --DBMS_OUTPUT.PUT_LINE('NOMBRE :'||LISTA.NOMBRE);
                --DBMS_OUTPUT.PUT_LINE('APELLIDO :'||LISTA.APELLIDO);
            END LOOP;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
    END SHOW_DATA_LINEAS;

    ------------PROCEDIMIENTO DE ELIMINACION DE DATOS------
    ------------PROCEDIMIENTO DE ELIMINACION DE DATOS CABECERA-------------
    PROCEDURE DELETE_DATA_CABECERO(CODE NUMBER)
        IS
            ---DECLARAR VARIABLES
        BEGIN
            DELETE FROM CABECERO WHERE ID_CABECERO = CODE;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
    END DELETE_DATA_CABECERO;

    ------------PROCEDIMIENTO DE ELIMINACION DE DATOS LINEA-------------
    PROCEDURE DELETE_DATA_LINEAS(CODE NUMBER)
        IS
            ---DECLARAR VARIABLES
        BEGIN
            DELETE FROM LINEAS WHERE ID_LINEAS = CODE;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
    END DELETE_DATA_LINEAS;

    ------------PROCEDIMIENTO DE ACTUALIZACIÓN DE DATOS------
    ------------PROCEDIMIENTO DE ACTUALIZACION DE DATOS CABECERO-------------
    PROCEDURE UPDATE_DATA_CABECERO(O_ID IN CABECERO.ID_CABECERO%TYPE,
                                    O_N_BUY_OR_CUS IN CABECERO.N_BUY_ORDER_CUSTOMER%TYPE,
                                    O_N_BUY_OR_PRO IN CABECERO.N_BUY_ORDER_PROVIDER%TYPE,
                                    O_FILE_REQ_CREAT_DATE IN CABECERO.FILE_REQUEST_CREATION_DATE%TYPE
                                    )
        AS
            ---DECLARAR VARIABLES
        BEGIN
            UPDATE CABECERO
            SET N_BUY_ORDER_CUSTOMER = O_N_BUY_OR_CUS,
                N_BUY_ORDER_PROVIDER = O_N_BUY_OR_PRO,
                FILE_REQUEST_CREATION_DATE = SYSDATE 
            WHERE O_ID = ID_CABECERO;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
    END UPDATE_DATA_CABECERO;

    ------------PROCEDIMIENTO DE ACTUALIZACION DE DATOS LINEAS-------------
    PROCEDURE UPDATE_DATA_LINEAS(O_ID IN LINEAS.ID_CABECERO%TYPE,
                                O_N_ARTIC_POS IN LINEAS.N_ARTICLE_POSITION%TYPE,
                                O_ID_ART_CUST IN LINEAS.ID_ARTICLE_CUSTOMER%TYPE,
                                O_ID_ART_PROV IN LINEAS.ID_ARTICLE_PROVIDER%TYPE,
                                O_CANT_REQ_CUST IN LINEAS.CANTIDAD_REQUEST_CUSTOMER%TYPE,
                                O_CANT_CONF_PROV IN LINEAS.CANTIDAD_CONFIRM_PROVIDER%TYPE,
                                O_DATE_ENTREGA IN LINEAS.DATE_ENTREGA%TYPE,
                                O_N_ALMACEN IN LINEAS.N_ALMACEN%TYPE,
                                O_COMENTS IN LINEAS.COMENTS%TYPE
                                )
        AS
            ---DECLARAR VARIABLES
        BEGIN
            UPDATE LINEAS
            SET N_ARTICLE_POSITION = O_N_ARTIC_POS,
                ID_ARTICLE_CUSTOMER = O_ID_ART_CUST,
                ID_ARTICLE_PROVIDER = O_ID_ART_PROV, 
                CANTIDAD_REQUEST_CUSTOMER = O_CANT_REQ_CUST,
                CANTIDAD_CONFIRM_PROVIDER = O_CANT_CONF_PROV,
                DATE_ENTREGA = O_DATE_ENTREGA,
                N_ALMACEN = O_N_ALMACEN,
                COMENTS = O_COMENTS
            WHERE O_ID = ID_CABECERO;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR'||sqlcode||' '||sqlerrm);
    END UPDATE_DATA_LINEAS;

END PAQUETE_UNO;

------EJECUCIÓN DE PAQUETE----
BEGIN
    PAQUETE_UNO.SHOW_DATA();
END;