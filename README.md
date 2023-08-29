### tcl1 - A frontend for one-liner tcl scripts, as an alternative for AWK.

# Dependencies

- tcl 8.6+
- tcllib (cmdline)

## Options

- **-n** - loop over input lines, variable ```$_``` contains current line

- **-p** - loop over input lines and print result of last expression, variable ```$_``` contains current line

- **-I** - do not read from the file ```~/.tcl1```

## Examples

Add the folowing string to the file ```~/.tcl1```:

```tcl
interp alist {} str {} string
```

This allows to cut commands from "```string```" to "```str```".

Check, how ```tcl1``` works:
```tcl
tcl1 'puts {Tcl1 works!}'
```

Iterate over input and print each line if it is a direcory name inside ```/```:

```bash
ls -1 / | tcl1 -n 'if {[file isdir /$_]} {puts "< $_ >"}' 
```

Iterate over input and print each modified line:
```bash
ls -1 / | tcl1 -p 'str totitle $_'
```

