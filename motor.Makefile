#
#  Copyright (c) 2017 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author  : Jeong Han Lee
# email   : han.lee@esss.se
# Date    : Friday, September  7 11:54:59 CEST 2018
# version : 0.0.3

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(E3_REQUIRE_TOOLS)/driver.makefile

ifneq ($(strip $(ASYN_DEP_VERSION)),)
asyn_VERSION=$(ASYN_DEP_VERSION)
endif


# *** ISSUES
# driver.makefile recursively read all include directories which were installed.
# The only way to exclude header files is....
iocStats_VERSION=
autosave_VERSION=
#asyn_VERSION=
busy_VERSION=
modbus_VERSION=
ipmiComm_VERSION=
sequencer_VERSION=
sscan_VERSION=

std_VERSION=
ip_VERSION=
calc_VERSION=
pcre_VERSION=
stream_VERSION=
s7plc_VERSION=
recsync_VERSION=

devlib2_VERSION=
mrfioc2_VERSION=

exprtk_VERSION=
#motor_VERSION=
ecmc_VERSION=
ethercatmc_VERSION=
ecmctraining_VERSION=


keypress_VERSION=
sysfs_VERSION=
symbolname_VERSION=
memDisplay_VERSION=
regdev_VERSION=
i2cDev_VERSION=

tosca_VERSION=
tsclib_VERSION=
ifcdaqdrv2_VERSION=

## The main issue is nds3, it is mandatory to disable it
## 
nds3_VERSION=
nds3epics_VERSION=
ifc14edrv_VERSION=
ifcfastint_VERSION=


nds_VERSION=
loki_VERSION=
nds_VERSION=
sis8300drv_VERSION=
sis8300_VERSION=
sis8300llrfdrv_VERSION=
sis8300llrf_VERSION=


ADSupport_VERSION=
ADCore_VERSION=
ADSimDetector_VERSION=
ADAndor_VERSION=
ADAndor3_VERSION=
ADPointGrey_VERSION=
ADProsilica_VERSION=

amcpico8_VERSION=
adpico8_VERSION=
adsis8300_VERSION=
adsis8300bcm_VERSION=
adsis8300bpm_VERSION=
adsis8300fc_VERSION=

# *** ISSUES


APP:=motorApp
APPDB:=$(APP)/Db


TEMPLATES += $(wildcard $(APPDB)/*.db)


MOTOR_SRC:=$(APP)/MotorSrc
#DELTATAU_SRC:=$(APP)/DeltaTauSrc
#OMS_SRC:=$(APP)/OmsSrc
SOFTMOTOR_SRC:=$(APP)/SoftMotorSrc
# MOTORSIM_SRC:=$(APP)/MotorSimSrc


USR_INCLUDES += -I$(where_am_I)$(MOTOR_SRC)
USR_INCLUDES += -I$(where_am_I)$(SOFTMOTOR_SRC)
USR_INCLUDES += -I$(where_am_I)$(MOTORSIM_SRC)


USR_CFLAGS   += -Wno-unused-variable
USR_CFLAGS   += -Wno-unused-function
USR_CFLAGS   += -Wno-unused-but-set-variable
USR_CPPFLAGS += -Wno-unused-variable
USR_CPPFLAGS += -Wno-unused-function
USR_CPPFLAGS += -Wno-unused-but-set-variable





## MOTOR_SRC
DBDINC_SRCS = $(MOTOR_SRC)/motorRecord.cc
DBDINC_DBDS = $(subst .cc,.dbd,   $(DBDINC_SRCS:$(MOTOR_SRC)/%=%))
DBDINC_HDRS = $(subst .cc,.h,     $(DBDINC_SRCS:$(MOTOR_SRC)/%=%))
DBDINC_DEPS = $(subst .cc,$(DEP), $(DBDINC_SRCS:$(MOTOR_SRC)/%=%))


HEADERS += $(MOTOR_SRC)/motor.h
HEADERS += $(MOTOR_SRC)/motordevCom.h
HEADERS += $(MOTOR_SRC)/motordrvCom.h
HEADERS += $(MOTOR_SRC)/motordrvComCode.h
HEADERS += $(MOTOR_SRC)/motor_interface.h
HEADERS += $(MOTOR_SRC)/paramLib.h
HEADERS += $(MOTOR_SRC)/asynMotorController.h
HEADERS += $(MOTOR_SRC)/asynMotorAxis.h

# ASYN
SOURCES += $(MOTOR_SRC)/asynMotorAxis.cpp
SOURCES += $(MOTOR_SRC)/asynMotorController.cpp
SOURCES += $(MOTOR_SRC)/paramLib.c
SOURCES += $(MOTOR_SRC)/devMotorAsyn.c
SOURCES += $(MOTOR_SRC)/drvMotorAsyn.c


# MOTOR
SOURCES += $(MOTOR_SRC)/motorUtilAux.cc
SOURCES += $(MOTOR_SRC)/motorUtil.cc
SOURCES += $(MOTOR_SRC)/motorDevSup.c
SOURCES += $(MOTOR_SRC)/motordrvCom.cc
SOURCES += $(MOTOR_SRC)/motordevCom.cc


DBDS    += $(MOTOR_SRC)/motorSupport.dbd


## SOFTMOTOR_SRC
SOURCES += $(SOFTMOTOR_SRC)/devSoft.cc
SOURCES += $(SOFTMOTOR_SRC)/devSoftAux.cc


DBDS    += $(SOFTMOTOR_SRC)/devSoftMotor.dbd



HEADERS += $(DBDINC_HDRS)
SOURCES += $(DBDINC_SRCS)


$(DBDINC_DEPS): $(DBDINC_HDRS)

.dbd.h:
	$(DBTORECORDTYPEH)  $(USR_DBDFLAGS) -o $@ $<


# db, vlibs rules are the default in RULES_E3, so add the empty one

db:

vlibs:
