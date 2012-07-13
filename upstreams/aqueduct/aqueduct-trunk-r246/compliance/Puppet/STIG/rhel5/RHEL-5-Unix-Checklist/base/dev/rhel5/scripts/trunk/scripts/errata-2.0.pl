#!/usr/bin/perl

use strict;
use warnings;

use English;

use HTTP::Cookies;
use LWP::UserAgent;
use Frontier::Client;
use Getopt::Long;
use Data::Dumper;
use Date::Manip;
use File::Temp qw/tempdir/;
use File::Spec;
use File::stat;
use Digest::MD5 qw/md5_hex/;

my $host = 'rhn.redhat.com';
my $user;
my $password;
my $channel_label;
my $directory;
my $download = 1;
my $timestamp = 0;
my $since = '1970-01-01';
my $limit = 3;
my $max_errors = 0;
my $help = 0;
my $rhnlogin = 'https://www.redhat.com/wapps/sso/login.html';

my $help_message = "Usage: $PROGRAM_NAME --user=<user> --password=<password> --channel=<channel_label> [ --directory=<target_directory> ] [ --host=<hostname> ] [ --limit=<max_packages> ] [ --max-errors=<max_errors> ] [ --since=<YYYY-MM-DD> ] [ --nodownload ] [ --timestamp ]\n";
my $no_user_message = "I need a username and password.\n\n" . $help_message;

my $result = GetOptions ("host=s"       => \$host,
			 "user=s"       => \$user,
			 "password=s"   => \$password,
			 "channel=s"    => \$channel_label,
			 "directory=s"  => \$directory,
			 "download!"    => \$download,
			 "timestamp"    => \$timestamp,
			 "since=s"      => \$since,
			 "limit=i"      => \$limit,
			 "max-errors=i" => \$max_errors,
                         "help"         => \$help);

die $help_message if $help;

my $errors = 0;

die "No host!\n\n" . $help_message unless $host;

my $client = new Frontier::Client(url => "https://$host/rpc/api");

my $apiver = $client->call('api.system_version');
print "$host is running API version $apiver.\n\n";

if (! $user) {
  print "User login to check? ";
  chomp($user = <STDIN>);
}

die $no_user_message unless $user;

if (! $password) {
  print "Password? ";
  system "stty -echo";
  chomp($password = <STDIN>);
  system "stty echo";
  print "\n\n";
}

die $no_user_message unless $password;
my $session;

eval {
  $session = $client->call('auth.login', $user, $password);
};

if ($EVAL_ERROR or ! $session) {
  die "Unable to login.\n\n" . $help_message;
}

print "Logged in via API.\n\n";

if (! $channel_label) {
  print "Listing all channels...\n";
  my $channels = $client->call('channel.listSoftwareChannels', $session);

  foreach my $channel (@$channels) {
    printf("%s\n", $channel->{channel_label});
  }

  print "Consult the above output for the Channel *label* to list all packages from [e.g. rhel-i386-server-5 , rhel-i386-as-4-extras] ? ";
  chomp($channel_label = <STDIN>);
}

die "No channel label given.\n\n" . $help_message unless $channel_label;

print "Fetching latest package information for channel $channel_label...\n\n";

my $packages = $client->call('channel.software.listLatestPackages', $session, $channel_label);

print "Found " . scalar @{$packages} . " packages (limit is set to $limit).\n\n";

my %pkg_info;
my $package_count = 0;

$OUTPUT_AUTOFLUSH = 1;

my $since_secs = UnixDate(ParseDate($since), "%s");

if ($download and ($timestamp or $since_secs > -7200)) {
  print "Fetching details for $limit packages:\t";
  foreach my $package (@{$packages}) {
    $package_count++;
    if ($limit and $package_count > $limit) {
      last;
    }
    print $package_count . "\r\t\t\t\t\t";
    $pkg_info{$package->{package_id}} = $client->call('packages.getDetails', $session, $package->{package_id})->{package_last_modified_date};
  }
  print "\n\n";
}

print "Logging in via WWW...\n\n";

my $jar = new HTTP::Cookies;
my $ua = new LWP::UserAgent;
$ua->cookie_jar($jar);

# Ignore cookie warnings
local $SIG{__WARN__} = sub {
  warn @_ unless $_[0] =~ m(^.* too (?:big|small));
};

my $request = HTTP::Request->new(GET => $rhnlogin);
my $response = $ua->request($request);
$response = $ua->post($rhnlogin,
  [
   'username' => $user,
   'password' => $password,
   '_flowId'  => "legacy-login-flow"
 ]
);

if (not $directory) {
  $directory = setup_temp_dir();
}

if ($download) {
  print "Downloading to $directory.\n\n";
  chdir($directory) or die "Could not go to: $directory";
} else {
  print "Available packages on channel ${channel_label}:\n\n";
}

my $download_count = 0;
my $download_filename;
$package_count = -1;

foreach my $package (@{$packages}) {
  $package_count++;
  if ($limit and $package_count >= $limit) {
    last;
  }

  # Skip older packages than asked if downloading
  my $pkg_secs;
  if ($since_secs > -7200) {
    $pkg_secs = UnixDate(ParseDate($pkg_info{$package->{package_id}}), "%s");
    if ($download and (not $pkg_secs or $since_secs > $pkg_secs)) {
      print "Skipping $package->{package_name} (older than $since).\n";
      next;
    }
  }

  my $path = '/rhn/software/packages/details/Overview.do?pid=' . $package->{package_id};
  $response = $ua->get("https://" . $host . $path);

  if ($response->is_error()) {
    print "Could not get https://${host}${path}\n";
    print "Error: " . $response->status_line . "\n";
    if (++$errors > $max_errors) {
      die "Exiting on error $errors.\n";
    }
    next;
  }

  my $download_url;
  my $md5_sum;

  #if ($response->as_string =~ m|"(https://rhn.redhat.com/download/[^"]*)">Download Package|) {
  #if ($response->as_string =~ m|"(https://[\w\.-]*redhat.com/download/[^"]*)">Download Package|) {
  #if ($response->as_string =~ m|"(https://[\w\.-]*redhat.com/rhn/public/NULL/[^"]*)">Download Package|) {
  if ($response->as_string =~ m|"(https://[\w\.-]*redhat.com/rhn/.*/[^"]*)">Download Package|) {
    $download_url = $1;
    $download_url =~ m|.*/(.*)$|;
    $download_filename = $1;
    $download_filename =~ s/\?.*$//;

    # We could also get the md5sum from a getDetails API call, but we
    # already have the data on the page, so...
    if ($response->as_string =~ m|MD5 Sum:.*<td><tt>(\w+)</tt>|s) {
      $md5_sum = $1;
    }
  }
  else {
    warn "Could not find download link at https://${host}${path}\n";

    if (++$errors > $max_errors) {
      die "Exiting on error $errors.\n";
    }
    next;
  }

  if ($download) {
    print "Downloading ${download_filename}... ";

    if (-e $download_filename and $md5_sum) {
      open FH, $download_filename or die "Could not open $download_filename for reading: $OS_ERROR";
      binmode(FH);

      my $existing_rpm;
      my $buffer;
      while (read FH, $buffer, 8*2**10) {
	$existing_rpm .= $buffer;
      }
      close FH;

      if (md5_hex($existing_rpm) eq $md5_sum) {
	print "already exists.  Skipping.\n";

        if ($timestamp) {
          utime $pkg_secs, $pkg_secs, $download_filename;
        }

	next;
      }
    }

    $response = $ua->get($download_url);

    if ($response->is_error()) {
      print "\n  Could not get ${download_url}\n";
      print "  Error: " . $response->status_line . "\n";
      if (++$errors > $max_errors) {
	die "Exiting on error $errors.\n";
      }

      next;
    }

    open FH, "> $download_filename" or die ($OS_ERROR);
    print FH $response->content;
    close FH;
    $download_count++;

    if ($timestamp) {
      utime $pkg_secs, $pkg_secs, $download_filename;
    }

    print "done.\n";
  }
  else {
    print "Package: " . ${download_filename} . "\n";
    print " MD5Sum: " . $md5_sum . "\n";
    print "    URL: " . $download_url . "\n\n";
  }
}

$OUTPUT_AUTOFLUSH = 0;

if (($limit and $package_count == $limit) or $package_count == @{$packages}) {
  print "\nProcessed $package_count packages, $download_count downloaded.\n";
  if ($download_count) {
    print "\nDownloaded packages are available in $directory.\n";
  }
}
else {
  print "\nProcessed $package_count of " . scalar($limit or @{$packages}) . " packages, $download_count downloaded.\n";
  if ($download_count) {
    print "\nDownloaded packages are available in $directory.\n";
  }
}

sub setup_temp_dir {
  my $dir = tempdir(CLEANUP => 0);
  my ($volume,$directories,$file) = File::Spec->splitpath($dir, 1);
  my $target = File::Spec->catdir($directories, "repo");

  $dir = File::Spec->catpath($volume, $target, '');
  mkdir $dir;

  return $dir;
}