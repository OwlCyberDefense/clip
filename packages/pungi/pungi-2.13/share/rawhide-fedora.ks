# Kickstart file for composing the "Fedora" spin of Fedora (rawhide)

# Use a part of 'iso' to define how large you want your isos.
# Only used when composing to more than one iso.
# Default is 670 (megs), CD size.
#part iso --size=4998

# Add the repos you wish to use to compose here.  At least one of them needs group data.
repo --name=rawhide --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=rawhide&arch=$basearch
repo --name=rawhide-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=rawhide-source&arch=$basearch

# Package manifest for the compose.  Uses repo group metadata to translate groups.
# (@base is added by default unless you add --nobase to %packages)
# (default groups for the configured repos are added by --default)
%packages --default
# core
tcsh
kernel*
-kernel*debug*
-kernel*-devel*
-kernel-kdump*
-syslog-ng
# Desktop Packages
@kde-desktop
echo-icon-theme
tracker
swfdec
libflashsupport
nspluginwrapper
liferea
esc
thunderbird
# apps
@authoring-and-publishing
@eclipse
joe
emacs
k3b
@system-tools
wireshark-gnome
# Devel packages
@development-libs
@development-tools
@gnome-software-development
@java-development
@kde-software-development
@web-development
@x-software-development
# Server packages
@dns-server
@ftp-server
@mail-server
@mysql
@network-server
@news-server
@server-cfg
@smb-server
@sql-server
@web-server --optional
# Virt group
@virtualization --optional
# filesystem stuff
reiserfs-utils
xfsprogs
jfsutils
# Languages
@afrikaans-support
@albanian-support
@arabic-support
@armenian-support
@assamese-support
@basque-support
@belarusian-support
@bengali-support
@bhutanese-support
@burmese-support
@bosnian-support
@brazilian-support
@breton-support
@british-support
@bulgarian-support
@catalan-support
@chinese-support
@croatian-support
@czech-support
@danish-support
@dutch-support
@esperanto-support
@estonian-support
@ethiopic-support
@faeroese-support
@filipino-support
@finnish-support
@french-support
@gaelic-support
@galician-support
@georgian-support
@german-support
@greek-support
@gujarati-support
@hebrew-support
@hindi-support
@hungarian-support
@icelandic-support
@indonesian-support
@inuktitut-support
@irish-support
@italian-support
@japanese-support
@kannada-support
@kashmiri-support
@kashubian-support
@khmer-support
@konkani-support
@korean-support
@lao-support
@latvian-support
@lithuanian-support
@low-saxon-support
@macedonian-support
@malay-support
@malayalam-support
@maori-support
@marathi-support
@mongolian-support
@nepali-support
@northern-sami-support
@northern-sotho-support
@norwegian-support
@oriya-support
@persian-support
@polish-support
@portuguese-support
@punjabi-support
@romanian-support
@russian-support
@samoan-support
@serbian-support
@sindhi-support
@sinhala-support
@slovak-support
@slovenian-support
@somali-support
@southern-ndebele-support
@southern-sotho-support
@spanish-support
@swati-support
@swedish-support
@tagalog-support
@tamil-support
@telugu-support
@thai-support
@tibetan-support
@tonga-support
@tsonga-support
@tswana-support
@turkish-support
@ukrainian-support
@urdu-support
@venda-support
@vietnamese-support
@walloon-support
@welsh-support
@xhosa-support
@zulu-support
# Size removals
-gimp-help
-java-1.6.0-openjdk-src
-xorg-x11-docs
-kernel-doc
-java-1.5.0-gcj-src
-java-1.5.0-gcj-devel
-libgcj-src
-*javadoc*
%end
