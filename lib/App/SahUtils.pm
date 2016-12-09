package App::SahUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{get_sah_type} = {
    v => 1.1,
    summary => 'Extract type from a Sah string or array schema',
    description => <<'_',

Uses <pm:Data::Sah::Util::Type>'s `get_type()` to extract the type name part of
the schema.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub get_sah_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    [200, "OK", Data::Sah::Util::Type::get_type($args{schema})];
}

$SPEC{is_sah_builtin_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a Sah builtin type',
    description => <<'_',

Uses <pm:Data::Sah::Util::Type>'s `is_type()` to return the type of the schema
is the type is known builtin type, or undef if type is unknown.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_builtin_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    [200, "OK", Data::Sah::Util::Type::is_type($args{schema})];
}

$SPEC{is_sah_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a Sah type',
    description => <<'_',

The difference from this and `is_sah_builtin_type` is: if type is not a known
builtin type, this routine will try to resolve the schema using
<pm:Data::Sah::Resolve> then try again.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    my $res;
    unless ($res = Data::Sah::Util::Type::is_type($args{schema})) {
        require Data::Sah::Resolve;
        eval { $res = Data::Sah::Resolve::resolve_schema($args{schema}) };
        unless ($@) {
            $res = Data::Sah::Util::Type::is_type($res);
        }
    }

    [200, "OK", $res];
}

$SPEC{is_sah_simple_builtin_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a Sah simple builtin type',
    description => <<'_',

Uses <pm:Data::Sah::Util::Type>'s `is_simple()` to check whether the schema is a
simple Sah builtin type.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_simple_builtin_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    [200, "OK", Data::Sah::Util::Type::is_simple($args{schema})];
}

$SPEC{is_sah_simple_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a simple Sah type',
    description => <<'_',

The difference from this and `is_sah_simple_builtin_type` is: if type is not a
known builtin type, this routine will try to resolve the schema using
<pm:Data::Sah::Resolve> then try again.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_simple_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    my $res;
    if (Data::Sah::Util::Type::is_type($args{schema})) {
        $res = Data::Sah::Util::Type::is_simple($args{schema});
    } else {
        require Data::Sah::Resolve;
        eval { $res = Data::Sah::Resolve::resolve_schema($args{schema}) };
        unless ($@) {
            $res = Data::Sah::Util::Type::is_simple($res);
        }
    }

    [200, "OK", $res];
}

$SPEC{is_sah_collection_builtin_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a Sah collection builtin type',
    description => <<'_',

Uses <pm:Data::Sah::Util::Type>'s `is_collection()` to check whether the schema
is a collection Sah builtin type.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_collection_builtin_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    [200, "OK", Data::Sah::Util::Type::is_collection($args{schema})];
}

$SPEC{is_sah_collection_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a collection Sah type',
    description => <<'_',

The difference from this and `is_sah_collection_builtin_type` is: if type is not
a known builtin type, this routine will try to resolve the schema using
<pm:Data::Sah::Resolve> then try again.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_collection_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    my $res;
    if (Data::Sah::Util::Type::is_type($args{schema})) {
        $res = Data::Sah::Util::Type::is_collection($args{schema});
    } else {
        require Data::Sah::Resolve;
        eval { $res = Data::Sah::Resolve::resolve_schema($args{schema}) };
        unless ($@) {
            $res = Data::Sah::Util::Type::is_collection($res);
        }
    }

    [200, "OK", $res];
}

$SPEC{is_sah_ref_builtin_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a Sah ref builtin type',
    description => <<'_',

Uses <pm:Data::Sah::Util::Type>'s `is_ref()` to check whether the schema is a
ref Sah builtin type.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_ref_builtin_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    [200, "OK", Data::Sah::Util::Type::is_ref($args{schema})];
}

$SPEC{is_sah_ref_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a ref Sah type',
    description => <<'_',

The difference from this and `is_sah_ref_builtin_type` is: if type is not
a known builtin type, this routine will try to resolve the schema using
<pm:Data::Sah::Resolve> then try again.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_ref_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    my $res;
    if (Data::Sah::Util::Type::is_type($args{schema})) {
        $res = Data::Sah::Util::Type::is_ref($args{schema});
    } else {
        require Data::Sah::Resolve;
        eval { $res = Data::Sah::Resolve::resolve_schema($args{schema}) };
        unless ($@) {
            $res = Data::Sah::Util::Type::is_ref($res);
        }
    }

    [200, "OK", $res];
}

$SPEC{is_sah_numeric_builtin_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a Sah numeric builtin type',
    description => <<'_',

Uses <pm:Data::Sah::Util::Type>'s `is_ref()` to check whether the schema is a
numeric Sah builtin type.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_numeric_builtin_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    [200, "OK", Data::Sah::Util::Type::is_numeric($args{schema})];
}

$SPEC{is_sah_numeric_type} = {
    v => 1.1,
    summary => 'Check that a string or array schema is a numeric Sah type',
    description => <<'_',

The difference from this and `is_sah_numeric_builtin_type` is: if type is not a
known builtin type, this routine will try to resolve the schema using
<pm:Data::Sah::Resolve> then try again.

_
    args => {
        schema => {
            schema => 'any*', # XXX 'sah::schema*' still causes deep recursion
            req => 1,
            pos => 0,
        },
    },
};
sub is_sah_numeric_type {
    require Data::Sah::Util::Type;

    my %args = @_;
    my $res;
    if (Data::Sah::Util::Type::is_type($args{schema})) {
        $res = Data::Sah::Util::Type::is_numeric($args{schema});
    } else {
        require Data::Sah::Resolve;
        eval { $res = Data::Sah::Resolve::resolve_schema($args{schema}) };
        unless ($@) {
            $res = Data::Sah::Util::Type::is_numeric($res);
        }
    }

    [200, "OK", $res];
}

1;
# ABSTRACT: Collection of CLI utilities for Sah and Data::Sah

=head1 SYNOPSIS

This distribution provides the following command-line utilities related to
L<Sah> and L<Data::Sah>:

#INSERT_EXECS_LIST


=head1 SEE ALSO

L<Data::Sah>

=cut
