unit module FiniteField;

multi postfix:<⁻¹>(UInt $n) returns UInt is export {
  my ($i, $h, $v, $d) = $*modulus, $n, 0, 1;
  repeat {
    my $t = $i div $h;
    my $x = $h;
    $h = $i - $t*$x;
    $i = $x;
    $x = $d;
    $d = $v - $t*$x;
    $v = $x;
  } while $h > 0;
  $v mod $*modulus;
}

multi infix:</>(Int $a, UInt $b) returns UInt is export { $a*$b⁻¹ mod $*modulus }

{
  multi infix:<==>(UInt $a, UInt $b)          is export { callwith $a - $b, 0 }
  multi infix:<+> (UInt $a, UInt $b --> UInt) is export { callsame() mod $*modulus }
  multi infix:<*> (UInt $a, UInt $b --> UInt) is export { callsame() mod $*modulus }
  multi infix:<**>(UInt $a, UInt $b --> UInt) is export { expmod $a, $b, $*modulus }

  {
    multi prefix:<->(UInt $n          --> UInt) is export { callsame() mod $*modulus }
    multi infix:<-> (UInt $a, UInt $b --> UInt) is export { callsame() mod $*modulus }
  }
}
