#!/bin/env bash

# list of connectivity projects
PROJ_LIST=("$@")

AOSP_ROOT_DIR="${HOME}"/workspace_p
AOSP_OUT_DIR="${AOSP_ROOT_DIR}"/out
AOSP_CLION_DIR="${AOSP_OUT_DIR}"/development/ide/clion
CMAKE_PROJECT_PATH="${AOSP_CLION_DIR}"/CMakeLists.txt

AOSP_VCC_HW_DIR="${AOSP_CLION_DIR}"/vendor/volvocars/hardware

FIND_PATH=$(command -v find)
GREP_PATH=$(command -v grep)
DIRENAME_PATH=$(command -v dirname)

# remove existing CMakeLists.txt
rm -f "${CMAKE_PROJECT_PATH}" || true

cat << EOF > "${CMAKE_PROJECT_PATH}"
cmake_minimum_required(VERSION 3.6)
project(vcc_native)
EOF

function add_subdirectories() {
    for proj in $("${FIND_PATH}" "${AOSP_VCC_HW_DIR}"/"${1}" -name CMakeLists.txt); do
        dir=$("${DIRENAME_PATH}" "${proj}")
        "${GREP_PATH}" test <<< "${dir}" > /dev/null
        if test $? -ne 0; then
            "${GREP_PATH}" x86_64-android <<< "${dir}" > /dev/null
            if test $? -eq 0; then
                echo "add_subdirectory(${dir})" >> "${CMAKE_PROJECT_PATH}"
            fi
        fi
    done
}

if test "${#PROJ_LIST[@]}" -ne 0; then
    for item in "${PROJ_LIST[@]}"; do
        add_subdirectories "${item}"
    done
else
    add_subdirectories
fi

exit 0
