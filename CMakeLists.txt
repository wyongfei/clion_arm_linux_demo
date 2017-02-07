#SET ENV IN /etc/profile
#
#export STAGING_DIR=/home/ramips/staging_dir/
#export PATH=/home/ramips/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/bin:$PATH
#
#export OPENWRT_LIB=/home/ramips/staging_dir/target-mipsel_24kec+dsp_uClibc-0.9.33.2/usr/lib/
#export OPENWRT_INC=/home/ramips/staging_dir/target-mipsel_24kec+dsp_uClibc-0.9.33.2/usr/include/
#
#export RAMIPS_CC=/home/ramips/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/bin/mipsel-openwrt-linux-gcc
#export RAMIPS_CXX=/home/ramips/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/bin/mipsel-openwrt-linux-g++

#back system include path -- mv /usr/include /usr/include-back

cmake_minimum_required(VERSION 3.6)

set(CMAKE_C_COMPILER   $ENV{RAMIPS_CC})
set(CMAKE_CXX_COMPILER $ENV{RAMIPS_CXX})

project(cmake)

MESSAGE(STATUS "Project: ${PROJECT_NAME}")
MESSAGE(STATUS "Project Directory: ${PROJECT_SOURCE_DIR}")
MESSAGE(STATUS "CC $ENV{RAMIPS_CC}")
MESSAGE(STATUS "CXX $ENV{RAMIPS_CXX}")

################################################################################
# cross compilation tools
set(CROSS_GCC_FULL_PATH $ENV{RAMIPS_CC})
get_filename_component(CROSS_COMPIL_TOOLS ${CROSS_GCC_FULL_PATH} PATH)
if (NOT EXISTS ${CROSS_COMPIL_TOOLS})
    message (FATAL_ERROR "Can't find cross compilation tool chain")
endif()



SET(CPREF				${CROSS_COMPIL_TOOLS}/mipsel-openwrt-linux)
SET(CMAKE_C_COMPILER	${CPREF}-gcc CACHE STRING "mipsel-openwrt-gcc" FORCE)
SET(CMAKE_CXX_COMPILER	${CPREF}-g++ CACHE STRING "mipsel-openwrt-g++" FORCE)
SET(AS					"${CROSS_COMPIL_TOOLS}/mipsel-openwrt-gcc -x -assembler-with-cpp"  CACHE STRING "mipsel-openwrt-as")
SET(CMAKE_AR			${CPREF}-ar CACHE STRING "mipsel-openwrt-ar" FORCE)
SET(CMAKE_LD			${CPREF}-ld CACHE STRING "mipsel-openwrt-ld" FORCE)
SET(NM					${CPREF}-nm CACHE STRING "mipsel-openwrt-nm" FORCE)
SET(OBJCOPY				${CPREF}-objcopy CACHE STRING "mipsel-openwrt-objcopy" FORCE)
SET(OBJDUMP				${CPREF}-objdump CACHE STRING "mipsel-openwrt-objdump" FORCE)
SET(READELF				${CPREF}-readelf CACHE STRING "mipsel-openwrt-readelf" FORCE)
SET(CMAKE_RANLIB		${CPREF}-ranlib CACHE STRING "mipsel-openwrt-ranlib" FORCE)


################################################################################

include_directories(BEFORE SYSTEM
        "$ENV{OPENWRT_INC}"
        )

link_directories(
        "$ENV{OPENWRT_LIB}"
)

set(CMAKE_C_STANDARD 99)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)

set(SOURCE_FILES main.c)

add_executable(cmake ${SOURCE_FILES})

