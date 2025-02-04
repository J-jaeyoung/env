# configs
set history size unlimited

# useful shortcuts
alias cxz=context
alias bb=brva
alias dsa=disass
alias tre=thread
alias itre=info thread
alias pp=p*

# custom commands
define view_code
    gef config context.layout "legend source memory trace threads extra"
    gef config context.nb_lines_code 23
end

define view_gef
    gef config context.layout "legend regs stack code args source memory threads trace extra"
    gef config context.nb_lines_code 6
end

define view_zero
    gef config context.layout ""
end

# debugging symbol server
set debuginfod url https://debuginfod.ubuntu.com
set debuginfod enabled on
