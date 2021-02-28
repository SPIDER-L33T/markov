#!/usr/bin/perl
use warnings;
use strict;
use utf8;

binmode(STDOUT,':utf8');

my $dir = 'books';
my @books = ();
opendir(DIR, $dir) or die $!;
while (my $file = readdir(DIR)) {
	next if ($file =~ m/^\./);
	push @books, $file;
}
closedir(DIR);

my $txt = "";
foreach my $fname (@books){
  open (my $info, '<:encoding(utf-8)', $dir."/".$fname) or die "Could not open $dir."/".$fname: $!";
	print "\nЧитаю книгу $fname и запоминаю...\n";
	while( my $line = <$info>)  {
		$line =~ s/[^-а-я-А-Я\d !\?\.\,]//g;
		$txt .= " ".$line;
	}
	my @sarray = ($txt =~ /([A-ZА-ЯЁ].*?\.)/g);
	close $info;
}

my @warr = split(' ', $txt);
my $size = scalar @warr;

# Набор цепочек слов
my %chains;
# Массив первых слов (с заглавной буквы):
my @bigw;
print "\nСтрою цепочки...\n";
for(my $i = 0; $i<$size; $i++){
  my @tmparray;
  if(defined $warr[$i+1]){
    if($warr[$i+1] ne ''){
      push @{ $chains{$warr[$i]} }, $warr[$i+1];
    }
  }
}

foreach my $ww (@warr){
  if ($ww =~ m/^[А-Я].*/){
    push @bigw, $ww;
  }
}
my $sb = scalar @bigw;
print "\nГотово!\n";

print "\nГенерируем предложения...\n";
my $text = '';
my $grand = int(rand($sb-1));
$text = $text.$bigw[$grand];

if(scalar @{$chains{$bigw[$grand]}} > 0){
  my $srand = int(rand(scalar @{$chains{$bigw[$grand]}}))-1;
  $text = $text." ".$chains{$bigw[$grand]}[$srand];
  my $second = $chains{$bigw[$grand]}[$srand];
  my $scnt = scalar @{ $chains{$second} };
  if($scnt > 0){
    my $srand = int(rand($scnt))-1;
    $text = $text." ".$chains{$second}[$srand];

    my $third = $chains{$second}[$srand];
    my $tcnt = scalar @{$chains{$third}};
    if($tcnt > 0){
      my $srand = int(rand(scalar @{$chains{$third}}));

      $text = $text." ".$chains{$third}[$srand];
      my $nnw = $chains{$third}[$srand];
      print $text;
      for(my $k=0; $k< 50; $k++){
        $nnw = genword($nnw);
        print " ";
        print $nnw;
        last if ($nnw =~ m/[А-яа-я].*[\.!\?]$/);
      }
    }
  }
}

print "\n";

sub genword{
  my ($cword) = @_;
  my $nword = "";
  my $ncnt = scalar @{ $chains{$cword} };
  my $nrand = int(rand($ncnt))-1;
  $nword = $chains{$cword}[$nrand];
  return $nword;
}
