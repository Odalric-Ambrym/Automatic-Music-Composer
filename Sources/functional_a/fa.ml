(* Functional Abstraction *)
open Ma;;
open Sa;;

(* Groupes :*)
(* Notes modifiers *)

(*
let aux   notes = 
   List.fold_left (+.) 0.
   (List.map (function (x:abstract_note) -> x#duree_reelle) notes);;

let aux2 l s =
  match (s mod 2,l) with
    | _,[] -> []
    | 0,d::q -> 8 8 -> 2/3 4 8

let ternaire ln =
  let ld = List.map (function (x:abstract_note) -> x#duree) notes in
  let s = ref 0 in
    for i=1 to length ld do
      if (s mod 2 = 0) then
	
    done

;;*)


(* Note Modifiers *)
let notaMTonM m = 
  fun (n:Sa.note) -> 
    new Sa.note (m n#nota) (n#altezza) (n#durata) (n#accento) (n#intensita);;
let altezzaMTonM m = 
  fun (n:Sa.note) -> 
    new Sa.note (n#nota) (m n#altezza) (n#durata) (n#accento) (n#intensita);;
let durataMTonM m = 
  fun (n:Sa.note) -> 
    new Sa.note (n#nota) (n#altezza) (m n#durata) (n#accento) (n#intensita);;
let accentoMTonM m = 
  fun (n:Sa.note) -> 
    new Sa.note (n#nota) (n#altezza) (n#durata) (m n#accento) (n#intensita);;
let intensitaMTonM m = 
  fun (n:Sa.note) -> 
    new Sa.note  (n#nota) (n#altezza) (n#durata) (n#accento) (m n#intensita);;

(* ? *)
let notaScalaConverter (s1:scala) (s2:scala) nota =
List.nth (s2#expand) ((notaToValueScala nota s1)-1);;
(* Group Modifiers *)
(* Note_list modifiers *)
let note_listMTogrM m = 
  fun (g:Sa.group) -> 
    new Sa.group (m g#note_list) (g#scala) (g#dinamica) (g#espresione) (g#ritmo);;
(* Scala modifiers *)
let scalaMTogrM m = 
  fun (g:Sa.group) -> 
    new Sa.group (g#note_list) (m g#scala) (g#dinamica) (g#espresione) (g#ritmo);;
(* Dinamica modifiers *)
let dinamicaMTogrM m = 
  fun (g:Sa.group) -> 
    new Sa.group (g#note_list) (g#scala) (m g#dinamica) (g#espresione) (g#ritmo);;
(* Espresione modifiers *)
let espresioneMTogrM m = 
fun (g:Sa.group) -> 
 new Sa.group (g#note_list) (g#scala) (g#dinamica) (m g#espresione) (g#ritmo);;
(* Dinamica modifiers *)
let ritmoMTogrM m = 
fun (g:Sa.group) -> 
 new Sa.group (g#note_list) (g#scala) (g#dinamica) (g#espresione) (m g#ritmo);;

(* scala Back modifers *) 
(* Modifies the scala and convert the notes to the corresponding one in the new scala *)
let scalaMTogrBm sm = 
  fun (g:Sa.group) ->
    note_listMTogrM (List.map ( notaMTonM (notaScalaConverter (g#scala) (sm g#scala))) ) (scalaMTogrM sm g);;

(* Phrases : *)
let grMTopM m = 
fun (p:phrase) -> 
  new phrase (List.map m (p#group_list));;


