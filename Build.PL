use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'Test::JSON',
    license           => 'perl',
    dist_author       => 'Curtis "Ovid" Poe <ovid@cpan.org>',
    dist_version_from => 'lib/Test/JSON.pm',
    requires          => {
        'JSON'              => 1.00,
        'Test::Differences' => 0.47,
        'Test::Simple'      => 0.62,
        'Test::Tester'      => 0.103,
    },
    add_to_cleanup     => ['Test-JSON-*'],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
