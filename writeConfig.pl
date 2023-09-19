#!/usr/bin/perl

$j = "Content-type: application/json";
$url = "https://okapi-drew.folio.ebsco.com";

$result = `curl -i -s -X POST -H '$j' -H 'X-Okapi-Tenant: [tenantId]' -d '{"username": "[username]", "password": "[password]"}' $url/authn/login`;
@parts = split(/\n/,$result);
foreach $part (@parts) {
        if ($part =~ /^x-okapi-token:/) {
                $x = "X-Okapi-Token: " . substr($part,15);
                $x =~ s/^M//g; $note2self = "*** that looks like ^M but it is not - it is Ctrl-V Ctrl-M ***";
        }
}

open(w,">/opt/folio/config.pl");
print w qq[
\$url = "$url";
\$headers = "-H '$j' -H '$x'";
];
close(w);
