#!/bin/sh

# Shell script to install the necessary packages to get LaTeX working with the
# Tufte-LaTeX package on Fedora. (Tested on F15.)

echo "This may take some time..."

[ -d install ] || mkdir install
cd install

install_pkg=install-tl-unx.tar.gz
[ -e $install_pkg ] || wget http://mirror.ctan.org/systems/texlive/tlnet/$install_pkg

profile=profile
if [ ! -e $profile ]; then
    cat >$profile <<EOF
TEXDIR /usr/local/texlive/2011
TEXMFCONFIG ~/.texlive2011/texmf-config
TEXMFHOME ~/texmf
TEXMFLOCAL /usr/local/texlive/texmf-local
TEXMFSYSCONFIG /usr/local/texlive/2011/texmf-config
TEXMFSYSVAR /usr/local/texlive/2011/texmf-var
TEXMFVAR ~/.texlive2011/texmf-var
binary_x86_64-linux 1
collection-basic 1
collection-fontsrecommended 1
collection-genericrecommended 1
collection-latex 1
collection-latexrecommended 1
in_place 0
option_autobackup 1
option_backupdir tlpkg/backups
option_desktop_integration 1
option_doc 1
option_file_assocs 1
option_fmt 1
option_letter 0
option_path 1
option_post_code 1
option_src 1
option_sys_bin /usr/local/bin
option_sys_info /usr/local/info
option_sys_man /usr/local/man
option_w32_multi_user 0
option_write18_restricted 1
portable 0
EOF

    directory=`tar -tzf $install_pkg | head -n 1`
    [ -d $directory ] || tar -xzf $install_pkg
    sudo $directory/install-tl -profile $profile
fi

sudo /usr/local/bin/tlmgr install tufte-latex titlesec soul

