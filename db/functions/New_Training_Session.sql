CREATE OR REPLACE FUNCTION New_Training_Session(Datestamp timestamptz) RETURNS INTEGER AS $BODY$
INSERT INTO TrainingSessions (Datestamp) VALUES ($1) RETURNING TrainingSessionID;
$BODY$ LANGUAGE sql VOLATILE;

CREATE OR REPLACE FUNCTION New_Training_Session(Datestamp timestamptz, Program text) RETURNS INTEGER AS $FOO$
# You always write this in the top of the program, it enables strict mode and warnings mode:
use strict;
# use warnings;

my ($datestamp, $program) = @_;
# Variant B:
# my ($datestamp, $program) = ($_[0], $_[1]);
# Variant C:
# my $datestamp = $_[0];
# my $program   = $_[1];
# Variant D:
# my $datestamp = shift;
# my $program   = shift;

my $New_Training_Session = spi_prepare('SELECT New_Training_Session($1)', "TIMESTAMPTZ");
my $New_Training_Event   = spi_prepare('SELECT New_Training_Event($1,$2,$3)', "INTEGER", "INTERVAL", "INTEGER");

my $translate_rest = sub {
    my $walking_speed = 1.2;
    my ($rest_value, $rest_distance, $rest_duration) = @_;
    if (defined $rest_distance) {
        if ($rest_distance eq 'km') {
            $rest_value *= 1000;
        }
        return ($rest_value, ($rest_value / $walking_speed) . ' seconds');
    } elsif (defined $rest_duration) {
        my $rest_duration_unit_in_seconds;
        if ($rest_duration =~ m/^('|min)$/) {
            elog(DEBUG, "$rest_duration=minutes");
            $rest_duration_unit_in_seconds = 60;
        } elsif ($rest_duration =~ m/^(''|"|s|sec)$/) {
            elog(DEBUG, "$rest_duration=seconds");
            $rest_duration_unit_in_seconds = 1;
        } else {
            die "unknown format of rest_duration: $rest_duration";
        }
        return (0, ($rest_value * $rest_duration_unit_in_seconds) . ' seconds');
    } else {
        die "both rest_distance and rest_duration undefined";
    }
};

# Regular expressions (regex)
if ($program =~ m!
    ^                                 # beginning of string
    (                                 # $1: distances (beginning)
        \d+                           # a number
        \s*                           # white-space
        (?:                           # (?: .... ) means we encapsulate something without mapping it to a variable
            [,+]                      # , or +
            \s*                       #
            \d+                       # at least one digit
            \s*                       #
            (?:m|km)?                 # ? means must match 0 or 1 time
            \s*                       # eventual white-space
        )*                            # ^--- match as many as we can, or none if there is only one number
    )                                 # $1: distances (end)
    \s*/\s*                           # white-space / white-space
    (?:                               #
        (\d+)                         # $2: rest value
        \s*
        (?:
            (m|km)                    # $3: if set, $2 is rest distance
            \s*
            gång
        |
            ('|''|"|s|sec|min)        # $4: if set, $2 is rest duration
        )
    )
    $                                 # end of string
!x) {
    my ($distances, $rest_value, $rest_distance, $rest_duration) = ($1, $2, $3, $4);
    ($rest_distance, $rest_duration) = &$translate_rest($rest_value, $rest_distance, $rest_duration);
    elog(DEBUG, "The string '$program' matched! distances=$distances, rest_value=$rest_value, rest_distance=$rest_distance, rest_duration=$rest_duration");
    for my $distance (split /[,+]/, $distances) {
        while ($distance =~ s/\s+//g) {}
        elog(DEBUG, "    distance=$distance");
    }

} else {
    elog(DEBUG, "The string '$program' did not match! :-(");
}
return 1;
$FOO$ LANGUAGE plperlu VOLATILE SECURITY DEFINER;
