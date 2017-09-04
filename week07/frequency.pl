#!/usr/bin/perl -w 

sub totalWords {
   my $num_words = 0;
   open my $F, "<", "$_[0]" or die;  
 
   while($line = <$F>) {
      undef my @words;

      $line =~ s/^[^a-zA-Z]+//;
      @words = split(/[^a-zA-Z]+/, $line);
      $num_words += @words;
   }

   close $F;
   return $num_words;
}

sub countWord {
   my $word = $_[0];
   open my $F, "<", "$_[1]" or die;

   my $count = 0;

   while($line = <$F>) {
      undef my @words;
      $line = lc $line;
   
      @words = ($line =~ /\b$word\b/g);
      $count += @words;
   }

   close $F;
   return $count;
}

$word = lc $ARGV[0];

foreach $file (glob "lyrics/*.txt") {
   $total = totalWords($file);
   $count = countWord($word, $file);  

   $file =~ s/lyrics\/(.*).txt/$1/;
   $file =~ s/[^a-zA-Z]/ /g;
   $name = $file;

   $table{$name}{"total"} = $total;
   $table{$name}{$word} = $count;
}

foreach $artist (sort keys %table) {
   printf "%4d/%6d = %.9f %s\n", $table{$artist}{$word}, $table{$artist}{"total"}, $table{$artist}{$word}/$table{$artist}{"total"}, $artist;
} 