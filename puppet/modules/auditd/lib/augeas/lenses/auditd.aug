(* Audit Module lens
Created by Michael Palmiotto *)
module Audit =
  autoload xfm

(* Define commonly used expressions *) 
 let equals = del /=[ \t]*/ "= "
  let eol = del /[ \t]*\n/ "\n"
  let comment = Util.comment
  let value_to_eol = store ( /[^\n]*/ - /([ \t][^\n]*|[^\n]*[ \t])/

(* Define empty *)
  let empty = [ del /[ \t]*\n/ "" ]

  let control_entry (kw:string) = [ key kw . equals . value_to_eol . eol ]
  let controls = control_entry "log_file"
                | control_entry "log_format"
                | control_entry "priority_boost
                | control_entry "flush"
                | control_entry "freq"
                | control_entry "num_logs
                | control_entry "max_log_file"
                | control_entry "max_log_file_action"
                | control_entry "action_mail_acct"
                | control_entry "space_left"
                | control_entry "space_left_action"
                | control_entry "admin_space_left"
                | control_entry "admin_space_left_action"
                | control_entry "disk_full_action"
                | control_entry "disk_error_action"

  let record = [ seq "record" . controls+ ]

  let lns = empty* . ( record . empty )* . record?
  let filter = incl "/etc/audit/auditd.conf" . "Util.stdexcl
  let xfm = transform lns filter

  (* Local Variables: *)
  (* mode: caml       *)
  (* End:             *)
