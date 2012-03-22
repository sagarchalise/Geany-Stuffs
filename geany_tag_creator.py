#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-
#
#       geany_tag_creator.py
#       Copyright 2011 Sagar Chalise <chalisesagar@gmail.com>
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.
#       
#       

import sys
import os


file_types = ['py', 'php', 'js']


def main(arg):
    filetype = arg[2]
    directory = arg[1]
    name = str.lower(os.path.basename(directory))
    if os.path.isdir(directory):
        for k in file_types:
            if filetype == k:
                cmd = 'geany -g %s.%s.tags $(find %s -name \*.%s)' \
                        % (name, k, directory, k)
        os.chdir(os.path.expanduser('~/.config/geany/tags'))
        os.system(cmd)
    else:
        print 'No Such path'
        sys.exit()


if __name__ == '__main__':
    try:
        main(sys.argv)
    except (TypeError, IndexError):
        print 'Usage: geany_tag_creator.py <tag_folder_path_without_trailing_slash> <filetype>'
