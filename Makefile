SRCDIR= src
BUILDDIR= obj_file
TARGET= Gain_Study

SRCTXT= cc
SOURCES= $(shell find $(SRCDIR) -type f -name *.$(SRCTXT))
OBJECTS= $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCTXT)=.o))
INC=-I include
INCDIR= include

CXXFLAGS=-g -m64 -O2 -Wall -std=c++0x $(INC)
ROOTFLAGS=$(shell root-config --libs --cflags --glibs)

$(TARGET): $(OBJECTS)
	g++ $^ -o $@ $(CXXFLAGS) $(ROOTFLAGS)

$(BUILDDIR)/main.o: $(SRCDIR)/main.cc $(SRCDIR)/setup_config.cc
	g++ -c $(CXXFLAGS) $(ROOTFLAGS) $^ -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCTXT) $(INCDIR)/%.h
	g++ -c $(CXXFLAGS) $(ROOTFLAGS) $< -o $@

clean:
	rm -f $(TARGET) $(BUILDDIR)/*.o include/*~ $(SRCDIR)/*~ ./*~

kill_test:
	rm -rf Module_Ntuple Module_TProfile
