# auto generated - do not edit

default: all

all:\
UNIT_TESTS/cstr.o UNIT_TESTS/str1 UNIT_TESTS/str1.ali UNIT_TESTS/str1.o \
UNIT_TESTS/test.a UNIT_TESTS/test.ali UNIT_TESTS/test.o c_string.ali c_string.o

# Mkf-test
tests:
	(cd UNIT_TESTS && make)
tests_clean:
	(cd UNIT_TESTS && make clean)

UNIT_TESTS/cstr.o:\
cc-compile UNIT_TESTS/cstr.c
	./cc-compile UNIT_TESTS/cstr.c

UNIT_TESTS/str1:\
ada-bind ada-link UNIT_TESTS/str1.ald UNIT_TESTS/str1.ali UNIT_TESTS/cstr.o \
c_string.ali
	./ada-bind UNIT_TESTS/str1.ali
	./ada-link UNIT_TESTS/str1 UNIT_TESTS/str1.ali UNIT_TESTS/cstr.o

UNIT_TESTS/str1.ali:\
ada-compile UNIT_TESTS/str1.adb c_string.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/str1.adb

UNIT_TESTS/str1.o:\
UNIT_TESTS/str1.ali

UNIT_TESTS/test.a:\
cc-slib UNIT_TESTS/test.sld UNIT_TESTS/test.o
	./cc-slib UNIT_TESTS/test UNIT_TESTS/test.o

UNIT_TESTS/test.ali:\
ada-compile UNIT_TESTS/test.adb UNIT_TESTS/test.ads
	./ada-compile UNIT_TESTS/test.adb

UNIT_TESTS/test.o:\
UNIT_TESTS/test.ali

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

c_string.ali:\
ada-compile c_string.adb c_string.ads
	./ada-compile c_string.adb

c_string.o:\
c_string.ali

cc-compile:\
conf-cc conf-cctype conf-systype

cc-link:\
conf-ld conf-ldtype conf-systype

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

conf-systype:\
mk-systype
	./mk-systype > conf-systype.tmp && mv conf-systype.tmp conf-systype

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

mk-systype:\
conf-cc conf-ld

clean-all: tests_clean obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f UNIT_TESTS/cstr.o UNIT_TESTS/str1 UNIT_TESTS/str1.ali UNIT_TESTS/str1.o \
	UNIT_TESTS/test.a UNIT_TESTS/test.ali UNIT_TESTS/test.o c_string.ali c_string.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
