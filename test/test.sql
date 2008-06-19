set serveroutput on size 1000000
spool test.log

@ut_hotsos_sysutil.pks
show errors
@ut_hotsos_sysutil.pkb
show errors
@ut_hotsos_ilo_task.pks
show errors
@ut_hotsos_ilo_task.pkb
show errors
@ut_hotsos_ilo_timer.pks
show errors
@ut_hotsos_ilo_timer.pkb
show errors

declare
  v_result BOOLEAN;
begin
  hotsos_sysutil.set_raise_exceptions(true);
  
  v_result := ut_hotsos_sysutil.run_tests;
  dbms_output.put_line(rpad('=',60,'='));
  dbms_output.put_line('*** Please verify that a trace file was generated with entries');
  dbms_output.put_line('*** corresponding to the preceding tests, and that an entry was');
  dbms_output.put_line('*** written to the alert log.');  
  dbms_output.put_line(rpad('=',60,'='));
  
  v_result := ut_hotsos_ilo_timer.run_tests;
  v_result := ut_hotsos_ilo_task.run_tests;
  
end;
/

drop package ut_hotsos_sysutil;
drop package ut_hotsos_ilo_task;
drop package ut_hotsos_ilo_timer;

-- exit session to clear any package states
exit


