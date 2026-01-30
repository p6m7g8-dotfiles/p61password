# shellcheck shell=bash

######################################################################
#<
#
# Function: stream  = p6_1password_cli(...)
#
#  Args:
#	... - 
#
#  Returns:
#	stream - 
#
#>
######################################################################
p6_1password_cli() {
  shift 0

  p6_log "op $*"
  op "$@"

  p6_return_stream
}

######################################################################
#<
#
# Function: stream  = p6_1password_cli_vaults_list()
#
#  Returns:
#	stream - 
#
#>
######################################################################
p6_1password_cli_vaults_list() {

  p6_1password_cli vault list

  p6_return_stream
}

######################################################################
#<
#
# Function: stream  = p6_1password_cli_vault_list([vault_name=$OP_VAULT_NAME])
#
#  Args:
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Returns:
#	stream - 
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_vault_list() {
  local vault_name="${1:-$OP_VAULT_NAME}"

  p6_1password_cli item list --vault "$vault_name" --include-archive

  p6_return_stream
}

######################################################################
#<
#
# Function: stream  = p6_1password_cli_item_get(item_id, [vault_name=$OP_VAULT_NAME])
#
#  Args:
#	item_id -
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Returns:
#	stream - 
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_item_get() {
  local item_id="$1"
  local vault_name="${2:-$OP_VAULT_NAME}"

  p6_1password_cli item get "$item_id" --vault "$vault_name"  --format json

  p6_return_stream
}

######################################################################
#<
#
# Function: str user = p6_1password_cli_item_get_username(item_id, [vault_name=$OP_VAULT_NAME])
#
#  Args:
#	item_id -
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Returns:
#	str - user
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_item_get_username() {
  local item_id="$1"
  local vault_name="${2:-$OP_VAULT_NAME}"

  local user=$(p6_1password_cli item get "$item_id"  --vault "$vault_name" --field "username")

  p6_return_str "$user"
}

######################################################################
#<
#
# Function: str pw = p6_1password_cli_item_get_password(item_id, [vault_name=$OP_VAULT_NAME])
#
#  Args:
#	item_id -
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Returns:
#	str - pw
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_item_get_password() {
  local item_id="$1"
  local vault_name="${2:-$OP_VAULT_NAME}"

  local pw=$(p6_1password_cli op item get "$item_id" --vault "$vault_name" --field password --reveal)

  p6_return_str "$pw"
}

######################################################################
#<
#
# Function: str key = p6_1password_cli_item_get_api_key(item_id, [vault_name=$OP_VAULT_NAME])
#
#  Args:
#	item_id -
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Returns:
#	str - key
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_item_get_api_key() {
  local item_id="$1"
  local vault_name="${2:-$OP_VAULT_NAME}"

  local key=$(p6_1password_cli op item get "$item_id" --vault "$vault_name" --field credential --reveal)

  p6_return_str "$key"
}

######################################################################
#<
#
# Function: str code = p6_1password_cli_item_get_code(item_id, [vault_name=$OP_VAULT_NAME])
#
#  Args:
#	item_id -
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Returns:
#	str - code
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_item_get_code() {
  local item_id="$1"
  local vault_name="${2:-$OP_VAULT_NAME}"

  local code=$(p6_1password_cli item get "$item_id" --vault "$vault_name" --field notesPlain --format json | jq -r '.value')

  p6_return_str "$code"
}

######################################################################
#<
#
# Function: stream  = p6_1password_cli_item_create(title, username, password, url, [vault_name=$OP_VAULT_NAME])
#
#  Args:
#	title -
#	username -
#	password -
#	url -
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Returns:
#	stream - 
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_item_create() {
  local title="$1"
  local username="$2"
  local password="$3"
  local url="$4"
  local vault_name="${5:-$OP_VAULT_NAME}"

  p6_1password_cli item create \
    --format json \
    --category login \
    --vault "$vault_name" \
    --title "$title" \
    "username=$username" \
    "password=$password" \
    "url=$url"

  p6_return_stream
}

######################################################################
#<
#
# Function: stream  = p6_1password_cli_item_update(item_id, username, password, url, [vault_name=$OP_VAULT_NAME])
#
#  Args:
#	item_id -
#	username -
#	password -
#	url -
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Returns:
#	stream - 
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_item_update() {
  local item_id="$1"
  local username="$2"
  local password="$3"
  local url="$4"
  local vault_name="${5:-$OP_VAULT_NAME}"

  p6_1password_cli item edit "$item_id" \
    --format json \
    --vault "$vault_name" \
    "username=$username" \
    "password=$password" \
    "url=$url"

  p6_return_stream
}

######################################################################
#<
#
# Function: p6_1password_cli_item_archive(item_id, [vault_name=$OP_VAULT_NAME])
#
#  Args:
#	item_id -
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_item_archive() {
  local item_id="$1"
  local vault_name="${2:-$OP_VAULT_NAME}"

  p6_1password_cli item delete "$item_id" --vault "$vault_name" --archive --yes

  p6_return_void
}

######################################################################
#<
#
# Function: p6_1password_cli_item_delete(item_id, [vault_name=$OP_VAULT_NAME])
#
#  Args:
#	item_id -
#	OPTIONAL vault_name - [$OP_VAULT_NAME]
#
#  Environment:	 OP_VAULT_NAME
#>
######################################################################
p6_1password_cli_item_delete() {
  local item_id="$1"
  local vault_name="${2:-$OP_VAULT_NAME}"

  p6_1password_cli op item delete "$item_id" --vault "$vault_name" --yes

  p6_return_void
}
