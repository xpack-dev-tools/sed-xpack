#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2022 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

function application_build_versioned_components()
{
  XBB_SED_VERSION="$(echo "${XBB_RELEASE_VERSION}" | sed -e 's|-.*||')"
  if [[ "${XBB_SED_VERSION}" =~ [0-9]+[.][0-9]+[.]0 ]]
  then
    XBB_SED_VERSION="$(echo "${XBB_SED_VERSION}" | sed -e 's|.0$||')"
  fi

  # Keep them in sync with combo archive content.
  if [[ "${XBB_RELEASE_VERSION}" =~ 4[.]9[.].*-.* ]]
  then
    # -------------------------------------------------------------------------
    # Build the native dependencies.

    # None

    # -------------------------------------------------------------------------
    # Build the target dependencies.

    xbb_reset_env
    xbb_set_target "requested"

    # https://ftp.gnu.org/pub/gnu/libiconv/
    libiconv_build "1.17"

    # -------------------------------------------------------------------------
    # Build the application binaries.

    xbb_set_executables_install_path "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install_path "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

    # https://ftp.gnu.org/gnu/sed/
    sed_build "${XBB_SED_VERSION}"

    # -------------------------------------------------------------------------
  else
    echo "Unsupported ${XBB_APPLICATION_LOWER_CASE_NAME} version ${XBB_RELEASE_VERSION}"
    exit 1
  fi
}

# -----------------------------------------------------------------------------
