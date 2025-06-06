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


python
import gdb

class BTFileLineFunc(gdb.Command):
    """Backtrace showing frame#, source file:line and function name, highlighting selected frame."""
    def __init__(self):
        super(BTFileLineFunc, self).__init__("btt", gdb.COMMAND_STACK)

    def invoke(self, arg, from_tty):
        try:
            sel_level = gdb.selected_frame().level()
        except Exception:
            sel_level = None

        frame = gdb.newest_frame()
        idx = 0
        while frame:
            sal = frame.find_sal()
            if sal.symtab:
                filename = sal.symtab.filename
                line = sal.line
            else:
                filename = "??"
                line = "?"
            func = frame.name() or "??"

            if idx == sel_level:
                gdb.write(f"[=>#{idx:<2}] {filename}:{line}, <{func}>\n")
            else:
                gdb.write(f"[  #{idx:<2}] {filename}:{line}, <{func}>\n")

            frame = frame.older()
            idx += 1

BTFileLineFunc()
end
