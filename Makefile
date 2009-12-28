CC = ocamlopt
CMXA = unix.cmxa str.cmxa graphics.cmxa

BINARIES = Binaries/
SOURCES = Sources/

SMA = $(SOURCES)musical_a/
SSA = $(SOURCES)structural_a/
SFA = $(SOURCES)functional_a/
SBIN = $(SOURCES)bin/
BBIN = $(BINARIES)bin/
BLIB = $(BINARIES)lib/


LMA = $(BLIB)ma.cmx
LME = $(BLIB)me.cmx
LSA = $(BLIB)sa.cmx
LSE = $(BLIB)se.cmx
LFA = $(BLIB)fa.cmx
LFE = $(BLIB)fe.cmx

CMX = $(LMA) $(LME) $(LSA) $(LSE) $(LFA) $(LFE)
TARGETS = Prog

NameG = automaticMusicComposer

all : $(TARGETS)

#$ Création de l'executable du Projet
Prog : $(BLIB)test.cmx 
	$(CC) -o $(BBIN)$(NameG) -I $(BLIB) $(CMX) $(BLIB)test.cmx

$(BLIB)test.cmx : $(LFE) $(LFA) $(LSE) $(LSA) $(LME) $(LMA) $(SBIN)test.ml
	$(CC) -o $@ -I $(BLIB) $(LMA) $(LME) $(LSA) $(LSE) $(LFA) $(LFE) -c $(SBIN)test.ml

$(BLIB)fe.cmx : $(LMA) $(LSA) $(LFA) $(LME) $(LSE) $(SFA)fe.ml
	$(CC) -o $@ -I $(BLIB) $(LMA) $(LSA) $(LFA) $(LME) $(LSE) -c $(SFA)fe.ml
$(BLIB)se.cmx : $(LMA) $(LSA) $(LME) $(SSA)se.ml
	$(CC) -o $@ -I $(BLIB) $(LMA) $(LSA) $(LSE) -c $(SSA)se.ml
$(BLIB)me.cmx : $(LMA) $(SMA)me.ml
	$(CC) -o $@ -I $(BLIB) $(LMA) -c $(SMA)me.ml
$(BLIB)fa.cmx : $(LMA) $(LSA) $(SFA)fa.ml
	$(CC) -o $@ -I $(BLIB) $(LMA) $(LSA) -c $(SFA)fa.ml
$(BLIB)sa.cmx : $(LMA) $(SSA)sa.ml
	$(CC) -o $@ -I $(BLIB) $(LMA) -c $(SSA)sa.ml
$(BLIB)ma.cmx : $(SMA)ma.ml
	$(CC) -o $@ -c $(SMA)ma.ml
#$ ***************************************************************** $#
clean:
	@echo
	@echo "*******************************"
	@echo "**    Début du nettoyage     **"
	@echo "*******************************"
	@echo
	rm -f *~	
	rm -f *.cmx
	@echo
	@echo "*******************************"
	@echo "**     Fin du Nettoyage      **"
	@echo "*******************************"
	@echo
clean_all: 
	@echo
	@echo "*******************************"
	@echo "**    Début du nettoyage     **"
	@echo "*******************************"
	@echo
	rm -f *~
	rm -f $(NameG)	
	rm -f *.cmx
	@echo
	@echo "*******************************"
	@echo "**     Fin du Nettoyage      **"
	@echo "*******************************"
	@echo