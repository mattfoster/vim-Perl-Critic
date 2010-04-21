Summary: Vim-Criticism: a perl critic plugin for vim.
Name: Vim-Criticism
Version: 1.0
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

%define perl_vendorlib %(eval "`%{__perl} -V:installvendorlib`"; echo $installvendorlib)

%description

A perl critic plugin for vim which creates marks and an awesome quickfix of
your not-so-quick to fix errors.

%prep
%setup -n %{name}

%build

%install
install -d %{buildroot}%{perl_vendorlib}/Vim/
install -d %{buildroot}/usr/share/vim/vim70/plugin/
install -m 0555 crit.vim %{buildroot}/usr/share/vim/vim70/plugin/
install -m 0555 Vim/Criticism.pm %{buildroot}%{perl_vendorlib}/Vim

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
/usr/share/vim/vim70/plugin/crit.vim
%{perl_vendorlib}/Vim/Criticism.pm

%changelog
* Tue Apr 20 2010 Matt Foster <mpf@netcraft.com> - 1.0-1
- Initial build.
