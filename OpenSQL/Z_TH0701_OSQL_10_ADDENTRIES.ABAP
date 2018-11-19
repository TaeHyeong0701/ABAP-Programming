*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL10_ADDENTRIES
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Data : `18.11.19
*& Subject: Create Table Entries Using PARAMETERS on Simple REPORT PROGRAM
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_OSQL10_ADDENTRIES.

DATA : it_tab TYPE TABLE OF zthsoccer,
      wa_tab LIKE LINE OF it_tab,
      num type i.
*----------------------------------------------------------------1. initialization variable
clear : num.
clear : it_tab.

*----------------------------------------------------------------2. Fetch Unique value
select *
  FROM ZTHSOCCER into CORRESPONDING FIELDS OF TABLE it_tab.
LOOP AT it_tab into wa_tab.
 num = num + 1.
ENDLOOP.
wa_tab-soccer_num = num.

*----------------------------------------------------------------3. PARAMETERS Define and transport value to the WorkArea.
PARAMETERS : TEAM TYPE ZTHC20.
wa_tab-team = team.
PARAMETERS : name TYPE ZTHC20.
wa_tab-name = name.
PARAMETERS : height TYPE ZTHI4.
wa_tab-height = height.
PARAMETERS : weight TYPE ZTHI4.
wa_tab-weight = weight.
PARAMETERS : position TYPE ZTHC20.
wa_tab-soccer_position = position.
PARAMETERS : nation TYPE ZTHC20.
wa_tab-nation = nation.
PARAMETERS : Salary TYPE ZTHI4.
wa_tab-salary = salary.

*----------------------------------------------------------------4. ADD Table Entries.
MODIFY zthsoccer FROM wa_tab.