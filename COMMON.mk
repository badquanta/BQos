include DIRS.mk
CONFIG_STATUS := config.status
PROJECT_GCFLAGS := \
	-fno-omit-frame-pointer \
	-Wall \
	-static \
	-Wextra \
	-pedantic \
	-Wshadow \
	-Wpointer-arith \
	-Wcast-align \
	-Wwrite-strings \
	-Wmissing-declarations \
	-Wredundant-decls \
	-Winline \
	-Wno-long-long \
	-Wconversion \
	-Wno-write-strings \
	-MD
# TODO: Do we need GAS flags?
PROJECT_GASFLAGS +=	
################################################################### MACROS
# Some macros used for debugging/output/status.
UPDATE_STATUS = mkdir -p "./logs$(@D)"; $(STATUSVG) "$@" "./logs$@.svg"
#REDIRECT :=  >> $(PREFIX)/build.log 2>&1
GIT_SHALLOW		:= git clone --depth 1 --single-branch --branch
CLEAN	:= - rm -frv
REACHED := @ date >>  
STATUS	:= @./sh/status.sh 
STATUSVG:= ./sh/status.svg.sh 
## ^ OR v  ##
#REDIRECT := 2>&1 | tee --output-error=warn -a