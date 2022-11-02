(* This script is absolutely awful but it works. That's everything we need. *)

if (not Sys.unix) then begin
  print_endline "This installer only works for *nix-based operating systems.";
  exit 1;
end;;

#load "unix.cma";;

open Unix;;

let home : string = Unix.getenv "HOME";;
let cwd : string = Unix.getcwd();;

let dot_vscode : string = home ^ "/.vscode";;
let extensions : string = dot_vscode ^ "/extensions";;
let w_extension : string = extensions ^ "/w.w-language-0.0.1";;

let lang_config : string = cwd ^ "/language-configuration.json";;
let syntaxes : string = cwd ^ "/syntaxes/";;

if not (Sys.file_exists dot_vscode) then begin
  print_endline "Visual Studio Code does not appear to be installed on this machine.";
  exit 1;
end;;

if not (Sys.file_exists extensions) then begin
  Sys.mkdir extensions 0o755;
end;;

if not (Sys.file_exists w_extension) then begin
  Sys.mkdir w_extension 0o755;
end;;

(* Apparently, OCaml does not have a built-in function to copy a file/directory. Not very convenient. *)

Sys.command ("cp " ^ lang_config ^ " " ^ w_extension);;
Sys.command ("cp -R " ^ syntaxes ^ " " ^ w_extension);;
