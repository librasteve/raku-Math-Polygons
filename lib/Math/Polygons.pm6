unit module Math::Polygons:ver<0.0.2>:auth<Steve Roe (p6steve@furnival.net)>;

use Math::Polygons::Drawing;

class Triangle is Polygon is export {
    has Point $.apex is required;
    has Int   $.side is required;

    method points() {
        ($!apex, |self.base-points);
    }   

    method base-points() {
        my $y = $!apex.y + self.get-height;
        (Point.new(:$y, x => $!apex.x - ( $!side / 2 )), Point.new(:$y, x => $!apex.x + ( $!side / 2 )));
    }   

    method get-height(--> Num ) { 
        sqrt($!side**2 - ($!side/2)**2)
    }   
}

class Quadrilateral is Polygon is export {
    has Point @.points;

    multi method new( \A, \B, \C, \D ) {
        self.bless( points => ( A, B, C, D ) );
    }
    method A { return "@!points[0]" };
    method B { return "@!points[1]" };
    method C { return "@!points[2]" };
    method D { return "@!points[3]" };
}

class Rectangle is Quadrilateral is export {
    has Point $.origin;
    has Int $.width;
    has Int $.height;

    method serialize( --> Pair) {
        rect => [ x =>  $!origin.x, y => $!origin.y, width => $!width, height => $!height, |self.styles ];
    }
}

class Square is Rectangle is export {
    has Point $.origin;
    has Int $.side;

    method serialize( --> Pair) {
        rect => [ x =>  $!origin.x, y => $!origin.y, width => $!side, height => $!side, |self.styles ];
    }
}
