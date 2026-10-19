#!/usr/bin/env perl
use strict;
use warnings;
use IO::Socket::INET;
use File::Basename;

$| = 1;
my $port = 8080;
my $docroot = dirname(__FILE__);

my $server = IO::Socket::INET->new(
    LocalAddr => '127.0.0.1',
    LocalPort => $port,
    Proto     => 'tcp',
    Listen    => 10,
    Reuse     => 1
) or die "Cannot create server on port $port: $!\n";

print "CineBook Server running at http://localhost:$port/\n";

my %mimes = (
    'html' => 'text/html; charset=UTF-8',
    'htm'  => 'text/html; charset=UTF-8',
    'css'  => 'text/css; charset=UTF-8',
    'js'   => 'application/javascript; charset=UTF-8',
    'json' => 'application/json',
    'png'  => 'image/png',
    'jpg'  => 'image/jpeg',
    'jpeg' => 'image/jpeg',
    'svg'  => 'image/svg+xml',
    'ico'  => 'image/x-icon',
);

while (my $client = $server->accept()) {
    my $req = <$client>;
    next unless defined $req;
    
    if ($req =~ m{^(GET|HEAD)\s+([^\s?]+)}) {
        my $path = $2;
        $path = '/index.html' if $path eq '/' or $path eq '/home' or $path eq '/cinebook' or $path eq '/cinebook/';
        
        my $filepath = "$docroot$path";
        $filepath = "$docroot/index.html" unless -f $filepath;
        
        my ($ext) = $filepath =~ /\.([^.]+)$/;
        my $ctype = $mimes{lc($ext // '')} || 'text/html; charset=UTF-8';
        
        if (open(my $fh, '<', $filepath)) {
            binmode $fh;
            my $content = do { local $/; <$fh> };
            close $fh;
            my $len = length($content);
            
            print $client "HTTP/1.1 200 OK\r\n";
            print $client "Content-Type: $ctype\r\n";
            print $client "Content-Length: $len\r\n";
            print $client "Connection: close\r\n";
            print $client "Access-Control-Allow-Origin: *\r\n\r\n";
            print $client $content;
        } else {
            print $client "HTTP/1.1 404 Not Found\r\nContent-Type: text/plain\r\nContent-Length: 9\r\nConnection: close\r\n\r\nNot Found";
        }
    }
    close $client;
}
