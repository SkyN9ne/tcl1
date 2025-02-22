#!usr/bin/env/sh
# \
exec tclsh8.6 "$0" ${1+"$@"}


package require cmdline

set rcFile ~/.tcl1

set options [list \
                 {n "loop over input lines"} \
                 {p "loop over input lines and print result of last expression"} \
                 [list I "do not read file $rcFile"] \
            ]

set usage ": $argv0 \[options] 'code' ?files?\noptions:"



try {
    array set params [cmdline::getoptions argv $options $usage]
} trap {CMDLINE USAGE} {msg o} {
    puts $msg
    exit 1
}

if {[llength $argv] < 1} {
    chan puts [cmdline::usage $options $usage]
    exit 1
} else {
    if {$params(I) == 0 && [file exists $rcFile]} {
        source $rcFile
    }

    set code [lindex $argv 0]
    set files [lrange $argv 1 end]

    if {$params(p) || $params(n)} {
        if {[llength $files] == 0} {
            while 1 {
                set _ [chan get stdin]
                if {[chan eof stdin]} {
                    break
                } else {
                    if {$params(p)} {
                        puts [uplevel #0 $code]
                    } else {
                        uplevel #0 $code
                    }
                }
            }
        } else {
            package require fileutil
            foreach file $files {
                fileutil::foreachLine _ $file {
                    if {$params(p)} {
                        puts [uplevel #0 $code]
                    } else {
                        uplevel #0 $code
                    }
                }
            }
        }
    } else {
        set argv $files
        uplevel #0 $code
    }
}


# Local Variables:
# mode: tcl
# End:
