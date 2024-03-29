# raku-Math-Polygons
Some polygon objects that draw via SVG - an alpha with the potential to do inheritance of Parallelograms, Rhomboids, etc.

![Build Status](https://github.com/librasteve/raku-math-polygons/actions/workflows/action.yml/badge.svg)

# Instructions
There are three ways to consume this module:
1. Jupyter Notebook local
- Clone this repo locally on your machine
- Do the Quick Start here Brian Duggan perl6 jupyter-notebook at <https://github.com/bduggan/p6-jupyter-kernel>
- From the root directory run *jupyter-notebook*
2. Jupyter Notebook hosted on Binder
- Click this badge => [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/librasteve/perl6-Math-Polygons/master)
- Go to /eg and click Polygons.ipynb, then Run
- If you are the first to build e.g. a new version this can take 24 mins or so and the Binder browser UI may lose hope - please just be patient (do not reload as this restarts the build)
- If not, go to <mybinder.org> and paste this url <https://github.com/librasteve/perl6-Math-Polygons>, then the ./Dockerfile will be used to (re)build and run on Jupyter at Binder
3. Perl6 Module
- *zef install Math::Polygons*

# Synopsis
```perl6
use Math::Polygons;

my $rectangle = Rectangle.new( 
    origin => Point.new(20, 20),
    width  => 120, 
    height => 80  
);

my $square = Square.new( 
    origin => Point.new(170, 20),
    side   => 100 
);

my \A = Point.new( 20, 260);
my \B = Point.new( 30, 200);
my \C = Point.new(120, 145);
my \D = Point.new(125, 250);
my $quadrilateral = Quadrilateral.new(
    A, B, C, D,  
);

my $triangle = Triangle.new(
    fill => "green",
    stroke => "black",
    apex => Point.new(220, 160),
    side => 100 
);

my $drawing = Drawing.new( 
    elements => [ 
        $rectangle, 
        $square,
        $quadrilateral,
        $triangle,
    ],
);
$drawing.serialize.say;
```

# Inspired by
* Brian Duggan's perl6 jupyter-notebook at <https://github.com/bduggan/p6-jupyter-kernel>
* Jonathan Stowe's perl6 advent calendar [Christmas Tree](https://perl6advent.wordpress.com/2018/12/18/day-18-an-svg-christmas-tree/)
