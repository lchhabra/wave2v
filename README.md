# wave2v - An ascii waveform to verilog stimuli converter

`wave2v` is a perl script enables quick creation of
testbenches for simple to complex verilog modules. Stimuli
can be provided via `$WAVES` blocks, which contain _ascii
wave_ definitions. An example of a $WAVES block defining a
waveform called `wave1` is:

```
$WAVES(wave1)
  clk      _/-\_/-\_/-\_/-\_/-\_/-\
  rst_n    ____/-
  sig      ___________/---\_
$END_WAVES
```

Waves can _overlap_ (i.e. applied over another), or _sequenced_ (i.e.
applied after another), allowing creation of complex stimuli.

## Usage

```shell
$ wave2v _cmd_file_ > _testbench_file.v_
```
wave2v translates a command file into verilog. We start with
the components of a simple command file, roughly in the
order they are processed.

As in perl, all characters after a `#` are considered comments.

## The command file

The command file is made up of _blocks_ that start with
`$BLOCK_NAME` and end with `$END_BLOCKNAME`. Blocks can
be specified in any order; they are executed in a
pre-defined order by `wave2v`.

### Preamble

The first part is a preamble.

```
$PREAMBLE
  `timescale 1ps/1ps
  `include "my_defines.vh"
  module tb();
$END_PREAMBLE

```

Code in the preamble is output first.

### Params

```
$PARAMS
  unittime    1000
  N           4
  DATAW       128
$END_PARAMS
```

The `$PARAMS` block contains system and user
parameters. There is currently just one system parameter
used by `wave2v`:

* `unittime`: The time value associated with each waveform
  character.

Other parameters are converted to verilog parameter
assignments. For example `N` and `DATAW` are output as:

```
parameter N = 4;
parameter DATAW = 128;
```

### Inputs

The inputs block contains all the signals that `wave2v` will
drive. All signals in the `$WAVES` blocks need to be
declared here before they are used.

```
$INPUTS
  clk
  rst_n
  mysig
  mybus1 [DATAW-1:0]
  mybus2 [3:0]
$END_INPUTS
```

Signals can be single wires or busses. Parameters defined in
`$PARAMS` can be used to specify bus widths. In this example
`mysig` is a single wire, `mybus1` is a bus of width
`DATAW` (which is defined to be 128) and `mybus2` is a bus
of width 4.

### Midamble

This block is output verbatim after the parameters and input
declarations. It usually contains an instantiation of the
DUT, and can contain any other testbench code (custom
modules, bfms, etc).

```
$MIDAMBLE

  wire myout [DATAW-1:0];

   my_dut my_dut_inst #(.DATAW(DATAW), .N(N))
         (.clk, .rst_n, .sig (mysig),
	  .bus1(mybus1), .bus2 (mybus2),
	  .out(myout[DATAW-1:0]));

  initial begin
    $timeformat(-9, 0, "", 10);
    $vcdplusfile("verilog.vpd");
    $vcdpluson;
    $vcdplusmemon();
  end
  // Can contain any arbitrary verilog code

$END_MIDAMBLE

```

### Postamble

This is output at the end.

```
$POSTAMBLE
  endmodule
$END_POSTAMBLE
```

### Waves

This is where things get interesting. `$WAVES` defines
ascii waves on a set of inputs. These waves can be
combined in `$STIMULUS` blocks below (more on that
later). Here are a few examples of waves that are supported
by wave2v.

```
$WAVES(rst)
  clk           _/-\_/-\_/-\_/-\_/-\
  rst_n         ___________/-
$END_WAVES
```

This defines a waveform called `rst`. Single wire signals
transition on `\` and `/` edges, are driven low on `_`, and
are driven high on `-`. Each character occupies `unittime`
time. (`unittime` is defined in `$PARAMS`).

Each `$WAVES` block internally contains stimuli for all
inputs. Inputs not specified are implicitly driven to 0.

```
$WAVES(clk)
  $REPEAT(1000)
  clk           _/-\_/-\
$END_WAVES
```

The `$REPEAT` modifier provides a convenient way of
repeating the waveform. In the above example, the wave is
repeated 1000 times, resulting in 2000 positive clock edges.


```
$WAVES(stim1)
  clk           _/-\_/-\_/-\_/-\_/-\
  mysig         _______/---\_  
  mybus2        [0....]x[3]x[f]
$END_WAVES
```

The above waveform describes how to drive busses. Bus values
transition on an `x`. Bus values are required to be
specified in hexadecimal. The `.` character can be used to
fill in space to align the transition times.


```
$WAVES(req)
  $ALIAS(p=1934_3ddf_8dfe_ffab_0000_0000_aa55_ffaa)
  $ALIAS(q=random)
  clk           _/-\_/-\_/-\_/-\_/-\
  mybus1        [0....]x[p]x[q]x[0]
$END_WAVES
```

For larger busses, it may be convenient to specify value
_aliases_. In the above example, `p` is an alias to the
hexadecimal number
`1934_3ddf_8dfe_ffab_0000_0000_aa55_ffaa`. The `_` is
provided for convenience and is filtered out by the script.

Aliases can also be used to provide random values. In the
above example, `q` is assigned to a randomly generated
value. The width of the random value is dependent on the
signal it is being applied to. In the above example, it is
applied to `mybus1` which is `DATAW` wide (which is
128), so `q` is a 128 bit random number.

### Stimulus

The `$STIMULUS` block combines waves to create the actual
stimuli. The stimulus block consists of one or more $INIT
lines. A few examples:


```
$STIMULUS
  $INIT(rst,clk,req,clk)
$END_STIMULUS
```

Apply `rst` followed by `clk` followed by `req` followed by
`clk`.

```
$STIMULUS
  $INIT(rst,clk,req|stim1,clk)
$END_STIMULUS
```

Apply `rst` followed by `clk` followed by (`req` and `stim1`
simultaneously) followed by `clk`.

The `|` character effectively 'or's two or more wave
blocks. This means that each signal in a wave block is
bitwise or-ed with its counterpart in other blocks. Inputs
that are unspecified in a wave block are driven to 0 so this
usually does what the user intends.

Similar to `|`, the `&` character effectively 'and's
corresponds signals in two or more wave blocks.

Thats all folks!

## TODO
* Syntax checking and more meaningful error messages.

## LICENSE
Copyright (c) 2001-2015 Lalit Chhabra. All rights reserved.
This program is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.  IN NO
EVENT SHALL THE AUTHOR OR DISTRIBUTORS BE LIABLE TO ANY
PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OF THIS
SOFTWARE, ITS DOCUMENTATION, OR ANY DERIVATIVES THEREOF,
EVEN IF THE AUTHOR HAVE BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.

THE AUTHOR AND DISTRIBUTORS SPECIFICALLY DISCLAIM ANY
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, AND NON-INFRINGEMENT. THIS SOFTWARE IS PROVIDED ON
AN "AS IS" BASIS, AND THE AUTHOR AND DISTRIBUTORS HAVE NO
OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES,
ENHANCEMENTS, OR MODIFICATIONS.
