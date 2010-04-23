Summary: vim-Perl-Critic: a perl critic plugin for vim.
Name: vim-Perl-Critic
Version: 1.4
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
install -d %{buildroot}/usr/share/vim/vim70/plugin/
install -m 0555 crit.vim %{buildroot}/usr/share/vim/vim70/plugin/
install -m 0555 Vim/Perl/Critic.pm %{buildroot}%{perl_vendorlib}/Vim/Perl

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
/usr/share/vim/vim70/plugin/crit.vim
%{perl_vendorlib}/Vim/Perl/Critic.pm

%changelog
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
