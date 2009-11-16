# auto generated - do not edit

default: all

all:\
UNIT_TESTS/ccall.a UNIT_TESTS/ccall.o UNIT_TESTS/cstr.o UNIT_TESTS/t_assume \
UNIT_TESTS/t_assume.ali UNIT_TESTS/t_assume.o UNIT_TESTS/t_convert1 \
UNIT_TESTS/t_convert1.ali UNIT_TESTS/t_convert1.o UNIT_TESTS/t_convert2 \
UNIT_TESTS/t_convert2.ali UNIT_TESTS/t_convert2.o UNIT_TESTS/t_index1 \
UNIT_TESTS/t_index1.ali UNIT_TESTS/t_index1.o UNIT_TESTS/t_index2 \
UNIT_TESTS/t_index2.ali UNIT_TESTS/t_index2.o UNIT_TESTS/t_size1 \
UNIT_TESTS/t_size1.ali UNIT_TESTS/t_size1.o UNIT_TESTS/t_str1 \
UNIT_TESTS/t_str1.ali UNIT_TESTS/t_str1.o UNIT_TESTS/test.a UNIT_TESTS/test.ali \
UNIT_TESTS/test.o c_string-arrays.ali c_string-arrays.o c_string-conf \
c_string-conf.o c_string.a c_string.ali c_string.o ctxt/bindir.o ctxt/ctxt.a \
ctxt/dlibdir.o ctxt/fakeroot.o ctxt/incdir.o ctxt/repos.o ctxt/slibdir.o \
ctxt/version.o deinstaller deinstaller.o install-core.o install-posix.o \
install-win32.o install.a installer installer.o instchk instchk.o insthier.o

# Mkf-deinstall
deinstall: deinstaller conf-sosuffix
	./deinstaller
deinstall-dryrun: deinstaller conf-sosuffix
	./deinstaller dryrun

# Mkf-install
install: installer postinstall conf-sosuffix
	./installer
	./postinstall

install-dryrun: installer conf-sosuffix
	./installer dryrun

# Mkf-instchk
install-check: instchk conf-sosuffix
	./instchk

# Mkf-test
tests:
	(cd UNIT_TESTS && make)
tests_clean:
	(cd UNIT_TESTS && make clean)

#----------------------------------------------------------------------
# SYSDEPS start

_sd_sysinfo.h:
	@echo SYSDEPS sd-sysinfo run create _sd_sysinfo.h 
	@(cd SYSDEPS && ./sd-run modules/sd-sysinfo)


sd-sysinfo_clean:
	@echo SYSDEPS sd-sysinfo clean _sd_sysinfo.h 
	@(cd SYSDEPS && ./sd-clean modules/sd-sysinfo)


sysdeps_clean:\
sd-sysinfo_clean \



# SYSDEPS end
#----------------------------------------------------------------------

UNIT_TESTS/ccall.a:\
cc-slib UNIT_TESTS/ccall.sld UNIT_TESTS/ccall.o
	./cc-slib UNIT_TESTS/ccall UNIT_TESTS/ccall.o

UNIT_TESTS/ccall.o:\
cc-compile UNIT_TESTS/ccall.c
	./cc-compile UNIT_TESTS/ccall.c

UNIT_TESTS/cstr.o:\
cc-compile UNIT_TESTS/cstr.c
	./cc-compile UNIT_TESTS/cstr.c

UNIT_TESTS/t_assume:\
ada-bind ada-link UNIT_TESTS/t_assume.ald UNIT_TESTS/t_assume.ali \
UNIT_TESTS/ccall.o UNIT_TESTS/test.ali c_string-arrays.ali
	./ada-bind UNIT_TESTS/t_assume.ali
	./ada-link UNIT_TESTS/t_assume UNIT_TESTS/t_assume.ali UNIT_TESTS/ccall.o

UNIT_TESTS/t_assume.o UNIT_TESTS/t_assume.ali:\
ada-compile UNIT_TESTS/t_assume.adb c_string.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_assume.adb

UNIT_TESTS/t_convert1:\
ada-bind ada-link UNIT_TESTS/t_convert1.ald UNIT_TESTS/t_convert1.ali \
UNIT_TESTS/ccall.o UNIT_TESTS/test.ali c_string-arrays.ali
	./ada-bind UNIT_TESTS/t_convert1.ali
	./ada-link UNIT_TESTS/t_convert1 UNIT_TESTS/t_convert1.ali UNIT_TESTS/ccall.o

UNIT_TESTS/t_convert1.o UNIT_TESTS/t_convert1.ali:\
ada-compile UNIT_TESTS/t_convert1.adb c_string-arrays.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_convert1.adb

UNIT_TESTS/t_convert2:\
ada-bind ada-link UNIT_TESTS/t_convert2.ald UNIT_TESTS/t_convert2.ali \
UNIT_TESTS/ccall.o UNIT_TESTS/test.ali c_string-arrays.ali
	./ada-bind UNIT_TESTS/t_convert2.ali
	./ada-link UNIT_TESTS/t_convert2 UNIT_TESTS/t_convert2.ali UNIT_TESTS/ccall.o

UNIT_TESTS/t_convert2.o UNIT_TESTS/t_convert2.ali:\
ada-compile UNIT_TESTS/t_convert2.adb c_string-arrays.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_convert2.adb

UNIT_TESTS/t_index1:\
ada-bind ada-link UNIT_TESTS/t_index1.ald UNIT_TESTS/t_index1.ali \
UNIT_TESTS/ccall.o UNIT_TESTS/test.ali c_string-arrays.ali
	./ada-bind UNIT_TESTS/t_index1.ali
	./ada-link UNIT_TESTS/t_index1 UNIT_TESTS/t_index1.ali UNIT_TESTS/ccall.o

UNIT_TESTS/t_index1.o UNIT_TESTS/t_index1.ali:\
ada-compile UNIT_TESTS/t_index1.adb c_string-arrays.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_index1.adb

UNIT_TESTS/t_index2:\
ada-bind ada-link UNIT_TESTS/t_index2.ald UNIT_TESTS/t_index2.ali \
UNIT_TESTS/ccall.o UNIT_TESTS/test.ali c_string-arrays.ali
	./ada-bind UNIT_TESTS/t_index2.ali
	./ada-link UNIT_TESTS/t_index2 UNIT_TESTS/t_index2.ali UNIT_TESTS/ccall.o

UNIT_TESTS/t_index2.o UNIT_TESTS/t_index2.ali:\
ada-compile UNIT_TESTS/t_index2.adb c_string-arrays.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_index2.adb

UNIT_TESTS/t_size1:\
ada-bind ada-link UNIT_TESTS/t_size1.ald UNIT_TESTS/t_size1.ali \
UNIT_TESTS/ccall.o UNIT_TESTS/test.ali c_string-arrays.ali
	./ada-bind UNIT_TESTS/t_size1.ali
	./ada-link UNIT_TESTS/t_size1 UNIT_TESTS/t_size1.ali UNIT_TESTS/ccall.o

UNIT_TESTS/t_size1.o UNIT_TESTS/t_size1.ali:\
ada-compile UNIT_TESTS/t_size1.adb c_string-arrays.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_size1.adb

UNIT_TESTS/t_str1:\
ada-bind ada-link UNIT_TESTS/t_str1.ald UNIT_TESTS/t_str1.ali UNIT_TESTS/cstr.o \
c_string.ali
	./ada-bind UNIT_TESTS/t_str1.ali
	./ada-link UNIT_TESTS/t_str1 UNIT_TESTS/t_str1.ali UNIT_TESTS/cstr.o

UNIT_TESTS/t_str1.o UNIT_TESTS/t_str1.ali:\
ada-compile UNIT_TESTS/t_str1.adb c_string.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_str1.adb

UNIT_TESTS/test.a:\
cc-slib UNIT_TESTS/test.sld UNIT_TESTS/test.o
	./cc-slib UNIT_TESTS/test UNIT_TESTS/test.o

UNIT_TESTS/test.o UNIT_TESTS/test.ali:\
ada-compile UNIT_TESTS/test.adb UNIT_TESTS/test.ads
	./ada-compile UNIT_TESTS/test.adb

ada-bind:\
conf-adabind conf-systype conf-adatype conf-adabflags conf-adafflist flags-cwd

ada-compile:\
conf-adacomp conf-adatype conf-systype conf-adacflags conf-adafflist flags-cwd

ada-link:\
conf-adalink conf-adatype conf-systype conf-adaldflags

ada-srcmap:\
conf-adacomp conf-adatype conf-systype

ada-srcmap-all:\
ada-srcmap conf-adacomp conf-adatype conf-systype

c_string-arrays.ads:\
c_string.ali

c_string-arrays.o c_string-arrays.ali:\
ada-compile c_string-arrays.adb c_string.ali c_string-arrays.ads
	./ada-compile c_string-arrays.adb

c_string-conf:\
cc-link c_string-conf.ld c_string-conf.o ctxt/ctxt.a
	./cc-link c_string-conf c_string-conf.o ctxt/ctxt.a

c_string-conf.o:\
cc-compile c_string-conf.c ctxt.h _sd_sysinfo.h
	./cc-compile c_string-conf.c

c_string.a:\
cc-slib c_string.sld c_string-arrays.o c_string.o
	./cc-slib c_string c_string-arrays.o c_string.o

c_string.o c_string.ali:\
ada-compile c_string.adb c_string.ads
	./ada-compile c_string.adb

cc-compile:\
conf-cc conf-cctype conf-systype conf-cflags

cc-link:\
conf-ld conf-ldtype conf-systype conf-ldflags

cc-slib:\
conf-systype

conf-adatype:\
mk-adatype
	./mk-adatype > conf-adatype.tmp && mv conf-adatype.tmp conf-adatype

conf-cctype:\
conf-cc conf-cc mk-cctype
	./mk-cctype > conf-cctype.tmp && mv conf-cctype.tmp conf-cctype

conf-ldtype:\
conf-ld mk-ldtype
	./mk-ldtype > conf-ldtype.tmp && mv conf-ldtype.tmp conf-ldtype

conf-sosuffix:\
mk-sosuffix
	./mk-sosuffix > conf-sosuffix.tmp && mv conf-sosuffix.tmp conf-sosuffix

conf-systype:\
mk-systype
	./mk-systype > conf-systype.tmp && mv conf-systype.tmp conf-systype

# ctxt/bindir.c.mff
ctxt/bindir.c: mk-ctxt conf-bindir
	rm -f ctxt/bindir.c
	./mk-ctxt ctxt_bindir < conf-bindir > ctxt/bindir.c

ctxt/bindir.o:\
cc-compile ctxt/bindir.c
	./cc-compile ctxt/bindir.c

ctxt/ctxt.a:\
cc-slib ctxt/ctxt.sld ctxt/bindir.o ctxt/dlibdir.o ctxt/incdir.o ctxt/repos.o \
ctxt/slibdir.o ctxt/version.o ctxt/fakeroot.o
	./cc-slib ctxt/ctxt ctxt/bindir.o ctxt/dlibdir.o ctxt/incdir.o ctxt/repos.o \
	ctxt/slibdir.o ctxt/version.o ctxt/fakeroot.o

# ctxt/dlibdir.c.mff
ctxt/dlibdir.c: mk-ctxt conf-dlibdir
	rm -f ctxt/dlibdir.c
	./mk-ctxt ctxt_dlibdir < conf-dlibdir > ctxt/dlibdir.c

ctxt/dlibdir.o:\
cc-compile ctxt/dlibdir.c
	./cc-compile ctxt/dlibdir.c

# ctxt/fakeroot.c.mff
ctxt/fakeroot.c: mk-ctxt conf-fakeroot
	rm -f ctxt/fakeroot.c
	./mk-ctxt ctxt_fakeroot < conf-fakeroot > ctxt/fakeroot.c

ctxt/fakeroot.o:\
cc-compile ctxt/fakeroot.c
	./cc-compile ctxt/fakeroot.c

# ctxt/incdir.c.mff
ctxt/incdir.c: mk-ctxt conf-incdir
	rm -f ctxt/incdir.c
	./mk-ctxt ctxt_incdir < conf-incdir > ctxt/incdir.c

ctxt/incdir.o:\
cc-compile ctxt/incdir.c
	./cc-compile ctxt/incdir.c

# ctxt/repos.c.mff
ctxt/repos.c: mk-ctxt conf-repos
	rm -f ctxt/repos.c
	./mk-ctxt ctxt_repos < conf-repos > ctxt/repos.c

ctxt/repos.o:\
cc-compile ctxt/repos.c
	./cc-compile ctxt/repos.c

# ctxt/slibdir.c.mff
ctxt/slibdir.c: mk-ctxt conf-slibdir
	rm -f ctxt/slibdir.c
	./mk-ctxt ctxt_slibdir < conf-slibdir > ctxt/slibdir.c

ctxt/slibdir.o:\
cc-compile ctxt/slibdir.c
	./cc-compile ctxt/slibdir.c

# ctxt/version.c.mff
ctxt/version.c: mk-ctxt VERSION
	rm -f ctxt/version.c
	./mk-ctxt ctxt_version < VERSION > ctxt/version.c

ctxt/version.o:\
cc-compile ctxt/version.c
	./cc-compile ctxt/version.c

deinstaller:\
cc-link deinstaller.ld deinstaller.o insthier.o install.a ctxt/ctxt.a
	./cc-link deinstaller deinstaller.o insthier.o install.a ctxt/ctxt.a

deinstaller.o:\
cc-compile deinstaller.c install.h ctxt.h
	./cc-compile deinstaller.c

install-core.o:\
cc-compile install-core.c install.h
	./cc-compile install-core.c

install-posix.o:\
cc-compile install-posix.c install.h
	./cc-compile install-posix.c

install-win32.o:\
cc-compile install-win32.c install.h
	./cc-compile install-win32.c

install.a:\
cc-slib install.sld install-core.o install-posix.o install-win32.o
	./cc-slib install install-core.o install-posix.o install-win32.o

install.h:\
install_os.h

installer:\
cc-link installer.ld installer.o insthier.o install.a ctxt/ctxt.a
	./cc-link installer installer.o insthier.o install.a ctxt/ctxt.a

installer.o:\
cc-compile installer.c ctxt.h install.h
	./cc-compile installer.c

instchk:\
cc-link instchk.ld instchk.o insthier.o install.a ctxt/ctxt.a
	./cc-link instchk instchk.o insthier.o install.a ctxt/ctxt.a

instchk.o:\
cc-compile instchk.c ctxt.h install.h
	./cc-compile instchk.c

insthier.o:\
cc-compile insthier.c ctxt.h install.h
	./cc-compile insthier.c

mk-adatype:\
conf-adacomp conf-systype

mk-cctype:\
conf-cc conf-systype

mk-ctxt:\
mk-mk-ctxt
	./mk-mk-ctxt

mk-ldtype:\
conf-ld conf-systype conf-cctype

mk-mk-ctxt:\
conf-cc conf-ld

mk-sosuffix:\
conf-systype

mk-systype:\
conf-cc conf-ld

clean-all: sysdeps_clean tests_clean obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f UNIT_TESTS/ccall.a UNIT_TESTS/ccall.o UNIT_TESTS/cstr.o \
	UNIT_TESTS/t_assume UNIT_TESTS/t_assume.ali UNIT_TESTS/t_assume.o \
	UNIT_TESTS/t_convert1 UNIT_TESTS/t_convert1.ali UNIT_TESTS/t_convert1.o \
	UNIT_TESTS/t_convert2 UNIT_TESTS/t_convert2.ali UNIT_TESTS/t_convert2.o \
	UNIT_TESTS/t_index1 UNIT_TESTS/t_index1.ali UNIT_TESTS/t_index1.o \
	UNIT_TESTS/t_index2 UNIT_TESTS/t_index2.ali UNIT_TESTS/t_index2.o \
	UNIT_TESTS/t_size1 UNIT_TESTS/t_size1.ali UNIT_TESTS/t_size1.o \
	UNIT_TESTS/t_str1 UNIT_TESTS/t_str1.ali UNIT_TESTS/t_str1.o UNIT_TESTS/test.a \
	UNIT_TESTS/test.ali UNIT_TESTS/test.o c_string-arrays.ali c_string-arrays.o \
	c_string-conf c_string-conf.o c_string.a c_string.ali c_string.o ctxt/bindir.c \
	ctxt/bindir.o ctxt/ctxt.a ctxt/dlibdir.c ctxt/dlibdir.o ctxt/fakeroot.c \
	ctxt/fakeroot.o ctxt/incdir.c ctxt/incdir.o ctxt/repos.c ctxt/repos.o \
	ctxt/slibdir.c ctxt/slibdir.o ctxt/version.c ctxt/version.o deinstaller \
	deinstaller.o install-core.o install-posix.o install-win32.o install.a \
	installer installer.o instchk instchk.o insthier.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-sosuffix conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
