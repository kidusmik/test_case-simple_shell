#!/bin/bash
#
# Performing checks on the Holberton School "simple shell" project

#######################################
# Print KO, in red, followed by a new line
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
#######################################
function print_ko()
{
    echo -e "[\033[31mKO\033[37m]"
}

#######################################
# Print OK in green, followed by a new line
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
#######################################
function print_ok()
{
    echo -e "[\033[32mOK\033[37m]"
}

#######################################
# Kill the shell in a clean way and remove temporary files
# Globals:
#   SHELL
#   OUTPUTFILE
#   ERROROUTPUTFILE
#   LTRACEOUTPUTFILE
# Arguments:
#   None
# Returns:
#   None
#######################################
function stop_shell()
{
    if [ `pidof $SHELL | wc -l` -ne 0 ]; then
	   killall -9 $SHELL 2>&1 > /dev/null
    fi
    rm -f $OUTSS $OUTSYS $OUTERRSS $OUTERRSYS $OUTLTRACE
}

# Load configuration
source config

# Cleanup
echo -ne "\033[37m"
rm -f $OUTSYS $OUTSS $OUTERRSS $OUTERRSYS $OUTLTRACE

# Locates all tests and launch them
for dir in `ls -d "$TESTDIR"/*/`
do
    echo "> $dir"
    for testname in `ls "$dir" | grep -v "~$"`
    do
	   echo -n "   # $testname: "
	   source "$dir$testname"
    done
done

# Cleanup
rm -f $OUTSYS $OUTSS $OUTERRSYS $OUTERRSS $OUTLTRACE
rm -f /tmp/checker_sys_*
rm -f /tmp/checker_ss_*
rm -f /tmp/checker_ltrace_*
echo -ne "\033[37m"
