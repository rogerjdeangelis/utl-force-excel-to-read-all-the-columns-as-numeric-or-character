Force excel to read all the columns as numeric or character
 
GitHub
https://tinyurl.com/ecmdhh43
https://github.com/rogerjdeangelis/utl-force-excel-to-read-all-the-columns-as-numeric-or-character
 
SAS Forum
https://tinyurl.com/7cz6fe4w
https://communities.sas.com/t5/SAS-Programming/How-to-import-all-variables-from-Excel-to-SAS-in-the-same/m-p/723311
 
*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|      _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| '_ \| '__/ _ \| '_ \| |/ _ \ '_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
;
 
* Here we create the excel workbook and sheet with 'character' numeric values (c1-c5);
* We want to import these as numeric;
 
* delete if you rerun;
%utlfkil(d:\xls\have.xlsx);
 
libname xel "d:/xls/have.xlsx" ;
 
data xel.have;
 
    array chrs[5] $4 c1-c5  ("100","200","300","400","500");
    array nums[5] n1-n5  (111,222,333,444,555);
 
    output;
    output;
    output;
    output;
 
run;quit;
 
libname xel clear;
 
* NOW LETS IMPORT THE EXCEL WORKBOOK WE CREATED ABOVE;
 
libname xel "d:/xls/have.xlsx" ;
 
  data have_as_sas_dataset;
      set xel.have;
  run;quit;
 
libname xel clear;
 
Data Set Name        WORK.HAVE_AS_SAS_DATASET      Observations          4
Member Type          DATA                          Variables             10
 
 Variable    Type    Len    Format  Value
 
 C1          Char      3    $3.     100   I NEED TO IMPORT THESE AS NUMBERS
 C2          Char      3    $3.     200   ..
 C3          Char      3    $3.     300   ..
 C4          Char      3    $3.     400   ..
 C5          Char      3    $3.     500   ..
 
 N1          Num       8            111
 N2          Num       8            222
 N3          Num       8            333
 N4          Num       8            444
 N5          Num       8            555
 
*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|
 
;
 
* Note you can use colclass=character if we want to import as data as character;
 
 %utl_submit_r64('
       library(xlsx);
       library(Hmisc);
       library(SASxport);
       want<-read.xlsx("d:/xls/have.xlsx",1,colClasses=rep("numeric",10),stringsAsFactors=FALSE);
       write.xport(want,file="d:/xpt/want.xpt");
    ');
 
* convert back to sas;
libname xpt xport "d:/xpt/want.xpt";
data want;
  set xpt.want;
run;quit;
libname xpt clear;
 
*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;
 
Data Set Name        WORK.WANT     Observations          4
Member Type          DATA          Variables             10
 
 Variables in Creation Order
 
 #    Variable    Type    Len
 
 1    C1          Num       8   * THEY ARE NOW NUMERIC
 2    C2          Num       8
 3    C3          Num       8
 4    C4          Num       8
 5    C5          Num       8
 
 6    N1          Num       8
 7    N2          Num       8
 8    N3          Num       8
 9    N4          Num       8
10    N5          Num       8
 
 
