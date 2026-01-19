# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::p61password::deps()
#
#>
######################################################################
p6df::modules::p61password::deps() {
  ModuleDeps=(
	  p6m7g8-dotfiles/p6common
  )
}

######################################################################
#<
#
# Function: p6df::modules::p61password::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#>
######################################################################
p6df::modules::p61password::init() {
  local _module="$1"
  local dir="$2"

  p6_bootstrap "$dir"

  p6_return_void
}

######################################################################
#<
#
# Function: p6_1password_account_add(address, email)
#
#  Args:
#	address -
#	email -
#
#>
######################################################################
p6_1password_account_add() {
  local address="$1"
  local email="$2"

  op account add --address "$address" --email "$email"

  p6_return_void
}

######################################################################
#<
#
# Function: p6_1password_account_signin([account=$OP_ACCOUNT])
#
#  Args:
#	OPTIONAL account - [$OP_ACCOUNT]
#
#  Environment:	 OP_ACCOUNT
#>
#/ Synopsis:
#/   1. The account specified with the '--account' flag.
#/   2. The account specified by the 'OP_ACCOUNT' environment variable.
#/   3. The account you most recently signed in to with 'op signin' in any terminal window.
#/
#/   'op signin' is idempotent. It only prompts for authentication if you aren't already authenticated.
#/     1. The account specified with the '--account' flag.
#/     2. The account specified by the 'OP_ACCOUNT' environment variable.
#/     3. The account you most recently signed in to with 'op signin' in any terminal window.
#/
#/   'op signin' is idempotent. It only prompts for authentication if you aren't already authenticated.
######################################################################
p6_1password_account_signin() {
  local account="${1:-$OP_ACCOUNT}"

  # OP_SESSION_KEY
  eval "$(op signin --account "$account")"

  p6_env_export OP_ACCOUNT "$account"

  p6_return_void
}

######################################################################
#<
#
# Function: p6_1password_whoami()
#
#>
######################################################################
p6_1password_whoami() {

  op whoami

  p6_return_void
}

######################################################################
#<
#
# Function: str email = p6_1password_whoami_email()
#
#  Returns:
#	str - email
#
#  Environment:	 OP_EMAIL
#>
######################################################################
p6_1password_whoami_email() {

  local email=$(p6_1password_whoami | awk -F: '/Email/ { print $2}' | awk '{print $1}')
  p6_env_export OP_EMAIL "$email"

  p6_return_str "$email"
}

######################################################################
#<
#
# Function: p6_1password_vault_select(vault_name)
#
#  Args:
#	vault_name -
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_vault_select() {
  local vault_name="$1"

  p6_env_export OP_VAULT_NAME "$vault_name"

  p6_return_void
}

