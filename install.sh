#!/usr/bin/env bash

### --------------------------------------------------------------------
###   install.sh | DevSecOps Platform Kit 2023
### --------------------------------------------------------------------
###   Installation script to install dsopk-shell-utils locally.
### --------------------------------------------------------------------
###   License: GNU GENERAL PUBLIC LICENSE Version 3
###            See the `LICENSE` file in the root of this code project for more details.
### --------------------------------------------------------------------
###   Syntax: $ /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/dsodk/dsopk-shell-utils/HEAD/install.sh)"
### --------------------------------------------------------------------

SCRIPT_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function set_variables {
  project_name="dsopk-shell-utils"
  dsopk_shell_utils_install_dir="${HOME}/.shell-utils-dsopk"

  #dsopk_shell_utils_repo_artifact_url="https://github.com/dsodk/${project_name}/archive/refs/heads/main.zip"
  dsopk_shell_utils_repo_artifact_url="https://github.com/dsodk/dsopk-shell-utils/archive/refs/heads/feat-initial-version.zip"
  dsopk_shell_utils_repo_artifact_target_filename="${project_name}.zip"
  dsopk_shell_utils_repo_artifact_branch_name=$(basename ${dsopk_shell_utils_repo_artifact_url} |awk -F '.zip' '{print $1}')
}

function fetch_project_artifact {
  echo "[INFO] Fetching ${dsopk_shell_utils_repo_artifact_target_filename} from ${dsopk_shell_utils_repo_artifact_url}"
  echo "[INFO] ${project_name} branch_name is ${dsopk_shell_utils_repo_artifact_branch_name}"
  (cd "/tmp" ; curl --fail -sLo "${dsopk_shell_utils_repo_artifact_target_filename}" "${dsopk_shell_utils_repo_artifact_url}" --silent)
}

function expand_project_artifact {
  rm -rf "/tmp/${project_name}" && mkdir -p "/tmp/${project_name}"
  echo "[INFO] Expanding ${dsopk_shell_utils_repo_artifact_target_filename} into ${dsopk_shell_utils_install_dir}"
  (cd "/tmp/${project_name}" ; unzip -qq "/tmp/${dsopk_shell_utils_repo_artifact_target_filename}" && rm -f "/tmp/${dsopk_shell_utils_repo_artifact_target_filename}")
}

function install_project_into_target_dir {
  mv "/tmp/${project_name}/${project_name}-${dsopk_shell_utils_repo_artifact_branch_name}" "${dsopk_shell_utils_install_dir}"
  echo "[INFO] ${project_name} installed into ${dsopk_shell_utils_install_dir}:"
  ls -la "${dsopk_shell_utils_install_dir}"
}

function cleanup {
  rm -rf "/tmp/${project_name}"
}

#################################
# MAINLINE
#################################
set_variables
fetch_project_artifact
expand_project_artifact
install_project_into_target_dir
cleanup

#################################
# END
#################################
