#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.

#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro                                   #
#Vincent[.]Passaro[@]gmail[.]com                                     #
#www.vincentpassaro.com                                              #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 06-dec-2011|
#|          |   Creation            |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################

#SN.10 Remove All Compilers and Assemblers
#C compilers, and others, pose a credible high-risk threat 
#to production systems and should not be installed. 
#Compilers should be installed on select development 
#systems – those systems that have a legitimate business
#need for a compiler – and the resulting output binaries 
#deployed onto other development and production 
#systems using the existing Enterprise change processes.

rpm -e gcc 
rpm -e gcc3 
rpm -e gcc3-c++ 
rpm -e gcc3-g77 
rpm -e gcc3-java 
rpm -e gcc3-objc 
rpm -e gcc-c++ 
rpm -e gcc-chill 
rpm -e gcc-g77
rpm -e gcc-java 
rpm -e gcc-objc 
rpm -e bin86 
rpm -e dev86 
rpm -e nasm 
rpm -e as