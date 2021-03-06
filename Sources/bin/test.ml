open Ma;;
open Sa;;
open Fa;;
open Me;;
open Se;;
open Fe;;


let string_to_file file s  =
  let channel = (open_out file) in
    output_string channel s;
    close_out channel;
;;

(* ----------------------- *)
(*    J'ai du bon tabac    *)
let n1 = new note Do 1 Croma Dummy_accento Dummy_intensita;;
let n2 = new note Re 1 Croma Dummy_accento Dummy_intensita;;
let n3 = new note Mi 1 Croma Dummy_accento Dummy_intensita;;
let n4 = new note S 1 Croma Dummy_accento Dummy_intensita;;
let n5 = new note Re 1 Semiminima Dummy_accento Dummy_intensita;;

let g1 = new group ([n1;n2]) cMajeur Crescendo Dummy_espresione Binario;;
let g2 = new group ([n3;n4])cMajeur Decrescendo Dummy_espresione Binario;;
let g3 = new group ([n5]) cMajeur Dummy_dinamica Dummy_espresione Binario;;

let p1 = new phrase [g1;g2;g3] ;;
let part1 = [p1;pOctava p1];;
(*
let n1 = new abstract_note 8 1 1 Pique Piano;;
let n2 = new abstract_note 8 8 2 Pique Dummy_ns;;
let n3 = new abstract_note 8 4 3 Dummy_as Dummy_ns;;
let n4 = new abstract_note 8 8 1 Dummy_as Dummy_ns;;
let n5 = new abstract_note 4 2 2 Tenu Dummy_ns;;

let n6 = new abstract_note 8 4 2 Dummy_as Dummy_ns;;
let n7 = new abstract_note 8 8 3 Dummy_as Dummy_ns;;
let n8 = new abstract_note 4 1 4 Dummy_as Dummy_ns;;
let n9 = new abstract_note 4 4 4 Dummy_as Dummy_ns;;
let n10 = new abstract_note 4 2 3 Dummy_as Dummy_ns;;
let n11 = new abstract_note 4 4 3 Dummy_as Dummy_ns;;


let n12 = new abstract_note 8 1 2 Dummy_as Dummy_ns;;
let n13 = new abstract_note 8 8 3 Dummy_as Dummy_ns;;
let n14 = new abstract_note 4 4 4 Dummy_as Dummy_ns;;
let n15 = new abstract_note 4 2 5 Dummy_as Dummy_ns;;
let n16 = new abstract_note 2 4 1 Dummy_as Dummy_ns;;


let g1 = new abstract_groupe ([n1;n2]) Dummy_ag cMajeur 1 Crescendo Binaire;;
let g2 = new abstract_groupe ([n3;n4]) Dummy_ag cMajeur 1 Decrescendo Binaire;;
let g3 = new abstract_groupe ([n5]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;

let g4 = new abstract_groupe ([n6;n7]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;
let g5 = new abstract_groupe ([n8]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;
let g6 = new abstract_groupe ([n9]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;
let g7 = new abstract_groupe ([n10]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;
let g8 = new abstract_groupe ([n11]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;


let g9 = new abstract_groupe ([n12;n13]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;
let g10 = new abstract_groupe ([n14]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;
let g11 = new abstract_groupe ([n15]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;
let g12 = new abstract_groupe ([n16]) Dummy_ag cMajeur 1 Dummy_ng Binaire;;



let p1 = new abstract_phrase [(grToTernaire g1);g2;g3] ;;
let p2 = new abstract_phrase [g4;g5;g6;g7;g8] ;;
let p3 = new abstract_phrase [g9;g10;g11;g12] ;;

let part1 = [p1;p2;p1;p3];;
*)
(*    J'ai du bon tabac    *)
(* ----------------------- *)


print_signature (p1#signature);;


(* Todo : Gravure de Partition *)
let lilypart1 = "{"^(List.fold_left (fun s -> fun (x:phrase) -> s^x#engraveToLily^" ") "" part1)^"}";;
string_to_file "music1.ly" lilypart1;;


let part2 = List.map pTodorien part1;;
let lilypart2 = "{"^(List.fold_left (fun s -> fun (x:phrase) -> s^x#engraveToLily^" ") "" part2)^"}";;
string_to_file "music2.ly" lilypart2;;
