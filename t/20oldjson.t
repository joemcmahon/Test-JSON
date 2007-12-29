#!perl 

use Test::Tester;
use Test::More tests => 38;
use lib 't/lib';
BEGIN {
    
    # make sure we use the correct JSON version!
    use_ok 'JSON';
    cmp_ok +JSON->VERSION, '<', 1.99,
      '... and we should be loading the old JSON version';
}
use Test::JSON;

my $json = '{"bool":1,"name":"foo","id":1,"description":null}';
my $good = '{"bool":1,"name":"foo","id":1,"description":null}';

my $desc = 'identical JSON should match';
check_test(
    sub { is_json $json, $good, $desc },
    {
        ok   => 1,
        name => $desc,
    },
    $desc
);

$good = '{"bool":1,"id":1,"name":"foo","description":null}';

$desc = 'attribute order should not matter';
check_test(
    sub { is_json $json, $good, $desc },
    {
        ok   => 1,
        name => $desc,
    },
    $desc
);

# "null" is misspelled
my $invalid = '{"bool":1,"name":"fo","id":1,"description":nul}';
$desc = 'Invalid json should fail';
check_test(
    sub { is_json $json, $invalid, $desc },
    {
        ok   => 0,
        name => $desc,
    },
    $desc
);

# "fo" should be "foo"
my $not_the_same = '{"bool":1,"name":"fo","id":1,"description":null}';
$desc = 'Different JSON should fail';
check_test(
    sub { is_json $json, $not_the_same, $desc },
    {
        ok   => 0,
        name => $desc,
    },
    $desc
);

$json = '{"bool":1,"name":"fo","id":1,"description":null}';
$desc = 'Valid JSON should succeed';
check_test(
    sub { is_valid_json $json, $desc },
    {
        ok   => 1,
        name => $desc,
    },
    $desc
);

$invalid = '{"bool":1,"name":"fo","id":1,"description":nul}';
$desc = 'Invalid JSON should fail';
check_test(
    sub { is_valid_json $invalid, $desc },
    {
        ok   => 0,
        name => $desc,
    },
    $desc
);
