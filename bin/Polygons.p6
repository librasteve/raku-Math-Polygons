#!/usr/bin/env perl6
use lib '../lib';
use Math::Polygons;

my $rectangle = Rectangle.new( 
    origin => Point.new(20, 20),
    width => 120, 
    height => 80 
);

my $square = Square.new( 
    origin => Point.new(160, 20),
    side => 100 
);

my $quadrilateral = Quadrilateral.new(
    Point.new(20, 260),
    Point.new(30, 160),
    Point.new(120, 145),
    Point.new(125, 250),
);
my $q := $quadrilateral;
say "Quad Points are: ({$q.A}), ({$q.B}), ({$q.C}), ({$q.D})";

my $apex = Point.new(x => 200, y => 160),
my $triangle = Triangle.new( apex => $apex, side => 100 );

my $drawing = Drawing.new( elements => [ 
    $quadrilateral,
    $rectangle, 
    $square, 
    $triangle,
]);
$drawing.serialize.say;

say "Quadrilateral Area: {$quadrilateral.area}";
say "Rectangle Area:     {$rectangle.area}";
say "Square Area:        {$square.area}";
say "Triangle Area:      {$triangle.area}";
