#!/bin/bash

_yamlize_pass() {
  ${GPG} -d "${GPG_OPTS[@]}" "${PASSFILEPATH}" |
    tail -n +2 |
    grep -Pv '^otpauth://' |
    grep -P '^[^:]+:'
}

_validate_yaml() {
  _yamlize_pass | yq validate -
  return $?
}

_validate() {
  if [[ "${PASSFILEPATH}" == "" ]]; then
    die "Error: please specify a password"
  elif [[ ! -f "${PASSFILEPATH}" ]]; then
    die "Error: ${PASSFILE} is not in the password store"
  elif [[ "${YQ_EXPRESSION}" == "" ]]; then
    die "Error: please specify a yq expression"
  elif ! _validate_yaml; then
    die "Error: ${PASSFILE} is not valid yaml"
  fi
}

cmd_yaml_read() {
  _yamlize_pass | yq read - "${YQ_EXPRESSION}" "${@}" || exit $?
}

CMD=cmd_yaml_read
PASS_FILES=()
YQ_ARGS=()

case "${1}" in
  keys)
    CMD=cmd_yaml_read
    YQ_ARGS+=(-p p)
    shift
    ;;
  values)
    CMD=cmd_yaml_read
    YQ_ARGS+=(-p v)
    shift
    ;;
  *)
    CMD=cmd_yaml_read
    YQ_ARGS+=(-p pv)
    ;;
esac

PASSFILE="${1}"
PASSFILEPATH="${PREFIX}/${PASSFILE}.gpg"
YQ_EXPRESSION="${2:-*}"
check_sneaky_paths "${PASSFILEPATH}"

_validate
"${CMD}" "${YQ_ARGS[@]}"
