#!/bin/sh

# here="/path/to/mplab_ipe": Please change it according to your env.
here="/opt/microchip/mplabx/v*/mplab_platform/mplab_ipe"
jdkhome="${here}/../../sys/java/jre*/"
export mplabx_dir="${here}/.."
export netbeans_dir="${mplabx_dir}"
export jvm="${jdkhome}/bin/java"
ipecmd_jar="${mplabx_dir}/mplab_ipe/ipecmd.jar"
$jvm -jar ${ipecmd_jar} $@
