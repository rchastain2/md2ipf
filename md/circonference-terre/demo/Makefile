
SOURCES := $(filter-out clockutils.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

ifndef FPGUI
FPGUI := ~/Documents/sources/fpgui
endif

PFLAGS := -Mobjfpc -Sh
PFLAGS += -FUunits

ifdef PPU
PFLAGS += -Fu$(FPGUI)/framework/target/units
else
PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib
PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib/x11
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/x11
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/render/software
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/gui
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/gui/db
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/3rdparty/regex
PFLAGS += -Fi$(FPGUI)/framework/target
PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib/render/software
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/render/software
#PFLAGS += -dAGGCanvas
endif

all: $(TARGETS)

%: %.pas
	@[ -d units ] || mkdir -p units
	@fpc $< $(PFLAGS)

clean:
	@rm -fv units/*.o units/*.ppu

distclean: clean
	@rm -fv $(TARGETS)
