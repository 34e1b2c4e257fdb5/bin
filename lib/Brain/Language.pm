use v5.14;

package Brain::Language {
    use strict;
    use utf8;
    use List::MoreUtils qw(natatime);
    use Lingua::Sentence;
    use String::Trim ();

    #
    # Trim off extra whitespaces around the text.
    #
    sub trim {
        my ($self, $text) = @_;
        return String::Trim::trim($text);
    }

    sub sentences {
        my ($self, $text) = @_;
        my $splitter = Lingua::Sentence->new('en');

        $text = $self->trim($text);

        my @result;
        my $iter = natatime 2, split(/(\x{a0}+|\n\n+|？\」|。\」|！\」|。(?!\」))/, $text);

        while (my @vals = $iter->()) {
            local $_ = join "", @vals;
            s/( \A\s+ | \s+\Z )//uxg;
            push @result, $splitter->split_array($_);
        }

        return @result;
    }
};

1;
