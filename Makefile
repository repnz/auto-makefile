PROJECT_NAME := example-project
CC        := g++
SRCDIR    := src
HEADERDIR := include
BUILDDIR  := build
BINDIR    := bin
TARGET    := $(BINDIR)/$(PROJECT_NAME)
SOURCES   := $(shell find $(SRCDIR) -type f -name *.c*)
HEDEARS   := $(shell find $(HEADERDIR) -type f -name *.h*)
OBJECTS   := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(addsuffix .o,$(basename $(SOURCES))))
DEPS      := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(addsuffix .d,$(basename $(SOURCES))))
CFLAGS    := -Wall -Werror -Wextra
LIB       :=
INC       := -I include -I src

all: debug
debug: CFLAGS += -g
debug: $(TARGET)
release: $(TARGET)
release: CFLAGS += -O3

GREEN=`tput setaf 2`
RESET=`tput sgr0`

define print_green
	@echo "$(GREEN)$(1)$(RESET)"
endef

all: $(TARGET)

clean:
	rm $(BUILDDIR) $(BINDIR) -rf

$(TARGET): $(BINDIR) $(BUILDDIR) $(OBJECTS)
	$(call print_green,"Linking object files...")
	@$(CC) $(OBJECTS) -o $(TARGET) $(LIB)
	$(call print_green,"$(TARGET) has been created!")

$(BUILDDIR) :
	mkdir $(BUILDDIR)

$(BINDIR):
	mkdir $(BINDIR)
	
$(BUILDDIR)/%.o: $(SRCDIR)/%.c*
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<
	@$(CC) $(CFLAGS) $(INC) -M $< -MT $@ > $(@:.o=.td)
	@cp $(@:.o=.td) $(@:.o=.d); 
	@sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
	-e '/^$$/ d' -e 's/$$/ :/' < $(@:.o=.td) >> $(@:.o=.d); 
	@rm -f $(@:.o=.td)


-include $(DEPS)

.PHONY: clean all


