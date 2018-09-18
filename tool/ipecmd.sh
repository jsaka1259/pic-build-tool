#!/bin/sh
# here="/path/to/mplab_ipe": Please change it according to your env.
export here=/opt/microchip/mplabx/v5.05/mplab_platform/mplab_ipe
export mplabx_dir=$here/..
export netbeans_dir=$mplabx_dir
export ipecmd_jar=$mplabx_dir/mplab_ipe/ipecmd.jar
jdkhome=$here/../../sys/java/jre1.8.0_144/
export jvm=$jdkhome/bin/java
$jvm -jar $ipecmd_jar $@
