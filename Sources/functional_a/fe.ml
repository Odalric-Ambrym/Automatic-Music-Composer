(* Functional Elements *)
open Fa;;
open Ma;;
open Me;;
open Sa;;

let notaOctava = altezzaMTonM (fun x -> x+1);;
let grOctava = note_listMTogrM (List.map notaOctava);;
let pOctava = grMTopM grOctava;;


let gTodorien g:scala = 
 new scala (g#i) (-1) 0 (-1) 0 0 0;;
let grTodorien = scalaMTogrBm gTodorien;;
let pTodorien = grMTopM grTodorien;;
let fDorien = gTodorien fMajeur;;


(*let rec copyUpToTpsfort l n  =
  match l with
    |[] -> []
    |h::t -> 
       if (h#tpsfort>n) then
	 h::copyUpToTpsfort t n
       else
	 [];;
*)
(*
let aux (l:abstract_notes) =

  let ll = ref l and lll = ref [] in

while (!ll <> []) do
  let x = hd !ll in
    match (x#duree) with
      |1|2|4 ->	(lll := x::!lll; ll := tl !ll;)
      |8 -> if (x#tpsfort = 4) then
	   begin
	   let l2 = copyUpToTpsfort (!ll) (4) in
	     lll := l2 @ !lll;
	     lll := (new abstract_note (x#duree/2) (x#tpsfort) (x#valeur) (x#artic) (x#nuance)):: (!lll);
	   end;
done;;

*)

(*
let grToTernaire g:abstract_groupe =
  match g#mode with
    |Ternaire -> g
    |Binaire ->
       new abstract_groupe
	 (List.map (fun (x:abstract_note) -> 
		      if (not (x#isfull)) 
		      then 
			new abstract_note (x#duree/2) (x#tpsfort) (x#valeur) (x#artic) (x#nuance)
		      else
			x) (g#notes))
	 (g#artic) (g#gamme) (g#hauteur) (g#nuance) Ternaire;;

*)
