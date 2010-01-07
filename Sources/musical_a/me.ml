(* Musical Elements *)
open Ma;;

(* Gammes *)
let cMajeur = new scala Do 0 0 0 0 0 0;;
let dMajeur  = new scala Re 0 0 0 0 0 0;;
let dDorien  = new scala Re (-1) 0 (-1) 0 0 0;;
let cDorien  = new scala Do (-1) 0 (-1) 0 0 0;;
let fMajeur  = new scala Fa 0 0 0 0 0 0;;


cMajeur#signature;;
cMajeur#norm;;
dDorien#signature;;
dDorien#norm;;
cMajeur#expand;;
dDorien#expand;;
dMajeur#expand;;
fMajeur#expand;;


