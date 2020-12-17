-- 101 IMPORT ERROR 102 EXPORT ERROR

CREATE OR REPLACE DIRECTORY UTLDATA AS 'C:\DB\XML\';
--DROP DIRECTORY UTLDATA;
--------------------------------------------------------------------------------
--DROP PACKAGE XML_PACKAGE;
CREATE OR REPLACE PACKAGE XML_PACKAGE IS
  PROCEDURE EXPORT_BRAND_TO_XML;
  PROCEDURE IMPORT_BRAND_FROM_XML;
END XML_PACKAGE;
--------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY XML_PACKAGE IS
--------------------------------------------------------------------------------
PROCEDURE EXPORT_BRAND_TO_XML
IS
  DOC  DBMS_XMLDOM.DOMDocument;                                                                                        
  XDATA  XMLTYPE;                                                                                                                                                                                                                
  CURSOR XMLCUR IS                                                                                                     
    SELECT XMLELEMENT("brand",    
      XMLAttributes('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",                        
      'http://www.oracle.com/Employee.xsd' AS "xsi:nonamespaceSchemaLocation"),
      XMLAGG(XMLELEMENT("BRAND",
        XMLELEMENT("ID",U.ID_BRAND),
        XMLELEMENT("BRAND",U.BRAND)      
      ))                                                                                                                                   
) FROM BRAND U; 
BEGIN
  OPEN XMLCUR;
    LOOP 
      FETCH XMLCUR INTO XDATA;                                                                                             
    EXIT WHEN XMLCUR%NOTFOUND;
    END LOOP;
  CLOSE XMLCUR;                                                                                                        
  DOC := DBMS_XMLDOM.NewDOMDocument(XDATA);                                                                            
  DBMS_XMLDOM.WRITETOFILE(DOC, 'UTLDATA/BRAND.xml');
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20102, 'EXPORT XML ERROR');
END EXPORT_BRAND_TO_XML;
--------------------------------------------------------------------------------
PROCEDURE IMPORT_BRAND_FROM_XML
IS
  L_CLOB CLOB;
  L_BFILE  BFILE := BFILENAME('UTLDATA', 'BRAND.xml');
  
  L_DEST_OFFSET   INTEGER := 1;
  L_SRC_OFFSET    INTEGER := 1;
  L_BFILE_CSID    NUMBER  := 0;
  L_LANG_CONTEXT  INTEGER := 0;
  L_WARNING       INTEGER := 0;
  
  P                DBMS_XMLPARSER.PARSER;
  V_DOC            DBMS_XMLDOM.DOMDOCUMENT;
  V_ROOT_ELEMENT   DBMS_XMLDOM.DOMELEMENT;
  V_CHILD_NODES    DBMS_XMLDOM.DOMNODELIST;
  V_CURRENT_NODE   DBMS_XMLDOM.DOMNODE;
   
  U BRAND%ROWTYPE;
BEGIN
  DBMS_LOB.CREATETEMPORARY (L_CLOB, TRUE);
  DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
  
  DBMS_LOB.LOADCLOBFROMFILE (DEST_LOB => L_CLOB, SRC_BFILE => L_BFILE, AMOUNT => DBMS_LOB.LOBMAXSIZE,
    DEST_OFFSET => L_DEST_OFFSET, SRC_OFFSET => L_SRC_OFFSET, BFILE_CSID => L_BFILE_CSID,
    LANG_CONTEXT => L_LANG_CONTEXT, WARNING => L_WARNING);
  DBMS_LOB.FILECLOSE(L_BFILE);
  COMMIT;
    -- Create XML Parser.
   P := DBMS_XMLPARSER.NEWPARSER;
   -- Parse XML into DOM object                        
   DBMS_XMLPARSER.PARSECLOB(P,L_CLOB);
   -- Document Element              
   V_DOC := DBMS_XMLPARSER.GETDOCUMENT(P);
   -- Root element 
   V_ROOT_ELEMENT := DBMS_XMLDOM.Getdocumentelement(v_Doc);
   --- return Dbms_Xmldom.Domnodelist
   V_CHILD_NODES := DBMS_XMLDOM.GETCHILDRENBYTAGNAME(V_ROOT_ELEMENT,'*');
  
   FOR i IN 0 .. DBMS_XMLDOM.GETLENGTH(V_CHILD_NODES) - 1
   LOOP
      -- <USER> Node.
      V_CURRENT_NODE := DBMS_XMLDOM.ITEM(V_CHILD_NODES,i);
      
      DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE,
        'ID_BRAND/text()',U.ID_BRAND);
      DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE,
        'BRAND/text()',U.BRAND);
  
     INSERT INTO BRAND(ID_BRAND,BRAND) 
       VALUES(I+1,U.BRAND) ;
   END LOOP;
  
  DBMS_LOB.FREETEMPORARY(L_CLOB);
  DBMS_XMLPARSER.FREEPARSER(P);
  DBMS_XMLDOM.FREEDOCUMENT(V_DOC);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
  DBMS_LOB.FREETEMPORARY(L_CLOB);
  DBMS_XMLPARSER.FREEPARSER(P);
  DBMS_XMLDOM.FREEDOCUMENT(V_DOC);
  RAISE_APPLICATION_ERROR(-20101, 'IMPORT XML ERROR'|| SQLERRM);
END IMPORT_BRAND_FROM_XML;
--------------------------------------------------------------------------------
END XML_PACKAGE;
--------------------------------------------------------------------------------
BEGIN XML_PACKAGE.import_BRAND_from_XML;END;
BEGIN XML_PACKAGE.EXPORT_BRAND_TO_XML;END;
DROP PACKAGE XML_PACKAGE;