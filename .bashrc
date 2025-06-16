# Expand environment variables
shopt -u progcomp

# vscode 
socket=$(ls -1t /run/user/$UID/vscode-ipc-*.sock 2> /dev/null | head -1)
export VSCODE_IPC_HOOK_CLI=${socket}
export DISPLAY=:10.0
