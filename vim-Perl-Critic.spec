Summary: vim-Perl-Critic: a perl critic plugin for vim.
Name: vim-Perl-Critic
Version: 1.8
Release: 1
License: MIT
Group: System/Maintenance
Source0: %{name}-%{version}-%{release}.tar.gz
BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
Requires: vim-common
Requires: perl
Requires: perl-Perl-Critic
BuildRequires: perl
Obsoletes: Vim-Criticism

%define perl_vendorlib %(eval "`%{__perl} -V:installvendorlib`"; echo $installvendorlib)

%description

A perl critic plugin for vim which creates marks and an awesome quickfix of
your not-so-quick to fix errors.

%prep
%setup -n %{name}

%build

%install
install -d %{buildroot}%{perl_vendorlib}/Vim/Perl
install -d %{buildroot}%{_datadir}/vim/vim70/ftplugin/
install -d %{buildroot}%{_datadir}/vim/vim70/doc/
install -m 0555 perl_crit.vim %{buildroot}%{_datadir}/vim/vim70/ftplugin/
install -m 0555 perl_crit.txt %{buildroot}%{_datadir}/vim/vim70/doc/
install -m 0555 Vim/Perl/Critic.pm %{buildroot}%{perl_vendorlib}/Vim/Perl

%post
vim -e "+helptags %{_datadir}/vim/vim70/doc" "+q"

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
/usr/share/vim/vim70/ftplugin/perl_crit.vim
/usr/share/vim/vim70/doc/perl_crit.txt
%{perl_vendorlib}/Vim/Perl/Critic.pm
%doc README.md

%changelog
* Fri May 7 2010 Matt Foster <matt.p.foster@gmail.com> - 1.8-1
- Added some docs.

* Fri May 7 2010 Matt Foster <matt.p.foster@gmail.com> - 1.7-1
- Install as an ftplugin. Don't set default if variables are set already.

* Tue May 4 2010 Matt Foster <matt.p.foster@gmail.com> - 1.6-1
- Report the lack of criticims to the user.

* Tue May 4 2010 Matt Foster <matt.p.foster@gmail.com> - 1.5-1
- Don't do anything where there are no criticisms.

* Mon Apr 26 2010 Matt Foster <matt.p.foster@gmail.com> - 1.4-2
- Package documentation.

* Fri Apr 23 2010 Matt Foster <matt.p.foster@gmail.com> - 1.4-1
- Fix bug in medium severity.

* Fri Apr 23 2010 Matt Foster <matt.p.foster@gmail.com> - 1.3-1
- Rename to Vim-Perl-Critic

* Fri Apr 23 2010 Matt Foster <matt.p.foster@gmail.com> - 1.2-1
- Allow configuration of severity.

* Fri Apr 23 2010 Matt Foster <matt.p.foster@gmail.com> - 1.1-1
- Allow configuration of some options.

* Tue Apr 20 2010 Matt Foster <matt.p.foster@gmail.com> - 1.0-1
- Initial build.
