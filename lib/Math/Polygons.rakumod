unit module Math::Polygons:ver<0.0.5>:auth<Steve Roe (p6steve@furnival.net)>;
use SVG;

role Element is export {
    method serialize() {
        ... 
    }   
}   
role Styled is export {
    has Str $.fill   = 'red';
    has Str $.stroke = 'blue';
    has Int $.stroke-width = 3;

    method styles() {
        (:$!stroke, stroke-width => $!stroke-width,
         fill => $!fill ).grep( { .value.defined } );
    }   
}   

class Drawing is export {
    has Element @.elements;

    has Int $.width = 1024;
    has Int $.height = 768;

    method dimensions() {
        ( height => $!height, width => $!width ).grep( { .value.defined } );
    }
    method serialize( --> Str ) {
        SVG.serialize(svg =>  [ |self.dimensions, |@!elements.map(-> $e { $e.serialize })]);
    }
}
class Group does Element is export {
    has Element @.elements;
    method serialize( --> Pair ) { 
        g => @!elements.map( -> $e { $e.serialize }).list;
    }   
}   
class Point is export {
    has $.x;
    has $.y;

    multi method new($x, $y) {
        self.bless(:$x, :$y);
    } 
    #|Preserve container object for print & labels
    method Str( --> Str ) { 
        return "$!x, $!y";
    }   
    #|Strip container object for rendering drawing
    method serialize( --> Str ) { 
        return "{$!x.Real},{$!y.Real}";
    }
}   
class Polygon does Element does Styled is export {
    has Point @.points;

    method serialize( --> Pair ) {
        polygon => [ points => @.points.map( -> $p { $p.serialize } ).join(' '), |self.styles ];
    }   
}

#|only doing Isosceles Triangles for now
class Triangle is Polygon is export {
    has Point $.apex is required;
    has       $.side is required;
    has       $.inverted;

    method points() {
        ($!apex, |self.base-points)
    }   
    method base-points() {
        my $y = $!apex.y + self.height;
        my \A = Point.new(:$y, x => $!apex.x - ( $!side / 2 ));
        my \C = Point.new(:$y, x => $!apex.x + ( $!side / 2 ));
        return( A, C );
    }   
    method height() {
        my $sign = $!inverted ?? -1 !! +1;
        $sign * sqrt($!side**2 - ($!side/2)**2)
    }   
    method base() { 
        $!side 
    }   
    method area( ) { 
        ( $.height * $.base ) / 2 
    }   
}

class Quadrilateral is Polygon is export {
    has Point @.points;

    multi method new( \A, \B, \C, \D ) {
        self.bless( points => ( A, B, C, D ) );
    }
    method A { @!points[0] };
    method B { @!points[1] };
    method C { @!points[2] };
    method D { @!points[3] };

    method area( ) { 
        warn "I am not smart enough to figure this out!"; 
    }   
}

class Rectangle does Element does Styled is export {
    has Point $.origin;
    has       $.width;
    has       $.height;

    method serialize( --> Pair ) { 
        rect => [ x => $!origin.x.Real, y=> $!origin.y.Real,   \
                    width => $!width.Real, height => $!height.Real, |self.styles ];
    }   
    method area() { 
        $.height * $.width 
    }   
}

class Square is Rectangle is export {
    has Point $.origin;
    has       $.side;

    method serialize( --> Pair ) { 
        rect => [ x => $!origin.x.Real, y => $!origin.y.Real,   \
                    width => $!side.Real, height => $!side.Real, |self.styles ];
    }   
    method area() { 
        $.side ** 2 
    }   
}

class Circle does Element does Styled is export {
    has Point $.centre;
    has       $.radius;


#    <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
#            <circle cx="50" cy="50" r="50"/>
#</svg>

#    method serialize( --> Pair ) {
#        polygon => [ points => @.points.map( -> $p { $p.serialize } ).join(' '), |self.styles ];
#    }

    method serialize( --> Pair ) {
        circle => [ cx => $!centre.x.Real, cy => $!centre.y.Real, r => $!radius.Real, |self.styles ];
    }
}

#EOF

