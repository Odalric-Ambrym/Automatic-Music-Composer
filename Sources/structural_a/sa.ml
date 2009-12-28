(* Structural Abstraction *)

open Ma;;

class note nota altezza durata accento intensita = 
object 
  val nota = nota
  method nota = nota
  val altezza = altezza
  method altezza = altezza
  val durata = durata
  method durata = durata
  val accento = accento
  method accento = accento
  val intensita = intensita
  method intensita = intensita

(* Converter *)
  method engraveToLily = 
    let s_durata = Ma.durataToLily durata in 
    let s_altezza = Ma.altezzaToLily altezza in
    let s_intensita =  Ma.intensitaToLily intensita in
    let s_accento =  Ma.accentoToLily accento in
    let s_nota = Ma.notaToLily nota in
      s_nota^s_altezza^s_durata^s_accento^s_intensita^" "
end;;

let valueScala (n:note) (s:scala) = notaToValueScala (n#nota) s;;

(*
let valueDurata (n:note) (g:group) =
    1./. (float_of_int (durataToValue (n#durata)));;
  method valueDurata =
    match mode_rythmique with
      |Ternaire ->
	(List.fold_left (+.) 0.
	  (List.map (function (x:note) -> x#duree_reelle) notes))*.(2./.3.)
      | Binaire ->
	  List.fold_left (+.) 0.
	    (List.map (function (x:note) -> x#duree_reelle) notes)
*)


class group note_list scala dinamica espresione ritmo =
object
  val note_list = note_list
  method note_list = note_list
  val scala = scala
  method scala = scala
  val dinamica = dinamica
  method dinamica = dinamica
  val espresione = espresione
  method espresione = espresione
  val ritmo = ritmo
  method ritmo = ritmo
(* Features *)
(* i.e. perte d'information *)
  method numberOfNotes = 
    List.length note_list
  method timeLength =
    match ritmo with
       |Binario ->
	  (List.fold_left (+.) 0.
	     (List.map (function (n:note) -> durataToTimeLength (n#durata)) note_list))
       |Ternario ->
	  (List.fold_left (+.) 0.
	     (List.map (function (n:note) -> durataToTimeLength (n#durata)) note_list))*.(2./.3.)
(* Converter *)
(* pas de perte d'information *)
  method note_listToValueScala = 
    List.map (fun x -> notaToValueScala (x#nota) scala) note_list
  method note_listToInterval_list =  ()
  method engraveToLily =
    let s_espresione = espresioneToLily espresione in
    let s_dinamica = dinamicaToLily dinamica in
    let s_note = (List.hd note_list)#engraveToLily in
    let s_notes = List.fold_left (^) "" (List.map (function (x:note)-> x#engraveToLily) (List.tl note_list)) in
      if (ritmo = Ternario) then
	"\\times 2/3 {"^s_note^(fst s_espresione)^(fst s_dinamica)^s_notes^(snd s_dinamica)^(snd s_espresione)^" } "
      else
	s_note^(fst s_espresione)^(fst s_dinamica)^s_notes^(snd s_dinamica)^(snd s_espresione)^" "

end;;

(* Faut-il voir une mesure comme une structure, ou plutôt comme une fonction trasformant une liste de notes en  liste de temps forts ? et voir du coup une phrase comme structure *)
(* function mesure group_list param = ... -> liste de (notes,temps forts) (complétée par des blancs si trop court) *)

class phrase group_list =
object
  val group_list = group_list
  method group_list = group_list
  method signature =
    List.map (function (x:group) -> (x#timeLength,x#numberOfNotes)) group_list
  method engraveToLily =
    List.fold_left (^) "" (List.map (function (x:group) -> x#engraveToLily) group_list)
end;;

let rec print_signature s =
  match s with
    |[] -> print_newline();
    |x::q -> 
       begin
	 print_string "(";print_float (fst x);
	 print_string",";print_int (snd x);
	 print_string ");";print_signature q;
       end;;



(*
class abstract_note duree tpsfort valeur artic nuance= 
object
  val duree = duree (* duree lilypond *)
  method duree = duree
  val tpsfort = tpsfort
  method tpsfort = tpsfort
  method isfull = 
    (duree = tpsfort)
  val valeur = valeur
  method valeur = valeur
  val artic = artic
  method artic = artic
  val nuance = nuance
  method nuance = nuance
  method duree_reelle =
   1. /. float_of_int(duree)
  method toLily (gamme:Ma.gamme)  hauteur  =
    let s_duree = string_of_int duree in 
    let s_hauteur = Ma.hauteurToLily hauteur in
    let s_nuance =  Ma.nuance_simpleToLily(nuance) in
    let s_artic =  Ma.artic_simpleToLily(artic) in
    let s_valeur = Ma.valeurToLily valeur gamme in
      s_valeur^s_hauteur^s_duree^s_artic^s_nuance^" "
end;;

class abstract_groupe notes artic gamme hauteur nuance mode_rythmique =
object
  val notes = notes
  method notes = notes
  val artic = artic
  method artic = artic
  val gamme = gamme
  method gamme = gamme
  val hauteur = hauteur
  method hauteur = hauteur
  val nuance = nuance
  method nuance = nuance
  val mode = mode_rythmique
  method mode = mode_rythmique
  method duree_reelle =
    match mode_rythmique with
      |Ternaire ->
	(List.fold_left (+.) 0.
	  (List.map (function (x:abstract_note) -> x#duree_reelle) notes))*.(2./.3.)
      | Binaire ->
	  List.fold_left (+.) 0.
	    (List.map (function (x:abstract_note) -> x#duree_reelle) notes)
  method nombre_de_notes =
    List.length notes
  method pattern =
    List.map (function (x:abstract_note) -> x#tpsfort) notes
  method toLily =
    let s_artic = artic_groupeToLily(artic) in
    let s_nuance = nuance_groupeToLily(nuance) in
    let s_fnote = (List.hd notes)#toLily gamme  hauteur in
    let s_notes = List.fold_left (^) "" (List.map (function (x:abstract_note)-> x#toLily gamme hauteur) (List.tl notes)) in
      if (mode = Ternaire) then
	"\\times 2/3 {"^s_fnote^(fst s_artic)^(fst s_nuance)^s_notes^(snd s_nuance)^(snd s_artic)^" } "
      else
	s_fnote^(fst s_artic)^(fst s_nuance)^s_notes^(snd s_nuance)^(snd s_artic)^" "
end;;
*)


(*
class abstract_phrase groupes =
object
  val groupes = groupes
  method groupes = groupes
  method signature =
   List.map (function (x:abstract_groupe) -> (x#duree_reelle,x#nombre_de_notes)) groupes  
  method toLily =
    List.fold_left (^) "" (List.map (function (x:abstract_groupe) -> x#toLily) groupes)
end;;

class abstract_score graphe =
object
  val graphe = graphe
end;;
*)
